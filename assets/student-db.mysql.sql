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
  `County` VARCHAR(45) NOT NULL DEFAULT 'Tipperary',
  `Course_Id` VARCHAR(20) NOT NULL,
  `Date_Created` DATETIME NOT NULL DEFAULT NOW(),
  `Email` VARCHAR(45) NOT NULL,
  `Gender` ENUM('M', 'F') NOT NULL,
  `Password` VARCHAR(128) NOT NULL,
  `Phone` VARCHAR(45) NULL,
  `Username` VARCHAR(45) NOT NULL,
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
  `Grade_Mark` DECIMAL(3,2) NOT NULL DEFAULT 0,
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


-- -----------------------------------------------------
-- Table `Student_db`.`Timetable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_db`.`Timetable` (
  `Class_Group` VARCHAR(45) NOT NULL,
  `Day` ENUM('Mon', 'Tues', 'Wed', 'Thurs', 'Fri') NOT NULL,
  `Module_Id` VARCHAR(255) NOT NULL,
  `Room` VARCHAR(45) NOT NULL,
  `Semester` ENUM('1', '2', '3', '4', '5', '6', '7', '8') NOT NULL,
  `Start_Time` TIME NOT NULL DEFAULT '09:00:00',
  INDEX `fk_Timetable_Module1_idx` (`Module_Id` ASC) VISIBLE,
  PRIMARY KEY (`Class_Group`, `Day`, `Room`, `Semester`, `Start_Time`),
  CONSTRAINT `fk_Timetable_Module1`
    FOREIGN KEY (`Module_Id`)
    REFERENCES `Student_db`.`Module` (`Module_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Student_db`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_db`.`category` (
  `category_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`category_id`));


-- -----------------------------------------------------
-- Table `Student_db`.`Assignment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_db`.`Assignment` (
  ` Assignment_Id` INT NOT NULL AUTO_INCREMENT,
  `Due_Date` DATETIME NOT NULL DEFAULT NOW(),
  `Due_Time` TIME NOT NULL DEFAULT '23:59:59',
  `Hand_Up_Method` VARCHAR(45) NOT NULL,
  `Module_id` VARCHAR(255) NOT NULL,
  `Percentage_wt` VARCHAR(45) NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (` Assignment_Id`),
  INDEX `fk_Assignment_Module1_idx` (`Module_id` ASC) VISIBLE,
  CONSTRAINT `fk_Assignment_Module1`
    FOREIGN KEY (`Module_id`)
    REFERENCES `Student_db`.`Module` (`Module_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Student_db`.`Forum`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_db`.`Forum` (
  `Question_Id` INT NOT NULL AUTO_INCREMENT,
  `Posted_Date` DATETIME NOT NULL DEFAULT now(),
  `Question_Title` TEXT NOT NULL,
  `Question_Content` VARCHAR(255) NULL,
  `User_Id` INT NOT NULL,
  INDEX `fk_Forum_User1_idx` (`User_Id` ASC) VISIBLE,
  PRIMARY KEY (`Question_Id`),
  CONSTRAINT `fk_Forum_User1`
    FOREIGN KEY (`User_Id`)
    REFERENCES `Student_db`.`User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '		';


-- -----------------------------------------------------
-- Table `Student_db`.`Reply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_db`.`Reply` (
  `Reply_Id` INT NOT NULL AUTO_INCREMENT,
  `Reply_Date` DATETIME NOT NULL DEFAULT NOW(),
  `Reply_Content` TEXT NOT NULL,
  `User_Id` INT NOT NULL,
  `Question_Id` INT NOT NULL,
  PRIMARY KEY (`Reply_Id`),
  INDEX `fk_Reply_User1_idx` (`User_Id` ASC) VISIBLE,
  INDEX `fk_Reply_Forum1_idx` (`Question_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Reply_User1`
    FOREIGN KEY (`User_Id`)
    REFERENCES `Student_db`.`User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reply_Forum1`
    FOREIGN KEY (`Question_Id`)
    REFERENCES `Student_db`.`Forum` (`Question_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `Student_db` ;

-- -----------------------------------------------------
-- Placeholder table for view `Student_db`.`Vw_Group1B_Sem1_Timetable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_db`.`Vw_Group1B_Sem1_Timetable` (`Class_Group` INT, `Day` INT, `Module_Id` INT, `Room` INT, `Semester` INT, `Start_Time` INT);

-- -----------------------------------------------------
-- Placeholder table for view `Student_db`.`Vw_Assignments_Due`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_db`.`Vw_Assignments_Due` (`title` INT, `module_name` INT, `due_date` INT);

-- -----------------------------------------------------
-- Placeholder table for view `Student_db`.`Vw_Group1A_Sem1_Free_Periods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_db`.`Vw_Group1A_Sem1_Free_Periods` (`day` INT, `start_time` INT);

-- -----------------------------------------------------
-- View `Student_db`.`Vw_Group1B_Sem1_Timetable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Student_db`.`Vw_Group1B_Sem1_Timetable`;
USE `Student_db`;
CREATE  OR REPLACE VIEW Vw_Group1B_Sem1_Timetable AS
SELECT *
FROM Timetable
WHERE class_group = 'Group 1B' AND semester = 1
ORDER BY FIELD(`day`, 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri'), Start_time ASC;

-- -----------------------------------------------------
-- View `Student_db`.`Vw_Assignments_Due`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Student_db`.`Vw_Assignments_Due`;
USE `Student_db`;
CREATE  OR REPLACE VIEW Vw_Assignments_Due AS
SELECT a.title, m.module_name, a.due_date
FROM Assignment a
JOIN Module m ON a.module_id = m.module_id
WHERE a.due_date >= CurDate();

-- -----------------------------------------------------
-- View `Student_db`.`Vw_Group1A_Sem1_Free_Periods`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Student_db`.`Vw_Group1A_Sem1_Free_Periods`;
USE `Student_db`;
CREATE  OR REPLACE VIEW Vw_Group1A_Sem1_Free_Periods AS
SELECT DISTINCT `day`, start_time
FROM Timetable
WHERE class_group != 'Group 1A' AND semester = 1;

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


-- -----------------------------------------------------
-- Data for table `Student_db`.`Module`
-- -----------------------------------------------------
START TRANSACTION;
USE `Student_db`;
INSERT INTO `Student_db`.`Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('CSC102', 'Computer System Concepts', 'CSM103');
INSERT INTO `Student_db`.`Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('ECOMP', 'Electronics for Computing', 'CSM103');
INSERT INTO `Student_db`.`Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('IPD104', 'Interpersonal Development', 'CSM103');
INSERT INTO `Student_db`.`Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('MM102', 'Mathematical Methods', 'CSM103');
INSERT INTO `Student_db`.`Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('MMT', 'Mathematics for Computing', 'CSM103');
INSERT INTO `Student_db`.`Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('Net1', 'Introduction to Computer Networks', 'CSM103');
INSERT INTO `Student_db`.`Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('OOP102', 'Introduction to Object Oriented Programming', 'CSM103');
INSERT INTO `Student_db`.`Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('OS1', 'Operating Systems Fundamentals', 'CSM103');
INSERT INTO `Student_db`.`Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('OSM2', 'Operating Systems Management', 'CSM103');
INSERT INTO `Student_db`.`Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('PDC101', 'Programme Design Concepts', 'CSM103');
INSERT INTO `Student_db`.`Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('Prog101', 'Introduction to Programming', 'CSM103');
INSERT INTO `Student_db`.`Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('WDF', 'Web Development Fundamentals', 'CSM103');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Student_db`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `Student_db`;
INSERT INTO `Student_db`.`User` (`User_Id`, `County`, `Course_Id`, `Date_Created`, `Email`, `Gender`, `Password`, `Phone`, `Username`) VALUES (1, 'Limerick', 'CSM103', '2025-09-01', 'user-one@no-reply.ie', 'M', 'let-me-in', NULL, 'user-one');
INSERT INTO `Student_db`.`User` (`User_Id`, `County`, `Course_Id`, `Date_Created`, `Email`, `Gender`, `Password`, `Phone`, `Username`) VALUES (2, 'Galway', 'CSM103', '2025-09-01', 'user-two@no-reply.ie', 'F', 'let-me-in', '0801231234', 'user-two');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Student_db`.`Course_Module`
-- -----------------------------------------------------
START TRANSACTION;
USE `Student_db`;
INSERT INTO `Student_db`.`Course_Module` (`Course_Id`, `Module_Id`) VALUES ('CSM103', 'CSC102');
INSERT INTO `Student_db`.`Course_Module` (`Course_Id`, `Module_Id`) VALUES ('CP102', 'ECOMP');
INSERT INTO `Student_db`.`Course_Module` (`Course_Id`, `Module_Id`) VALUES ('CP102', 'IPD104');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Student_db`.`Timetable`
-- -----------------------------------------------------
START TRANSACTION;
USE `Student_db`;
INSERT INTO `Student_db`.`Timetable` (`Class_Group`, `Day`, `Module_Id`, `Room`, `Semester`, `Start_Time`) VALUES ('Group 1B', 'Mon', 'CSC102', 'A8101', '1', '10:00');
INSERT INTO `Student_db`.`Timetable` (`Class_Group`, `Day`, `Module_Id`, `Room`, `Semester`, `Start_Time`) VALUES ('Group 1A', 'Tues', 'ECOMP', 'A8102', '1', '12:00');
INSERT INTO `Student_db`.`Timetable` (`Class_Group`, `Day`, `Module_Id`, `Room`, `Semester`, `Start_Time`) VALUES ('Group 1B', 'Wed', 'IPD104', 'A8101', '1', '14:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Student_db`.`Assignment`
-- -----------------------------------------------------
START TRANSACTION;
USE `Student_db`;
INSERT INTO `Student_db`.`Assignment` (` Assignment_Id`, `Due_Date`, `Due_Time`, `Hand_Up_Method`, `Module_id`, `Percentage_wt`, `Title`) VALUES (1, '2018-10-04', '12:00:00', 'Upload to Moodle', 'Prog101', '30', 'Programming a Calculator');
INSERT INTO `Student_db`.`Assignment` (` Assignment_Id`, `Due_Date`, `Due_Time`, `Hand_Up_Method`, `Module_id`, `Percentage_wt`, `Title`) VALUES (2, '2018-09-27', '12:00:00', 'Upload to Moodle', 'CSC102', '30', 'Build a Computer');
INSERT INTO `Student_db`.`Assignment` (` Assignment_Id`, `Due_Date`, `Due_Time`, `Hand_Up_Method`, `Module_id`, `Percentage_wt`, `Title`) VALUES (3, '2018-11-26', '12:00:00', 'Upload to Moodle', 'MMT', '20', 'Mathematics Research');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Student_db`.`Forum`
-- -----------------------------------------------------
START TRANSACTION;
USE `Student_db`;
INSERT INTO `Student_db`.`Forum` (`Question_Id`, `Posted_Date`, `Question_Title`, `Question_Content`, `User_Id`) VALUES (1, '2025-09-01', 'Q1', 'Name?', 1);
INSERT INTO `Student_db`.`Forum` (`Question_Id`, `Posted_Date`, `Question_Title`, `Question_Content`, `User_Id`) VALUES (2, '2025-09-01', 'Q2', 'Age?', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Student_db`.`Reply`
-- -----------------------------------------------------
START TRANSACTION;
USE `Student_db`;
INSERT INTO `Student_db`.`Reply` (`Reply_Id`, `Reply_Date`, `Reply_Content`, `User_Id`, `Question_Id`) VALUES (1, '2025-09-01', 'John Doe', 1, 1);

COMMIT;

