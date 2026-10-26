-- DROP SCHEMA app;

CREATE SCHEMA app;
-- ShopDB_T09.app.Customers определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Customers;

CREATE TABLE ShopDB_T09.app.Customers (
	CustomerID int IDENTITY(1,1) NOT NULL,
	TenantID int NOT NULL,
	Region nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Email nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CreatedAt datetime2 DEFAULT sysutcdatetime() NOT NULL,
	CONSTRAINT PK__Customer__A4AE64B801FC6E71 PRIMARY KEY (CustomerID)
);


-- ShopDB_T09.app.Categories определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Categories;

CREATE TABLE ShopDB_T09.app.Categories (
	CategoryID int IDENTITY(1,1) NOT NULL,
	ParentID int NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Categori__19093A2B74E3D7D9 PRIMARY KEY (CategoryID),
	CONSTRAINT FK__Categorie__Paren__4CA06362 FOREIGN KEY (ParentID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.Orders определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Orders;

CREATE TABLE ShopDB_T09.app.Orders (
	OrderID int IDENTITY(1,1) NOT NULL,
	CustomerID int NOT NULL,
	OrderDate date NOT NULL,
	Status nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Total decimal(18,2) DEFAULT 0 NOT NULL,
	CONSTRAINT PK__Orders__C3905BAFE984BE31 PRIMARY KEY (OrderID),
	CONSTRAINT FK__Orders__Customer__5629CD9C FOREIGN KEY (CustomerID) REFERENCES ShopDB_T09.app.Customers(CustomerID)
);
CREATE NONCLUSTERED INDEX IX_Orders_Customer_Status ON ShopDB_T09.app.Orders (CustomerID, Status) INCLUDE (OrderDate, Total);


-- ShopDB_T09.app.Payments определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Payments;

CREATE TABLE ShopDB_T09.app.Payments (
	PaymentID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	PaidAt datetime2 NOT NULL,
	Amount decimal(18,2) NOT NULL,
	CONSTRAINT PK__Payments__9B556A5844868BAC PRIMARY KEY (PaymentID),
	CONSTRAINT FK__Payments__OrderI__5DCAEF64 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID)
);


-- ShopDB_T09.app.Products определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Products;

CREATE TABLE ShopDB_T09.app.Products (
	ProductID int IDENTITY(1,1) NOT NULL,
	CategoryID int NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__Products__B40CC6EDE346B049 PRIMARY KEY (ProductID),
	CONSTRAINT FK__Products__Catego__4F7CD00D FOREIGN KEY (CategoryID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.OrderDetails определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.OrderDetails;

CREATE TABLE ShopDB_T09.app.OrderDetails (
	OrderDetailID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	ProductID int NOT NULL,
	Qty int NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__OrderDet__D3B9D30C9D878F9D PRIMARY KEY (OrderDetailID),
	CONSTRAINT FK__OrderDeta__Order__59FA5E80 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID),
	CONSTRAINT FK__OrderDeta__Produ__5AEE82B9 FOREIGN KEY (ProductID) REFERENCES ShopDB_T09.app.Products(ProductID)
);

-- DROP SCHEMA app;

CREATE SCHEMA app;
-- ShopDB_T09.app.Customers определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Customers;

CREATE TABLE ShopDB_T09.app.Customers (
	CustomerID int IDENTITY(1,1) NOT NULL,
	TenantID int NOT NULL,
	Region nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Email nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CreatedAt datetime2 DEFAULT sysutcdatetime() NOT NULL,
	CONSTRAINT PK__Customer__A4AE64B801FC6E71 PRIMARY KEY (CustomerID)
);


-- ShopDB_T09.app.Categories определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Categories;

CREATE TABLE ShopDB_T09.app.Categories (
	CategoryID int IDENTITY(1,1) NOT NULL,
	ParentID int NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Categori__19093A2B74E3D7D9 PRIMARY KEY (CategoryID),
	CONSTRAINT FK__Categorie__Paren__4CA06362 FOREIGN KEY (ParentID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.Orders определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Orders;

CREATE TABLE ShopDB_T09.app.Orders (
	OrderID int IDENTITY(1,1) NOT NULL,
	CustomerID int NOT NULL,
	OrderDate date NOT NULL,
	Status nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Total decimal(18,2) DEFAULT 0 NOT NULL,
	CONSTRAINT PK__Orders__C3905BAFE984BE31 PRIMARY KEY (OrderID),
	CONSTRAINT FK__Orders__Customer__5629CD9C FOREIGN KEY (CustomerID) REFERENCES ShopDB_T09.app.Customers(CustomerID)
);
CREATE NONCLUSTERED INDEX IX_Orders_Customer_Status ON ShopDB_T09.app.Orders (CustomerID, Status) INCLUDE (OrderDate, Total);


-- ShopDB_T09.app.Payments определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Payments;

CREATE TABLE ShopDB_T09.app.Payments (
	PaymentID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	PaidAt datetime2 NOT NULL,
	Amount decimal(18,2) NOT NULL,
	CONSTRAINT PK__Payments__9B556A5844868BAC PRIMARY KEY (PaymentID),
	CONSTRAINT FK__Payments__OrderI__5DCAEF64 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID)
);


-- ShopDB_T09.app.Products определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Products;

CREATE TABLE ShopDB_T09.app.Products (
	ProductID int IDENTITY(1,1) NOT NULL,
	CategoryID int NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__Products__B40CC6EDE346B049 PRIMARY KEY (ProductID),
	CONSTRAINT FK__Products__Catego__4F7CD00D FOREIGN KEY (CategoryID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.OrderDetails определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.OrderDetails;

CREATE TABLE ShopDB_T09.app.OrderDetails (
	OrderDetailID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	ProductID int NOT NULL,
	Qty int NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__OrderDet__D3B9D30C9D878F9D PRIMARY KEY (OrderDetailID),
	CONSTRAINT FK__OrderDeta__Order__59FA5E80 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID),
	CONSTRAINT FK__OrderDeta__Produ__5AEE82B9 FOREIGN KEY (ProductID) REFERENCES ShopDB_T09.app.Products(ProductID)
);

-- DROP SCHEMA app;

CREATE SCHEMA app;
-- ShopDB_T09.app.Customers определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Customers;

CREATE TABLE ShopDB_T09.app.Customers (
	CustomerID int IDENTITY(1,1) NOT NULL,
	TenantID int NOT NULL,
	Region nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Email nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CreatedAt datetime2 DEFAULT sysutcdatetime() NOT NULL,
	CONSTRAINT PK__Customer__A4AE64B801FC6E71 PRIMARY KEY (CustomerID)
);


-- ShopDB_T09.app.Categories определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Categories;

CREATE TABLE ShopDB_T09.app.Categories (
	CategoryID int IDENTITY(1,1) NOT NULL,
	ParentID int NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Categori__19093A2B74E3D7D9 PRIMARY KEY (CategoryID),
	CONSTRAINT FK__Categorie__Paren__4CA06362 FOREIGN KEY (ParentID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.Orders определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Orders;

CREATE TABLE ShopDB_T09.app.Orders (
	OrderID int IDENTITY(1,1) NOT NULL,
	CustomerID int NOT NULL,
	OrderDate date NOT NULL,
	Status nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Total decimal(18,2) DEFAULT 0 NOT NULL,
	CONSTRAINT PK__Orders__C3905BAFE984BE31 PRIMARY KEY (OrderID),
	CONSTRAINT FK__Orders__Customer__5629CD9C FOREIGN KEY (CustomerID) REFERENCES ShopDB_T09.app.Customers(CustomerID)
);
CREATE NONCLUSTERED INDEX IX_Orders_Customer_Status ON ShopDB_T09.app.Orders (CustomerID, Status) INCLUDE (OrderDate, Total);


-- ShopDB_T09.app.Payments определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Payments;

CREATE TABLE ShopDB_T09.app.Payments (
	PaymentID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	PaidAt datetime2 NOT NULL,
	Amount decimal(18,2) NOT NULL,
	CONSTRAINT PK__Payments__9B556A5844868BAC PRIMARY KEY (PaymentID),
	CONSTRAINT FK__Payments__OrderI__5DCAEF64 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID)
);


-- ShopDB_T09.app.Products определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Products;

CREATE TABLE ShopDB_T09.app.Products (
	ProductID int IDENTITY(1,1) NOT NULL,
	CategoryID int NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__Products__B40CC6EDE346B049 PRIMARY KEY (ProductID),
	CONSTRAINT FK__Products__Catego__4F7CD00D FOREIGN KEY (CategoryID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.OrderDetails определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.OrderDetails;

CREATE TABLE ShopDB_T09.app.OrderDetails (
	OrderDetailID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	ProductID int NOT NULL,
	Qty int NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__OrderDet__D3B9D30C9D878F9D PRIMARY KEY (OrderDetailID),
	CONSTRAINT FK__OrderDeta__Order__59FA5E80 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID),
	CONSTRAINT FK__OrderDeta__Produ__5AEE82B9 FOREIGN KEY (ProductID) REFERENCES ShopDB_T09.app.Products(ProductID)
);

-- DROP SCHEMA app;

CREATE SCHEMA app;
-- ShopDB_T09.app.Customers определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Customers;

CREATE TABLE ShopDB_T09.app.Customers (
	CustomerID int IDENTITY(1,1) NOT NULL,
	TenantID int NOT NULL,
	Region nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Email nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CreatedAt datetime2 DEFAULT sysutcdatetime() NOT NULL,
	CONSTRAINT PK__Customer__A4AE64B801FC6E71 PRIMARY KEY (CustomerID)
);


-- ShopDB_T09.app.Categories определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Categories;

CREATE TABLE ShopDB_T09.app.Categories (
	CategoryID int IDENTITY(1,1) NOT NULL,
	ParentID int NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Categori__19093A2B74E3D7D9 PRIMARY KEY (CategoryID),
	CONSTRAINT FK__Categorie__Paren__4CA06362 FOREIGN KEY (ParentID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.Orders определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Orders;

CREATE TABLE ShopDB_T09.app.Orders (
	OrderID int IDENTITY(1,1) NOT NULL,
	CustomerID int NOT NULL,
	OrderDate date NOT NULL,
	Status nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Total decimal(18,2) DEFAULT 0 NOT NULL,
	CONSTRAINT PK__Orders__C3905BAFE984BE31 PRIMARY KEY (OrderID),
	CONSTRAINT FK__Orders__Customer__5629CD9C FOREIGN KEY (CustomerID) REFERENCES ShopDB_T09.app.Customers(CustomerID)
);
CREATE NONCLUSTERED INDEX IX_Orders_Customer_Status ON ShopDB_T09.app.Orders (CustomerID, Status) INCLUDE (OrderDate, Total);


-- ShopDB_T09.app.Payments определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Payments;

CREATE TABLE ShopDB_T09.app.Payments (
	PaymentID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	PaidAt datetime2 NOT NULL,
	Amount decimal(18,2) NOT NULL,
	CONSTRAINT PK__Payments__9B556A5844868BAC PRIMARY KEY (PaymentID),
	CONSTRAINT FK__Payments__OrderI__5DCAEF64 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID)
);


-- ShopDB_T09.app.Products определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Products;

CREATE TABLE ShopDB_T09.app.Products (
	ProductID int IDENTITY(1,1) NOT NULL,
	CategoryID int NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__Products__B40CC6EDE346B049 PRIMARY KEY (ProductID),
	CONSTRAINT FK__Products__Catego__4F7CD00D FOREIGN KEY (CategoryID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.OrderDetails определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.OrderDetails;

CREATE TABLE ShopDB_T09.app.OrderDetails (
	OrderDetailID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	ProductID int NOT NULL,
	Qty int NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__OrderDet__D3B9D30C9D878F9D PRIMARY KEY (OrderDetailID),
	CONSTRAINT FK__OrderDeta__Order__59FA5E80 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID),
	CONSTRAINT FK__OrderDeta__Produ__5AEE82B9 FOREIGN KEY (ProductID) REFERENCES ShopDB_T09.app.Products(ProductID)
);

-- DROP SCHEMA app;

CREATE SCHEMA app;
-- ShopDB_T09.app.Customers определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Customers;

CREATE TABLE ShopDB_T09.app.Customers (
	CustomerID int IDENTITY(1,1) NOT NULL,
	TenantID int NOT NULL,
	Region nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Email nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CreatedAt datetime2 DEFAULT sysutcdatetime() NOT NULL,
	CONSTRAINT PK__Customer__A4AE64B801FC6E71 PRIMARY KEY (CustomerID)
);


-- ShopDB_T09.app.Categories определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Categories;

CREATE TABLE ShopDB_T09.app.Categories (
	CategoryID int IDENTITY(1,1) NOT NULL,
	ParentID int NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Categori__19093A2B74E3D7D9 PRIMARY KEY (CategoryID),
	CONSTRAINT FK__Categorie__Paren__4CA06362 FOREIGN KEY (ParentID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.Orders определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Orders;

CREATE TABLE ShopDB_T09.app.Orders (
	OrderID int IDENTITY(1,1) NOT NULL,
	CustomerID int NOT NULL,
	OrderDate date NOT NULL,
	Status nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Total decimal(18,2) DEFAULT 0 NOT NULL,
	CONSTRAINT PK__Orders__C3905BAFE984BE31 PRIMARY KEY (OrderID),
	CONSTRAINT FK__Orders__Customer__5629CD9C FOREIGN KEY (CustomerID) REFERENCES ShopDB_T09.app.Customers(CustomerID)
);
CREATE NONCLUSTERED INDEX IX_Orders_Customer_Status ON ShopDB_T09.app.Orders (CustomerID, Status) INCLUDE (OrderDate, Total);


-- ShopDB_T09.app.Payments определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Payments;

CREATE TABLE ShopDB_T09.app.Payments (
	PaymentID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	PaidAt datetime2 NOT NULL,
	Amount decimal(18,2) NOT NULL,
	CONSTRAINT PK__Payments__9B556A5844868BAC PRIMARY KEY (PaymentID),
	CONSTRAINT FK__Payments__OrderI__5DCAEF64 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID)
);


-- ShopDB_T09.app.Products определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Products;

CREATE TABLE ShopDB_T09.app.Products (
	ProductID int IDENTITY(1,1) NOT NULL,
	CategoryID int NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__Products__B40CC6EDE346B049 PRIMARY KEY (ProductID),
	CONSTRAINT FK__Products__Catego__4F7CD00D FOREIGN KEY (CategoryID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.OrderDetails определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.OrderDetails;

CREATE TABLE ShopDB_T09.app.OrderDetails (
	OrderDetailID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	ProductID int NOT NULL,
	Qty int NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__OrderDet__D3B9D30C9D878F9D PRIMARY KEY (OrderDetailID),
	CONSTRAINT FK__OrderDeta__Order__59FA5E80 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID),
	CONSTRAINT FK__OrderDeta__Produ__5AEE82B9 FOREIGN KEY (ProductID) REFERENCES ShopDB_T09.app.Products(ProductID)
);

-- DROP SCHEMA app;

CREATE SCHEMA app;
-- ShopDB_T09.app.Customers определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Customers;

CREATE TABLE ShopDB_T09.app.Customers (
	CustomerID int IDENTITY(1,1) NOT NULL,
	TenantID int NOT NULL,
	Region nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Email nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CreatedAt datetime2 DEFAULT sysutcdatetime() NOT NULL,
	CONSTRAINT PK__Customer__A4AE64B801FC6E71 PRIMARY KEY (CustomerID)
);


-- ShopDB_T09.app.Categories определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Categories;

CREATE TABLE ShopDB_T09.app.Categories (
	CategoryID int IDENTITY(1,1) NOT NULL,
	ParentID int NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Categori__19093A2B74E3D7D9 PRIMARY KEY (CategoryID),
	CONSTRAINT FK__Categorie__Paren__4CA06362 FOREIGN KEY (ParentID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.Orders определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Orders;

CREATE TABLE ShopDB_T09.app.Orders (
	OrderID int IDENTITY(1,1) NOT NULL,
	CustomerID int NOT NULL,
	OrderDate date NOT NULL,
	Status nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Total decimal(18,2) DEFAULT 0 NOT NULL,
	CONSTRAINT PK__Orders__C3905BAFE984BE31 PRIMARY KEY (OrderID),
	CONSTRAINT FK__Orders__Customer__5629CD9C FOREIGN KEY (CustomerID) REFERENCES ShopDB_T09.app.Customers(CustomerID)
);
CREATE NONCLUSTERED INDEX IX_Orders_Customer_Status ON ShopDB_T09.app.Orders (CustomerID, Status) INCLUDE (OrderDate, Total);


-- ShopDB_T09.app.Payments определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Payments;

CREATE TABLE ShopDB_T09.app.Payments (
	PaymentID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	PaidAt datetime2 NOT NULL,
	Amount decimal(18,2) NOT NULL,
	CONSTRAINT PK__Payments__9B556A5844868BAC PRIMARY KEY (PaymentID),
	CONSTRAINT FK__Payments__OrderI__5DCAEF64 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID)
);


-- ShopDB_T09.app.Products определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Products;

CREATE TABLE ShopDB_T09.app.Products (
	ProductID int IDENTITY(1,1) NOT NULL,
	CategoryID int NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__Products__B40CC6EDE346B049 PRIMARY KEY (ProductID),
	CONSTRAINT FK__Products__Catego__4F7CD00D FOREIGN KEY (CategoryID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.OrderDetails определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.OrderDetails;

CREATE TABLE ShopDB_T09.app.OrderDetails (
	OrderDetailID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	ProductID int NOT NULL,
	Qty int NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__OrderDet__D3B9D30C9D878F9D PRIMARY KEY (OrderDetailID),
	CONSTRAINT FK__OrderDeta__Order__59FA5E80 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID),
	CONSTRAINT FK__OrderDeta__Produ__5AEE82B9 FOREIGN KEY (ProductID) REFERENCES ShopDB_T09.app.Products(ProductID)
);

-- DROP SCHEMA app;

CREATE SCHEMA app;
-- ShopDB_T09.app.Customers определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Customers;

CREATE TABLE ShopDB_T09.app.Customers (
	CustomerID int IDENTITY(1,1) NOT NULL,
	TenantID int NOT NULL,
	Region nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Email nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CreatedAt datetime2 DEFAULT sysutcdatetime() NOT NULL,
	CONSTRAINT PK__Customer__A4AE64B801FC6E71 PRIMARY KEY (CustomerID)
);


-- ShopDB_T09.app.Categories определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Categories;

CREATE TABLE ShopDB_T09.app.Categories (
	CategoryID int IDENTITY(1,1) NOT NULL,
	ParentID int NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Categori__19093A2B74E3D7D9 PRIMARY KEY (CategoryID),
	CONSTRAINT FK__Categorie__Paren__4CA06362 FOREIGN KEY (ParentID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.Orders определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Orders;

CREATE TABLE ShopDB_T09.app.Orders (
	OrderID int IDENTITY(1,1) NOT NULL,
	CustomerID int NOT NULL,
	OrderDate date NOT NULL,
	Status nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Total decimal(18,2) DEFAULT 0 NOT NULL,
	CONSTRAINT PK__Orders__C3905BAFE984BE31 PRIMARY KEY (OrderID),
	CONSTRAINT FK__Orders__Customer__5629CD9C FOREIGN KEY (CustomerID) REFERENCES ShopDB_T09.app.Customers(CustomerID)
);
CREATE NONCLUSTERED INDEX IX_Orders_Customer_Status ON ShopDB_T09.app.Orders (CustomerID, Status) INCLUDE (OrderDate, Total);


-- ShopDB_T09.app.Payments определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Payments;

CREATE TABLE ShopDB_T09.app.Payments (
	PaymentID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	PaidAt datetime2 NOT NULL,
	Amount decimal(18,2) NOT NULL,
	CONSTRAINT PK__Payments__9B556A5844868BAC PRIMARY KEY (PaymentID),
	CONSTRAINT FK__Payments__OrderI__5DCAEF64 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID)
);


-- ShopDB_T09.app.Products определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Products;

CREATE TABLE ShopDB_T09.app.Products (
	ProductID int IDENTITY(1,1) NOT NULL,
	CategoryID int NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__Products__B40CC6EDE346B049 PRIMARY KEY (ProductID),
	CONSTRAINT FK__Products__Catego__4F7CD00D FOREIGN KEY (CategoryID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.OrderDetails определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.OrderDetails;

CREATE TABLE ShopDB_T09.app.OrderDetails (
	OrderDetailID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	ProductID int NOT NULL,
	Qty int NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__OrderDet__D3B9D30C9D878F9D PRIMARY KEY (OrderDetailID),
	CONSTRAINT FK__OrderDeta__Order__59FA5E80 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID),
	CONSTRAINT FK__OrderDeta__Produ__5AEE82B9 FOREIGN KEY (ProductID) REFERENCES ShopDB_T09.app.Products(ProductID)
);

-- DROP SCHEMA app;

CREATE SCHEMA app;
-- ShopDB_T09.app.Customers определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Customers;

CREATE TABLE ShopDB_T09.app.Customers (
	CustomerID int IDENTITY(1,1) NOT NULL,
	TenantID int NOT NULL,
	Region nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Email nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CreatedAt datetime2 DEFAULT sysutcdatetime() NOT NULL,
	CONSTRAINT PK__Customer__A4AE64B801FC6E71 PRIMARY KEY (CustomerID)
);


-- ShopDB_T09.app.Categories определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Categories;

CREATE TABLE ShopDB_T09.app.Categories (
	CategoryID int IDENTITY(1,1) NOT NULL,
	ParentID int NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Categori__19093A2B74E3D7D9 PRIMARY KEY (CategoryID),
	CONSTRAINT FK__Categorie__Paren__4CA06362 FOREIGN KEY (ParentID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.Orders определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Orders;

CREATE TABLE ShopDB_T09.app.Orders (
	OrderID int IDENTITY(1,1) NOT NULL,
	CustomerID int NOT NULL,
	OrderDate date NOT NULL,
	Status nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Total decimal(18,2) DEFAULT 0 NOT NULL,
	CONSTRAINT PK__Orders__C3905BAFE984BE31 PRIMARY KEY (OrderID),
	CONSTRAINT FK__Orders__Customer__5629CD9C FOREIGN KEY (CustomerID) REFERENCES ShopDB_T09.app.Customers(CustomerID)
);
CREATE NONCLUSTERED INDEX IX_Orders_Customer_Status ON ShopDB_T09.app.Orders (CustomerID, Status) INCLUDE (OrderDate, Total);


-- ShopDB_T09.app.Payments определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Payments;

CREATE TABLE ShopDB_T09.app.Payments (
	PaymentID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	PaidAt datetime2 NOT NULL,
	Amount decimal(18,2) NOT NULL,
	CONSTRAINT PK__Payments__9B556A5844868BAC PRIMARY KEY (PaymentID),
	CONSTRAINT FK__Payments__OrderI__5DCAEF64 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID)
);


-- ShopDB_T09.app.Products определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Products;

CREATE TABLE ShopDB_T09.app.Products (
	ProductID int IDENTITY(1,1) NOT NULL,
	CategoryID int NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__Products__B40CC6EDE346B049 PRIMARY KEY (ProductID),
	CONSTRAINT FK__Products__Catego__4F7CD00D FOREIGN KEY (CategoryID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.OrderDetails определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.OrderDetails;

CREATE TABLE ShopDB_T09.app.OrderDetails (
	OrderDetailID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	ProductID int NOT NULL,
	Qty int NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__OrderDet__D3B9D30C9D878F9D PRIMARY KEY (OrderDetailID),
	CONSTRAINT FK__OrderDeta__Order__59FA5E80 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID),
	CONSTRAINT FK__OrderDeta__Produ__5AEE82B9 FOREIGN KEY (ProductID) REFERENCES ShopDB_T09.app.Products(ProductID)
);

-- DROP SCHEMA app;

CREATE SCHEMA app;
-- ShopDB_T09.app.Customers определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Customers;

CREATE TABLE ShopDB_T09.app.Customers (
	CustomerID int IDENTITY(1,1) NOT NULL,
	TenantID int NOT NULL,
	Region nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Email nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CreatedAt datetime2 DEFAULT sysutcdatetime() NOT NULL,
	CONSTRAINT PK__Customer__A4AE64B801FC6E71 PRIMARY KEY (CustomerID)
);


-- ShopDB_T09.app.Categories определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Categories;

CREATE TABLE ShopDB_T09.app.Categories (
	CategoryID int IDENTITY(1,1) NOT NULL,
	ParentID int NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Categori__19093A2B74E3D7D9 PRIMARY KEY (CategoryID),
	CONSTRAINT FK__Categorie__Paren__4CA06362 FOREIGN KEY (ParentID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.Orders определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Orders;

CREATE TABLE ShopDB_T09.app.Orders (
	OrderID int IDENTITY(1,1) NOT NULL,
	CustomerID int NOT NULL,
	OrderDate date NOT NULL,
	Status nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Total decimal(18,2) DEFAULT 0 NOT NULL,
	CONSTRAINT PK__Orders__C3905BAFE984BE31 PRIMARY KEY (OrderID),
	CONSTRAINT FK__Orders__Customer__5629CD9C FOREIGN KEY (CustomerID) REFERENCES ShopDB_T09.app.Customers(CustomerID)
);
CREATE NONCLUSTERED INDEX IX_Orders_Customer_Status ON ShopDB_T09.app.Orders (CustomerID, Status) INCLUDE (OrderDate, Total);


-- ShopDB_T09.app.Payments определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Payments;

CREATE TABLE ShopDB_T09.app.Payments (
	PaymentID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	PaidAt datetime2 NOT NULL,
	Amount decimal(18,2) NOT NULL,
	CONSTRAINT PK__Payments__9B556A5844868BAC PRIMARY KEY (PaymentID),
	CONSTRAINT FK__Payments__OrderI__5DCAEF64 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID)
);


-- ShopDB_T09.app.Products определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Products;

CREATE TABLE ShopDB_T09.app.Products (
	ProductID int IDENTITY(1,1) NOT NULL,
	CategoryID int NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__Products__B40CC6EDE346B049 PRIMARY KEY (ProductID),
	CONSTRAINT FK__Products__Catego__4F7CD00D FOREIGN KEY (CategoryID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.OrderDetails определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.OrderDetails;

CREATE TABLE ShopDB_T09.app.OrderDetails (
	OrderDetailID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	ProductID int NOT NULL,
	Qty int NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__OrderDet__D3B9D30C9D878F9D PRIMARY KEY (OrderDetailID),
	CONSTRAINT FK__OrderDeta__Order__59FA5E80 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID),
	CONSTRAINT FK__OrderDeta__Produ__5AEE82B9 FOREIGN KEY (ProductID) REFERENCES ShopDB_T09.app.Products(ProductID)
);

-- DROP SCHEMA app;

CREATE SCHEMA app;
-- ShopDB_T09.app.Customers определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Customers;

CREATE TABLE ShopDB_T09.app.Customers (
	CustomerID int IDENTITY(1,1) NOT NULL,
	TenantID int NOT NULL,
	Region nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Email nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CreatedAt datetime2 DEFAULT sysutcdatetime() NOT NULL,
	CONSTRAINT PK__Customer__A4AE64B801FC6E71 PRIMARY KEY (CustomerID)
);


-- ShopDB_T09.app.Categories определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Categories;

CREATE TABLE ShopDB_T09.app.Categories (
	CategoryID int IDENTITY(1,1) NOT NULL,
	ParentID int NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Categori__19093A2B74E3D7D9 PRIMARY KEY (CategoryID),
	CONSTRAINT FK__Categorie__Paren__4CA06362 FOREIGN KEY (ParentID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.Orders определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Orders;

CREATE TABLE ShopDB_T09.app.Orders (
	OrderID int IDENTITY(1,1) NOT NULL,
	CustomerID int NOT NULL,
	OrderDate date NOT NULL,
	Status nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Total decimal(18,2) DEFAULT 0 NOT NULL,
	CONSTRAINT PK__Orders__C3905BAFE984BE31 PRIMARY KEY (OrderID),
	CONSTRAINT FK__Orders__Customer__5629CD9C FOREIGN KEY (CustomerID) REFERENCES ShopDB_T09.app.Customers(CustomerID)
);
CREATE NONCLUSTERED INDEX IX_Orders_Customer_Status ON ShopDB_T09.app.Orders (CustomerID, Status) INCLUDE (OrderDate, Total);


-- ShopDB_T09.app.Payments определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Payments;

CREATE TABLE ShopDB_T09.app.Payments (
	PaymentID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	PaidAt datetime2 NOT NULL,
	Amount decimal(18,2) NOT NULL,
	CONSTRAINT PK__Payments__9B556A5844868BAC PRIMARY KEY (PaymentID),
	CONSTRAINT FK__Payments__OrderI__5DCAEF64 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID)
);


-- ShopDB_T09.app.Products определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.Products;

CREATE TABLE ShopDB_T09.app.Products (
	ProductID int IDENTITY(1,1) NOT NULL,
	CategoryID int NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__Products__B40CC6EDE346B049 PRIMARY KEY (ProductID),
	CONSTRAINT FK__Products__Catego__4F7CD00D FOREIGN KEY (CategoryID) REFERENCES ShopDB_T09.app.Categories(CategoryID)
);


-- ShopDB_T09.app.OrderDetails определение

-- Drop table

-- DROP TABLE ShopDB_T09.app.OrderDetails;

CREATE TABLE ShopDB_T09.app.OrderDetails (
	OrderDetailID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	ProductID int NOT NULL,
	Qty int NOT NULL,
	Price decimal(18,2) NOT NULL,
	CONSTRAINT PK__OrderDet__D3B9D30C9D878F9D PRIMARY KEY (OrderDetailID),
	CONSTRAINT FK__OrderDeta__Order__59FA5E80 FOREIGN KEY (OrderID) REFERENCES ShopDB_T09.app.Orders(OrderID),
	CONSTRAINT FK__OrderDeta__Produ__5AEE82B9 FOREIGN KEY (ProductID) REFERENCES ShopDB_T09.app.Products(ProductID)
);

-- DROP SCHEMA audit;

CREATE SCHEMA audit;
-- ShopDB_T09.audit.OrderLog определение

-- Drop table

-- DROP TABLE ShopDB_T09.audit.OrderLog;

CREATE TABLE ShopDB_T09.audit.OrderLog (
	LogID int IDENTITY(1,1) NOT NULL,
	OrderID int NOT NULL,
	[Action] nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ChangedAt datetime2 DEFAULT sysutcdatetime() NOT NULL,
	ChangedBy nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__OrderLog__5E5499A84CD8DA73 PRIMARY KEY (LogID)
);

-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;

-- DROP SCHEMA rpt;

CREATE SCHEMA rpt;
-- rpt.vw_OrderSummary исходный текст

ALTER   VIEW rpt.vw_OrderSummary AS
SELECT 
    o.OrderID,
    o.OrderDate,
    o.Status,
    SUM(od.Qty * od.Price) AS CalculatedTotal,
    COUNT(od.OrderDetailID) AS ItemCount
FROM app.Orders o
LEFT JOIN app.OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID, o.OrderDate, o.Status;