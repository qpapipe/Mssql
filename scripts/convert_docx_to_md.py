# Trigger conversion on pull request opening.
from pathlib import Path
import re, subprocess
from urllib.parse import quote
from docx import Document
from docx.oxml.ns import qn
from docx.text.paragraph import Paragraph
from docx.table import Table

ROOT = Path(__file__).resolve().parents[1]
FENCE = chr(96) * 3
SQL = re.compile(r"^(SELECT|WITH|CREATE|ALTER|DROP|INSERT|UPDATE|DELETE|MERGE|USE|SET|EXEC(?:UTE)?|DECLARE|BEGIN|PRINT|TRUNCATE|GO)\b", re.I)
def code(s): return chr(96) + str(s).replace(chr(96), "'") + chr(96)

def blocks(parent):
    el = getattr(parent, "_element", getattr(parent, "element", None))
    for ch in el.iterchildren():
        if ch.tag == qn("w:p"): yield Paragraph(ch, parent)
        elif ch.tag == qn("w:tbl"): yield Table(ch, parent)

def ids(el):
    out = []
    for node in el.iter():
        if node.tag == qn("a:blip"):
            rid = node.get(qn("r:embed"))
            if rid: out.append(rid)
        elif node.tag == qn("v:imagedata"):
            rid = node.get(qn("r:id"))
            if rid: out.append(rid)
    return list(dict.fromkeys(out))

def ocr(path):
    try:
        x = subprocess.run(["tesseract", str(path), "stdout", "-l", "eng+rus"], capture_output=True, text=True, timeout=20)
        if x.returncode: x = subprocess.run(["tesseract", str(path), "stdout", "-l", "eng"], capture_output=True, text=True, timeout=20)
        return re.sub(r"\s+", " ", x.stdout or "").strip()
    except (FileNotFoundError, subprocess.TimeoutExpired): return ""

def caption(s):
    s = re.sub(r"\s+", " ", s or "").strip()
    if not s: return "Иллюстрация из практической работы по Microsoft SQL Server."
    m = re.search(r"\bCREATE\s+(?:OR\s+ALTER\s+)?VIEW\s+([\w.\[\]]+)", s, re.I)
    if m:
        tables = list(dict.fromkeys(t.strip("[]") for t in re.findall(r"\b(?:FROM|JOIN)\s+([\w.\[\]]+)", s, re.I)))
        return "Создание представления " + code(m.group(1).strip("[]")) + (("; используются таблицы " + ", ".join(code(t) for t in tables[:4])) if tables else "") + "."
    m = re.search(r"\bCREATE\s+(?:OR\s+ALTER\s+)?TRIGGER\s+([\w.\[\]]+)", s, re.I)
    if m:
        n = m.group(1).strip("[]")
        t = re.search(r"\bON\s+([\w.\[\]]+)", s, re.I)
        e = re.search(r"\b(AFTER|INSTEAD\s+OF)\s+(INSERT|UPDATE|DELETE)", s, re.I)
        if re.search(r"\bON\s+DATABASE\b", s, re.I):
            if re.search(r"\bDROP_TABLE\b", s, re.I): return "DDL-триггер " + code(n) + " запрещает удаление таблиц с помощью ROLLBACK."
            return "DDL-триггер " + code(n) + " реагирует на события уровня базы данных."
        out = "Триггер " + code(n)
        if t: out += " для таблицы " + code(t.group(1).strip("[]"))
        if e: out += " после операции " + e.group(2).upper()
        if re.search(r"\bPRINT\b", s, re.I): out += " выводит информационное сообщение"
        return out + "."
    m = re.search(r"\bCREATE\s+(?:(?:NONCLUSTERED|CLUSTERED)\s+)?INDEX\s+([\w\[\]]+)", s, re.I)
    if m: return "Создание индекса " + code(m.group(1).strip("[]")) + " для ускорения поиска."
    m = re.search(r"\bINSERT\s+INTO\s+([\w.\[\]]+)", s, re.I)
    if m: return "Добавление тестовой записи в таблицу " + code(m.group(1).strip("[]")) + "."
    if re.search(r"\bSTATISTICS\s+(IO|TIME)\b", s, re.I): return "Включение статистики SQL Server для сравнения чтений и времени выполнения."
    if re.search(r"\bSELECT\b", s, re.I):
        if re.search(r"\bWHERE\s+.*\bEMAIL\b", s, re.I): return "Запрос выбирает клиента по адресу электронной почты."
        if re.search(r"\bGROUP\s+BY\b", s, re.I): return "Запрос группирует записи и рассчитывает агрегированные значения."
        if re.search(r"\bJOIN\b", s, re.I): return "Запрос объединяет данные из нескольких таблиц."
        if re.search(r"\bWHERE\b", s, re.I): return "Запрос выбирает строки по условию WHERE."
        return "Пример запроса SELECT для чтения данных."
    if re.search(r"\bCREATE\s+TABLE\b", s, re.I): return "Создание таблицы и определение её столбцов."
    return "Фрагмент SQL-кода: " + code(s[:100] + ("..." if len(s)>100 else "")) + "."

def export(doc, source):
    folder = source.parent / "images"
    folder.mkdir(parents=True, exist_ok=True)
    rels = {rid: rel.target_part for rid,rel in doc.part.rels.items() if "image" in rel.reltype}
    order = []
    for node in doc.element.body.iter():
        if node.tag == qn("a:blip"): rid = node.get(qn("r:embed"))
        elif node.tag == qn("v:imagedata"): rid = node.get(qn("r:id"))
        else: continue
        if rid and rid not in order: order.append(rid)
    order.extend(rid for rid in rels if rid not in order)
    slug = re.sub(r"[^A-Za-z0-9_-]+", "-", source.stem).strip("-").lower() or "document"
    result = {}
    for rid in order:
        part = rels.get(rid)
        if part is None: continue
        ext = {"image/jpeg":".jpg","image/png":".png","image/gif":".gif","image/bmp":".bmp","image/tiff":".tif","image/svg+xml":".svg"}.get(getattr(part,"content_type","image/png"),".png")
        dest = folder / (slug + "_screenshot_" + str(len(result)+1).zfill(2) + ext)
        dest.write_bytes(part.blob)
        result[rid] = {"path":dest.relative_to(source.parent).as_posix(),"caption":caption(ocr(dest) if ext!=".svg" else "")}
    return result

def para(p, images):
    out=[]; text=(p.text or "").strip(); style=(p.style.name if p.style else "").lower()
    if text:
        if "title" in style: out.append("# "+text)
        elif "heading 1" in style or "заголовок 1" in style: out.append("## "+text)
        elif "heading 2" in style or "заголовок 2" in style: out.append("### "+text)
        elif "heading 3" in style or "заголовок 3" in style: out.append("#### "+text)
        elif "list bullet" in style or "маркер" in style: out.append("- "+text)
        elif "list number" in style or "нумерац" in style: out.append("1. "+text)
        elif "code" in style or "код" in style or SQL.match(text): out.append(FENCE+"sql\n"+text+"\n"+FENCE)
        else: out.append(text)
    for rid in ids(p._p):
        im=images.get(rid)
        if im: out.append("**Описание скриншота:** "+im["caption"]+"\n\n!["+im["caption"]+"]("+im["path"]+")")
    return "\n\n".join(out)

def table_md(t, images):
    rows=[]
    for row in t.rows:
        vals=[]
        for cell in row.cells:
            p=[]
            for b in blocks(cell):
                x=para(b,images) if isinstance(b,Paragraph) else table_md(b,images)
                if x.strip(): p.append(x)
            vals.append(" ".join(p).replace("|",r"\|").replace("\n","<br>"))
        rows.append(vals)
    if not rows: return ""
    n=max(map(len,rows)); rows=[r+[""]*(n-len(r)) for r in rows]
    return "\n".join(["| "+" | ".join(rows[0])+" |","| "+" | ".join(["---"]*n)+" |"]+["| "+" | ".join(r)+" |" for r in rows[1:]])

def convert(source):
    doc=Document(source); images=export(doc,source); parts=[]
    for block in blocks(doc):
        x=para(block,images) if isinstance(block,Paragraph) else table_md(block,images)
        if x.strip(): parts.append(x.strip())
    text="\n\n".join(parts)
    refs=set(re.findall(r"!\[[^\]]*\]\(([^)]+)\)",text))
    for im in images.values():
        if im["path"] not in refs: parts.append("**Описание скриншота:** "+im["caption"]+"\n\n!["+im["caption"]+"]("+im["path"]+")")
    if not parts: parts=["# "+source.stem,"Материал состоит преимущественно из скриншотов; каждому изображению добавлено описание."]
    text="\n\n".join(parts).strip()+"\n"
    target=source.with_suffix(".md"); target.write_text(text,encoding="utf-8")
    if target.stat().st_size<30: raise RuntimeError("Markdown-файл пуст: "+str(target))
    for rel in re.findall(r"!\[[^\]]*\]\(([^)]+)\)",text):
        if not (source.parent/rel).is_file(): raise RuntimeError("Не найден скриншот "+rel)
    return target,len(images)

def main():
    docs=sorted(ROOT.rglob("*.docx"))
    if not docs: raise RuntimeError("Word-файлы не найдены — удаление отменено.")
    done=[]
    for src in docs:
        md,n=convert(src); done.append((src,md,n))
        print("Converted "+str(src.relative_to(ROOT))+"; screenshots="+str(n))
    for folder in sorted({s.parent for s,_,_ in done}):
        lines=["# Материалы: "+folder.name,"","Практические работы по Microsoft SQL Server.",""]
        for _,md,n in [x for x in done if x[0].parent==folder]:
            lines.append("- ["+md.name+"]("+quote(md.name,safe="._-")+") — Markdown-версия; скриншотов: "+str(n)+".")
        (folder/"readme.md").write_text("\n".join(lines)+"\n",encoding="utf-8")
        old=folder/"read.md"
        if old.exists() and old.stat().st_size==0: old.unlink()
    lines=["# Mssql","","Учебные материалы по Microsoft SQL Server: запросы, представления, индексы, триггеры и анализ данных.","","Документы преобразованы в Markdown, скриншоты вынесены в папки images и сопровождаются пояснениями. Оригинальные Word-файлы удалены после проверки конвертации и ссылок на изображения.","","## Содержание",""]
    for _,md,n in done: lines.append("- ["+md.parent.name+"/"+md.name+"]("+quote(md.relative_to(ROOT).as_posix(),safe="/._-")+") — скриншотов: "+str(n)+".")
    (ROOT/"README.md").write_text("\n".join(lines)+"\n",encoding="utf-8")
    for src,_,_ in done: src.unlink()
    for rel in [".github/workflows/convert-docs.yml","scripts/convert_docx_to_md.py"]:
        p=ROOT/rel
        if p.exists(): p.unlink()
    print("SUCCESS: converted "+str(len(done))+" Word files; originals removed after validation.")

if __name__=="__main__": main()
