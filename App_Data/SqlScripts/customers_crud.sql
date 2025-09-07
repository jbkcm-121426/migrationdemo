-- Run this on AdventureWorks2019 (or your AdventureWorks DB)
-- Creates procs to insert/update/delete an individual customer touching required tables

IF OBJECT_ID('dbo.usp_Customer_Insert') IS NOT NULL DROP PROCEDURE dbo.usp_Customer_Insert;
GO
CREATE PROCEDURE dbo.usp_Customer_Insert
    @FirstName nvarchar(50),
    @LastName nvarchar(50),
    @EmailAddress nvarchar(50) = NULL,
    @PhoneNumber nvarchar(25) = NULL,
    @BusinessEntityID int OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;

        INSERT INTO Person.BusinessEntity DEFAULT VALUES;
        SET @BusinessEntityID = SCOPE_IDENTITY();

        INSERT INTO Person.Person (BusinessEntityID, PersonType, NameStyle, FirstName, LastName)
        VALUES (@BusinessEntityID, 'IN', 0, @FirstName, @LastName);

        INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, AccountNumber)
        VALUES (@BusinessEntityID, NULL, NULL, 'AW' + RIGHT('00000000' + CAST(@BusinessEntityID AS varchar(8)), 8));

        IF @EmailAddress IS NOT NULL AND LEN(@EmailAddress) > 0
        BEGIN
            INSERT INTO Person.EmailAddress (BusinessEntityID, EmailAddress)
            VALUES (@BusinessEntityID, @EmailAddress);
        END

        IF @PhoneNumber IS NOT NULL AND LEN(@PhoneNumber) > 0
        BEGIN
            INSERT INTO Person.PersonPhone (BusinessEntityID, PhoneNumber, PhoneNumberTypeID)
            VALUES (@BusinessEntityID, @PhoneNumber, 1);
        END

        COMMIT;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK;
        THROW;
    END CATCH
END
GO

IF OBJECT_ID('dbo.usp_Customer_Update') IS NOT NULL DROP PROCEDURE dbo.usp_Customer_Update;
GO
CREATE PROCEDURE dbo.usp_Customer_Update
    @BusinessEntityID int,
    @FirstName nvarchar(50),
    @LastName nvarchar(50),
    @EmailAddress nvarchar(50) = NULL,
    @PhoneNumber nvarchar(25) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;

        UPDATE Person.Person
        SET FirstName = @FirstName,
            LastName = @LastName
        WHERE BusinessEntityID = @BusinessEntityID;

        -- Email: upsert first email row
        IF @EmailAddress IS NULL OR LEN(@EmailAddress) = 0
        BEGIN
            DELETE FROM Person.EmailAddress WHERE BusinessEntityID = @BusinessEntityID;
        END
        ELSE
        BEGIN
            IF EXISTS (SELECT 1 FROM Person.EmailAddress WHERE BusinessEntityID = @BusinessEntityID)
                UPDATE Person.EmailAddress SET EmailAddress=@EmailAddress WHERE BusinessEntityID=@BusinessEntityID;
            ELSE
                INSERT INTO Person.EmailAddress (BusinessEntityID, EmailAddress) VALUES (@BusinessEntityID, @EmailAddress);
        END

        -- Phone: upsert first phone row (type 1)
        IF @PhoneNumber IS NULL OR LEN(@PhoneNumber) = 0
        BEGIN
            DELETE FROM Person.PersonPhone WHERE BusinessEntityID = @BusinessEntityID AND PhoneNumberTypeID=1;
        END
        ELSE
        BEGIN
            IF EXISTS (SELECT 1 FROM Person.PersonPhone WHERE BusinessEntityID=@BusinessEntityID AND PhoneNumberTypeID=1)
                UPDATE Person.PersonPhone SET PhoneNumber=@PhoneNumber WHERE BusinessEntityID=@BusinessEntityID AND PhoneNumberTypeID=1;
            ELSE
                INSERT INTO Person.PersonPhone (BusinessEntityID, PhoneNumber, PhoneNumberTypeID) VALUES (@BusinessEntityID, @PhoneNumber, 1);
        END

        COMMIT;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK;
        THROW;
    END CATCH
END
GO

IF OBJECT_ID('dbo.usp_Customer_Delete') IS NOT NULL DROP PROCEDURE dbo.usp_Customer_Delete;
GO
CREATE PROCEDURE dbo.usp_Customer_Delete
    @BusinessEntityID int
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;

        DELETE FROM Person.PersonPhone WHERE BusinessEntityID = @BusinessEntityID;
        DELETE FROM Person.EmailAddress WHERE BusinessEntityID = @BusinessEntityID;
        DELETE FROM Sales.Customer WHERE PersonID = @BusinessEntityID;
        DELETE FROM Person.Person WHERE BusinessEntityID = @BusinessEntityID;
        DELETE FROM Person.BusinessEntity WHERE BusinessEntityID = @BusinessEntityID;

        COMMIT;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK;
        THROW;
    END CATCH
END
GO


