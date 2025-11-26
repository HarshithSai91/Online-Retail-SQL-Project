-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema online_retail_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema online_retail_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `online_retail_db` DEFAULT CHARACTER SET utf8 ;
USE `online_retail_db` ;

-- -----------------------------------------------------
-- Table `online_retail_db`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail_db`.`Customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NULL,
  `address` VARCHAR(255) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail_db`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail_db`.`Products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `stock_quantity` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail_db`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail_db`.`Orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `order_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(50) NULL DEFAULT 'Pending',
  `Customers_customer_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_Orders_Customers_idx` (`Customers_customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customers`
    FOREIGN KEY (`Customers_customer_id`)
    REFERENCES `online_retail_db`.`Customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail_db`.`Order_Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail_db`.`Order_Items` (
  `order_item_id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT NOT NULL,
  `price_per_item` DECIMAL(10,2) NOT NULL,
  `Orders_order_id` INT NOT NULL,
  `Products_product_id` INT NOT NULL,
  PRIMARY KEY (`order_item_id`),
  INDEX `fk_Order_Items_Orders1_idx` (`Orders_order_id` ASC) VISIBLE,
  INDEX `fk_Order_Items_Products1_idx` (`Products_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Items_Orders1`
    FOREIGN KEY (`Orders_order_id`)
    REFERENCES `online_retail_db`.`Orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Items_Products1`
    FOREIGN KEY (`Products_product_id`)
    REFERENCES `online_retail_db`.`Products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_retail_db`.`Payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_retail_db`.`Payments` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `payment_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` DECIMAL(10,2) NOT NULL,
  `payment_method` VARCHAR(50) NULL,
  `status` VARCHAR(50) NULL DEFAULT 'Completed',
  `Orders_order_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_Payments_Orders1_idx` (`Orders_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payments_Orders1`
    FOREIGN KEY (`Orders_order_id`)
    REFERENCES `online_retail_db`.`Orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
