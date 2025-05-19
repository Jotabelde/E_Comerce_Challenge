-- Configurações iniciais
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';

-- Cria schema E_comerce
CREATE SCHEMA IF NOT EXISTS `E_comerce` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `E_comerce`;

-- Tabela Product
DROP TABLE IF EXISTS `Product`;
CREATE TABLE `Product` (
  `id_Product` INT NOT NULL AUTO_INCREMENT,
  `Due_Date` DATETIME NULL DEFAULT NULL,
  `Value` DECIMAL(6,2) NULL DEFAULT NULL,
  `Amount` INT NULL,
  PRIMARY KEY (`id_Product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela Customer
DROP TABLE IF EXISTS `Customer`;
CREATE TABLE `Customer` (
  `Id_Customer` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Address` VARCHAR(255) DEFAULT NULL,
  `Social_reason` VARCHAR(250) DEFAULT NULL,
  `Customer_Type` ENUM('Individual', 'Company') NOT NULL,
  `CPF` CHAR(11) DEFAULT NULL UNIQUE,
  `CNPJ` CHAR(14) DEFAULT NULL UNIQUE,
  PRIMARY KEY (`Id_Customer`),
  CONSTRAINT chk_customer_type CHECK (
    (Customer_Type = 'Individual' AND CPF IS NOT NULL AND CNPJ IS NULL AND Social_reason IS NULL)
    OR
    (Customer_Type = 'Company' AND CNPJ IS NOT NULL AND CPF IS NULL)
  )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela Order
DROP TABLE IF EXISTS `Order`;
CREATE TABLE `Order` (
  `id_Order` INT NOT NULL AUTO_INCREMENT,
  `Status` VARCHAR(45) DEFAULT NULL,
  `Description` VARCHAR(200) DEFAULT NULL,
  `Customer_Id_Customer` INT NOT NULL,
  `payment_reference` VARCHAR(100) DEFAULT NULL,
  `payment_type` ENUM('Credit_Card', 'Pix', 'Boleto', 'Cash') NOT NULL,
  PRIMARY KEY (`id_Order`),
  CONSTRAINT `chk_payment_logic` CHECK (
    (payment_type = 'Pix' AND payment_reference IS NOT NULL) OR
    (payment_type IN ('Cash', 'Boleto', 'Credit_Card') AND payment_reference IS NULL)
  ),
  FOREIGN KEY (`Customer_Id_Customer`) REFERENCES `Customer`(`Id_Customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Tabela Stock (corrigido nome)
DROP TABLE IF EXISTS `Stock`;
CREATE TABLE `Stock` (
  `idStock` INT NOT NULL AUTO_INCREMENT,
  `Address` VARCHAR(250) DEFAULT NULL,
  PRIMARY KEY (`idStock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela Supplier
DROP TABLE IF EXISTS `Supplier`;
CREATE TABLE `Supplier` (
  `id_Supplier` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) DEFAULT NULL,
  `Social_reason` VARCHAR(250) DEFAULT NULL,
  `Address` VARCHAR(250) DEFAULT NULL,
  PRIMARY KEY (`id_Supplier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela relacionamento Stock_has_Product
DROP TABLE IF EXISTS `Stock_has_Product`;
CREATE TABLE `Stock_has_Product` (
  `Stock_idStock` INT NOT NULL,
  `Product_id_Product` INT NOT NULL,
  `Amount` INT DEFAULT NULL,
  PRIMARY KEY (`Stock_idStock`, `Product_id_Product`),
  FOREIGN KEY (`Stock_idStock`) REFERENCES `Stock`(`idStock`),
  FOREIGN KEY (`Product_id_Product`) REFERENCES `Product`(`id_Product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela relacionamento Supplier_supplies_Product
DROP TABLE IF EXISTS `Supplier_supplies_Product`;
CREATE TABLE `Supplier_supplies_Product` (
  `Supplier_id_Supplier` INT NOT NULL,
  `Product_id_Product` INT NOT NULL,
  PRIMARY KEY (`Supplier_id_Supplier`, `Product_id_Product`),
  FOREIGN KEY (`Supplier_id_Supplier`) REFERENCES `Supplier`(`id_Supplier`),
  FOREIGN KEY (`Product_id_Product`) REFERENCES `Product`(`id_Product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela relacionamento Order_has_Product
DROP TABLE IF EXISTS `Order_has_Product`;
CREATE TABLE `Order_has_Product` (
  `Order_id_Order` INT NOT NULL,
  `Product_id_Product` INT NOT NULL,
  `Amount` INT DEFAULT NULL,
  PRIMARY KEY (`Order_id_Order`, `Product_id_Product`),
  FOREIGN KEY (`Order_id_Order`) REFERENCES `Order`(`id_Order`),
  FOREIGN KEY (`Product_id_Product`) REFERENCES `Product`(`id_Product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela Delivery
CREATE TABLE Delivery (
  Order_id_Order INT PRIMARY KEY,
  Delivery_Status ENUM('...') NOT NULL,
  Delivery_Address VARCHAR(255) NOT NULL,
  Freight_Value DECIMAL(6,2),
  Tracking_Code VARCHAR(100),
  FOREIGN KEY (Order_id_Order) REFERENCES `Order`(id_Order)
);

-- Restaura configurações originais
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
