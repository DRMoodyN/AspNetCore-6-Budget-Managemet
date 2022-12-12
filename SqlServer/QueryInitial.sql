--=====================================================================================================
-- SqlServer-Budget-Managemet
--=====================================================================================================

USE master
GO

-- Validacion y creacion de la bd
IF EXISTS ( SELECT * FROM sys.databases AS s WHERE s.name = 'BudgetManagemet')
BEGIN
	DROP DATABASE BudgetManagemet
END
GO

CREATE DATABASE BudgetManagemet
GO

-- Validacion y creacion del login
IF EXISTS (SELECT * FROM sys.sql_logins AS l WHERE l.name = 'BudgetLogin' )
BEGIN
	DROP LOGIN BudgetLogin
END

CREATE LOGIN BudgetLogin WITH PASSWORD = 'BudgetLogin',
DEFAULT_DATABASE = BudgetManagemet,
CHECK_EXPIRATION = OFF,  CHECK_POLICY = OFF

EXEC sp_addsrvrolemember 'BudgetLogin','dbcreator'
GO
 
USE BudgetManagemet
GO

-- Creacion del usuario
CREATE USER BudgetLogin FOR LOGIN BudgetLogin
GO

EXEC sp_addrolemember 'db_owner','BudgetLogin'
GO


CREATE TABLE TransactionBudget(
	TransactionBudgetID INT PRIMARY KEY,
	UserOwnerID NVARCHAR(50) NOT NULL,
	DateTrannsaction DATETIME DEFAULT(GETDATE()) NOT NULL,
	Monto DECIMAL(18,4) NOT NULL,
	TypeTransactionID INT NOT NULL,
	BugetDescription NVARCHAR(1000) NULL
)
GO

