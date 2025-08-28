-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Student_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Student_db` ;

-- -----------------------------------------------------
-- Schema Student_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Student_db` DEFAULT CHARACTER SET utf8 ;
USE `Student_db` ;

-- -----------------------------------------------------
-- Table `Student_db`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_db`.`Course` (
  `Course_Id` VARCHAR(20) NOT NULL,
  `Course_Name` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `Course_Id_UNIQUE` (`Course_Id` ASC) VISIBLE,
  PRIMARY KEY (`Course_Id`),
  UNIQUE INDEX `Course_Name_UNIQUE` (`Course_Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Student_db`.`Module`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_db`.`Module` (
  `Module_Id` VARCHAR(255) NOT NULL,
  `Module_Name` VARCHAR(255) NOT NULL,
  `Course_Id` VARCHAR(20) NOT NULL,
  UNIQUE INDEX `Course_Id_UNIQUE` (`Module_Id` ASC) VISIBLE,
  PRIMARY KEY (`Module_Id`),
  INDEX `fk_Module_Course_idx` (`Course_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Module_Course`
    FOREIGN KEY (`Course_Id`)
    REFERENCES `Student_db`.`Course` (`Course_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Student_db`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_db`.`User` (
  `User_Id` INT NOT NULL AUTO_INCREMENT,
  `Gender` ENUM('M', 'F') NOT NULL,
  `County` VARCHAR(45) NOT NULL DEFAULT 'Tipperary',
  `Username` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(45) NULL,
  `Date_Created` DATETIME NOT NULL DEFAULT NOW(),
  `Course_Id` VARCHAR(20) NOT NULL,
  `Usercol` VARCHAR(45) NULL,
  PRIMARY KEY (`User_Id`),
  UNIQUE INDEX `Username_UNIQUE` (`Username` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`Phone` ASC) VISIBLE,
  INDEX `fk_User_Course1_idx` (`Course_Id` ASC) VISIBLE,
  CONSTRAINT `fk_User_Course1`
    FOREIGN KEY (`Course_Id`)
    REFERENCES `Student_db`.`Course` (`Course_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Student_db`.`Course_Module`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_db`.`Course_Module` (
  `Course_Id` VARCHAR(20) NOT NULL,
  `Module_Id` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Course_Id`, `Module_Id`),
  INDEX `fk_Course_Module_Module_idx` (`Module_Id` ASC) INVISIBLE,
  INDEX `fk_Course_Module_Course_idx` (`Course_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Course_Module_Course`
    FOREIGN KEY (`Course_Id`)
    REFERENCES `Student_db`.`Course` (`Course_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Course_Module_Module`
    FOREIGN KEY (`Module_Id`)
    REFERENCES `Student_db`.`Module` (`Module_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Student_db`.`Grade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_db`.`Grade` (
  `Module_Id` VARCHAR(255) NOT NULL,
  `Student_Id` INT NOT NULL,
  `Grade_Mark` DECIMAL(3,2) NULL DEFAULT 0,
  PRIMARY KEY (`Module_Id`, `Student_Id`),
  INDEX `fk_Grade_User1_idx` (`Student_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Grade_Module1`
    FOREIGN KEY (`Module_Id`)
    REFERENCES `Student_db`.`Module` (`Module_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Grade_User1`
    FOREIGN KEY (`Student_Id`)
    REFERENCES `Student_db`.`User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Student_db`.`Course`
-- -----------------------------------------------------
START TRANSACTION;
USE `Student_db`;
INSERT INTO `Student_db`.`Course` (`Course_Id`, `Course_Name`) VALUES ('CSM103', 'Computer Service Management');
INSERT INTO `Student_db`.`Course` (`Course_Id`, `Course_Name`) VALUES ('CP102', 'Computing');
INSERT INTO `Student_db`.`Course` (`Course_Id`, `Course_Name`) VALUES ('GD100', 'Games Design');
INSERT INTO `Student_db`.`Course` (`Course_Id`, `Course_Name`) VALUES ('SD101', 'Software Development');

COMMIT;

