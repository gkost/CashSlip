-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ex
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ex
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ex` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `ex` ;

-- -----------------------------------------------------
-- Table `ex`.`Date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ex`.`Date` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `month` INT UNSIGNED NOT NULL COMMENT '',
  `year` INT UNSIGNED NOT NULL COMMENT '',
  `monthMoney` DECIMAL(12,2) NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex`.`Cashslip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ex`.`Cashslip` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `day` INT UNSIGNED NOT NULL COMMENT '',
  `product` VARCHAR(45) NOT NULL COMMENT '',
  `cost` DECIMAL(12,2) NOT NULL COMMENT '',
  `Date_id` INT UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_cashslip_Date_idx` (`Date_id` ASC)  COMMENT '',
  CONSTRAINT `fk_cashslip_Date`
    FOREIGN KEY (`Date_id`)
    REFERENCES `ex`.`Date` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ex`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ex`.`users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `user` VARCHAR(45) NOT NULL COMMENT '',
  `pass` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
