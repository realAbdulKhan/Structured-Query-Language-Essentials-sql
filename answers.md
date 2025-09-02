
# Structured Query Language (SQL) - Project

Abdul Ahad Khan  
K00320022  

***This assignment is worth 100% of your overall mark***

***Upload your completed assessment to the link provided on Moodle.***

*Plagiarism of any kind will incur a 0% mark.*

*Late submission will not be accepted - 0% will be awarded for late hand-in.*

**Guidelines:**

*You are responsible for implementing the database for a student app that allows students to view their time table, view assignments due and take part in a forum.  The following contains the schema for the database.*

## Relational Schema

- [x] `Course` (course_id, course_name)
  - course_id should be of type varchar(20)
  - course_name cannot be NULL and must be unique
- [x] `Module` (module_id, module_name, course_id\*)
  - module_id should be varchar(255)
  - module_name cannot be NULL
- [x] `Course_Module` (course_id\*, module_id\*)
- [x] `User` (user_id, user_name, email, date_created, phone, gender, county, course_id\*)
  - user_id is an auto_increment type
  - gender can only be M or F value
  - all fields cannot contain a NULL value
  - default value for county must be `Tipperary`
- [x] `Grade` (module_id\*, student_id\*, grade_mark)
  - grade_mark is a numeric value
- [x] `Timetable` (module_id\*, semester, day, time, room, class_group)
  - day can only be one of the following values: (Mon, Tues, Wed, Thurs, Fri)
  - semester can only be one of the following values: (1, 2, 3, 4, 5, 6, 7, 8)
- [x] `Assignment` (assignment_id, title, due_date, percentage_wt, hand_up_method, module_id\*)
  - assignment_id should be an auto_increment number
- [x] `Forum` (question_id, question_title, question_content, date_time, user_id)
  - question_id should be an auto_increment number
- [x] `Reply` (reply_id, question_id\*, reply_content, date_time, user_id\*)
  - reply_id should be an auto_increment number

*Note: underline attributes make up the primary key for that relation,  \* indicates the attribute is a foreign key.*

*If data or the case study is unclear, or information missing (e.g. data types, column constraints etc.) please make assumptions as to what it most appropriate.*

*Save the file as a script file, i.e. with a .SQL extension that can be run.  There should be no text in the file that is not code or comments.*
**

## Checklist

- [x] Section A
  - [x] Question A
- [x] Section B
  - [x] [Question B.1](#answer-b1)
  - [x] Question B.2
  - [x] Question B.3
    - [x] Question B.3.1
    - [x] [Question B.3.2](#answer-b32)
  - [x] Question B.4
  - [x] Question B.5
  - [x] Question B.6
  - [x] Question B.7
- [x] Section C
  - [x] Question C.1
  - [x] Question C.2
  - [x] Question C.3
  - [ ] Question C.4

## Section A – Creating the tables

### Question A

Write the MySQL commands to create the tables from the relational schema above.  

   *Take the following into consideration when creating the relations*:

- Decide on the **most appropriate data types** for each attribute
- Create correct constraints for primary (underlined) and foreign keys (\*).
- All primary and foreign key to be created be at table level, and should be named.

### Answer A

```sql
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
-- Table `Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Course` (
  `Course_Id` VARCHAR(20) NOT NULL,
  `Course_Name` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `Course_Id_UNIQUE` (`Course_Id` ASC) VISIBLE,
  PRIMARY KEY (`Course_Id`),
  UNIQUE INDEX `Course_Name_UNIQUE` (`Course_Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Module`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Module` (
  `Module_Id` VARCHAR(255) NOT NULL,
  `Module_Name` VARCHAR(255) NOT NULL,
  `Course_Id` VARCHAR(20) NOT NULL,
  UNIQUE INDEX `Course_Id_UNIQUE` (`Module_Id` ASC) VISIBLE,
  PRIMARY KEY (`Module_Id`),
  INDEX `fk_Module_Course_idx` (`Course_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Module_Course`
    FOREIGN KEY (`Course_Id`)
    REFERENCES `Course` (`Course_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `User` (
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
    REFERENCES `Course` (`Course_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Course_Module`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Course_Module` (
  `Course_Id` VARCHAR(20) NOT NULL,
  `Module_Id` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Course_Id`, `Module_Id`),
  INDEX `fk_Course_Module_Module_idx` (`Module_Id` ASC) INVISIBLE,
  INDEX `fk_Course_Module_Course_idx` (`Course_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Course_Module_Course`
    FOREIGN KEY (`Course_Id`)
    REFERENCES `Course` (`Course_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Course_Module_Module`
    FOREIGN KEY (`Module_Id`)
    REFERENCES `Module` (`Module_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Grade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Grade` (
  `Module_Id` VARCHAR(255) NOT NULL,
  `Student_Id` INT NOT NULL,
  `Grade_Mark` DECIMAL(3,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Module_Id`, `Student_Id`),
  INDEX `fk_Grade_User1_idx` (`Student_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Grade_Module1`
    FOREIGN KEY (`Module_Id`)
    REFERENCES `Module` (`Module_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Grade_User1`
    FOREIGN KEY (`Student_Id`)
    REFERENCES `User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Timetable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Timetable` (
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
    REFERENCES `Module` (`Module_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`category_id`));


-- -----------------------------------------------------
-- Table `Assignment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Assignment` (
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
    REFERENCES `Module` (`Module_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Forum`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Forum` (
  `Question_Id` INT NOT NULL AUTO_INCREMENT,
  `Posted_Date` DATETIME NOT NULL DEFAULT now(),
  `Question_Title` TEXT NOT NULL,
  `Question_Content` VARCHAR(255) NULL,
  `User_Id` INT NOT NULL,
  INDEX `fk_Forum_User1_idx` (`User_Id` ASC) VISIBLE,
  PRIMARY KEY (`Question_Id`),
  CONSTRAINT `fk_Forum_User1`
    FOREIGN KEY (`User_Id`)
    REFERENCES `User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Reply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Reply` (
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
    REFERENCES `User` (`User_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reply_Forum1`
    FOREIGN KEY (`Question_Id`)
    REFERENCES `Forum` (`Question_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
```

## Section B – Inserting records (data) into the tables

### Question B.1

Insert the following data into the Course table:

| course_id | course_name                 |
|-----------|-----------------------------|
| CSM103    | Computer Service Management |
| CP102     | Computing                   |
| GD100     | Games Design                |
| SD101     | Software Development        |

### Answer B.1

```sql
INSERT INTO `Course` (`Course_Id`, `Course_Name`) VALUES ('CSM103', 'Computer Service Management');
INSERT INTO `Course` (`Course_Id`, `Course_Name`) VALUES ('CP102', 'Computing');
INSERT INTO `Course` (`Course_Id`, `Course_Name`) VALUES ('GD100', 'Games Design');
INSERT INTO `Course` (`Course_Id`, `Course_Name`) VALUES ('SD101', 'Software Development');

```

### Question B.2

Insert the following records into the Module table:

| module_id | module_name                                 | Course_Id |
|-----------|---------------------------------------------|-----------|
| CSC102    | Computer System Concepts                    | CSM103    |
| ECOMP     | Electronics for Computing                   | CSM103    |
| IPD104    | Interpersonal Development                   | CSM103    |
| MM102     | Mathematical Methods                        | CSM103    |
| MMT       | Mathematics for Computing                   | CSM103    |
| Net1      | Introduction to Computer Networks           | CSM103    |
| OOP102    | Introduction to Object Oriented Programming | CSM103    |
| OS1       | Operating Systems Fundamentals              | CSM103    |
| OSM2      | Operating Systems Management                | CSM103    |
| PDC101    | Programme Design Concepts                   | CSM103    |
| Prog101   | Introduction to Programming                 | CSM103    |
| WDF       | Web Development Fundamentals                | CSM103    |

### Answer B.2

```sql
INSERT INTO `Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('CSC102', 'Computer System Concepts', 'CSM103');
INSERT INTO `Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('ECOMP', 'Electronics for Computing', 'CSM103');
INSERT INTO `Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('IPD104', 'Interpersonal Development', 'CSM103');
INSERT INTO `Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('MM102', 'Mathematical Methods', 'CSM103');
INSERT INTO `Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('MMT', 'Mathematics for Computing', 'CSM103');
INSERT INTO `Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('Net1', 'Introduction to Computer Networks', 'CSM103');
INSERT INTO `Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('OOP102', 'Introduction to Object Oriented Programming', 'CSM103');
INSERT INTO `Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('OS1', 'Operating Systems Fundamentals', 'CSM103');
INSERT INTO `Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('OSM2', 'Operating Systems Management', 'CSM103');
INSERT INTO `Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('PDC101', 'Programme Design Concepts', 'CSM103');
INSERT INTO `Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('Prog101', 'Introduction to Programming', 'CSM103');
INSERT INTO `Module` (`Module_Id`, `Module_Name`, `Course_Id`) VALUES ('WDF', 'Web Development Fundamentals', 'CSM103');
```

### Question B.3

#### Question B.3.1

Add in your own data to the *course_module* (3 records).

##### Answer B.3.1

| Course_Id | Module_Id |
|-----------|-----------|
| CSM103    | CSC102    |
| CP102     | ECOMP     |
| CP102     | IPD104    |

```sql
INSERT INTO `Course_Module` (`Course_Id`, `Module_Id`) VALUES ('CSM103', 'CSC102');
INSERT INTO `Course_Module` (`Course_Id`, `Module_Id`) VALUES ('CP102', 'ECOMP');
INSERT INTO `Course_Module` (`Course_Id`, `Module_Id`) VALUES ('CP102', 'IPD104');
```

#### Question B.3.2

Add in your own data to the the *timetable* table (3 records).

##### Answer B.3.2

| Class_Group | Day  | Module | Room  | Semester | Start_Time |
|-------------|------|--------|-------|---------:|-----------:|
| Group 1B    | Mon  | CSC102 | A8101 |        1 |      10:00 |
| Group 1A    | Tues | ECOMP  | A8102 |        1 |      12:00 |
| Group 1B    | Wed  | IPD104 | A8101 |        1 |      14:00 |

```sql
INSERT INTO `Timetable` (`Class_Group`, `Day`, `Module_Id`, `Room`, `Semester`, `Start_Time`) VALUES ('Group 1B', 'Mon', 'CSC102', 'A8101', '1', '10:00');
INSERT INTO `Timetable` (`Class_Group`, `Day`, `Module_Id`, `Room`, `Semester`, `Start_Time`) VALUES ('Group 1A', 'Tues', 'ECOMP', 'A8102', '1', '12:00');
INSERT INTO `Timetable` (`Class_Group`, `Day`, `Module_Id`, `Room`, `Semester`, `Start_Time`) VALUES ('Group 1B', 'Wed', 'IPD104', 'A8101', '1', '14:00');
```

### Question B.4

Insert the following data into the assignment table.

| Assignment_ID |   Due_Date | Due_Time | Hand_Up_Method   | Module_Id | Percent_Wt | Title                    |
|---------------|-----------:|---------:|------------------|-----------|-----------:|--------------------------|
| 1             | 2018-10-04 | 12:00:00 | Upload to Moodle | Prog101   |         30 | Programming a Calculator |
| 2             | 2018-09-27 | 12:00:00 | Upload to Moodle | CSC102    |         30 | Build a Computer         |
| 3             | 2018-11-26 | 12:00:00 | Upload to Moodle | MMT       |         20 | Mathematics Research     |

### Answer B.4

```sql
INSERT INTO `Assignment` (` Assignment_Id`, `Due_Date`, `Due_Time`, `Hand_Up_Method`, `Module_id`, `Percentage_wt`, `Title`) VALUES (1, '2018-10-04', '12:00:00', 'Upload to Moodle', 'Prog101', '30', 'Programming a Calculator');
INSERT INTO `Assignment` (` Assignment_Id`, `Due_Date`, `Due_Time`, `Hand_Up_Method`, `Module_id`, `Percentage_wt`, `Title`) VALUES (2, '2018-09-27', '12:00:00', 'Upload to Moodle', 'CSC102', '30', 'Build a Computer');
INSERT INTO `Assignment` (` Assignment_Id`, `Due_Date`, `Due_Time`, `Hand_Up_Method`, `Module_id`, `Percentage_wt`, `Title`) VALUES (3, '2018-11-26', '12:00:00', 'Upload to Moodle', 'MMT', '20', 'Mathematics Research');
```

### Question B.5

Enter two users into the user’s table (make this up yourself).

### Answer B.5

| User_Id | County   | Course_Id | Date_Created | Email                  | Gender | Password  | Phone      | Username |
|---------|----------|-----------|--------------|------------------------|--------|-----------|------------|----------|
| 1       | Limerick | CSM103    | 2025-09-01   | <user-one@no-reply.ie> | M      | let-me-in |            | user-one |
| 2       | Galway   | CSM103    | 2025-09-01   | <user-two@no-reply.ie> | F      | let-me-in | 0801231234 | user-two |

```sql
INSERT INTO `User` (`User_Id`, `County`, `Course_Id`, `Date_Created`, `Email`, `Gender`, `Password`, `Phone`, `Username`) VALUES (1, 'Limerick', 'CSM103', '2025-09-01', 'user-one@no-reply.ie', 'M', 'let-me-in', NULL, 'user-one');
INSERT INTO `User` (`User_Id`, `County`, `Course_Id`, `Date_Created`, `Email`, `Gender`, `Password`, `Phone`, `Username`) VALUES (2, 'Galway', 'CSM103', '2025-09-01', 'user-two@no-reply.ie', 'F', 'let-me-in', '0801231234', 'user-two');
```

### Question B.6

Create two questions in the forum tables.

### Answer B.6

| Question_Id | Posted_Date | Question_Title | Question_Content | User_Id |
|-------------|-------------|----------------|------------------|---------|
| 1           | 2025-09-01  | Q1             | Name?            | 1       |
| 2           | 2025-09-01  | Q2             | Age?             | 2       |

```sql
INSERT INTO `Forum` (`Question_Id`, `Posted_Date`, `Question_Title`, `Question_Content`, `User_Id`) VALUES (1, '2025-09-01', 'Q1', 'Name?', 1);
INSERT INTO `Forum` (`Question_Id`, `Posted_Date`, `Question_Title`, `Question_Content`, `User_Id`) VALUES (2, '2025-09-01', 'Q2', 'Age?', 2);
```

### Question B.7

Provide one reply to one of your questions.

### Answer B.7

| Reply_Id | Reply_Date | Reply_Content | User_Id | Question_Id |
|----------|------------|---------------|---------|-------------|
| 1        | 2025-09-01 | John Doe      | 1       | 1           |

```sql
INSERT INTO `Reply` (`Reply_Id`, `Reply_Date`, `Reply_Content`, `User_Id`, `Question_Id`) VALUES (1, '2025-09-01', 'John Doe', 1, 1);
```

## Section C – View and Queries

Write SQL commands for the following

### Question C.1

Create a View that shows the timetable for Group 1B for semester 1, order by Day, time ascend.  Also show the code to view the data within this View

### Answer C.1

```sql
CREATE  OR REPLACE VIEW Vw_Group1B_Sem1_Timetable AS
SELECT *
FROM Timetable
WHERE class_group = 'Group 1B' AND semester = 1
ORDER BY FIELD(`day`, 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri'), Start_time ASC;
```

```sql
SELECT * FROM Vw_Group1B_Sem1_Timetable;
```

### Question C.2

Create a view that shows all free classes for Group 1A for semester 1.

### Answer C.2

```sql
CREATE  OR REPLACE VIEW Vw_Group1A_Sem1_Free_Periods AS
SELECT DISTINCT `day`, start_time
FROM Timetable
WHERE class_group != 'Group 1A' AND semester = 1;
```

```sql
SELECT * FROM Vw_Group1A_Sem1_Free_Periods;
```

### Question C.3

Create a view that shows all assignment due (i.e. title, module Name, due date).   Must not show assignment where due date has passed.

### Answer C.3

```sql
CREATE  OR REPLACE VIEW Vw_Assignments_Due AS
SELECT a.title, m.module_name, a.due_date
FROM Assignment a
JOIN Module m ON a.module_id = m.module_id
WHERE a.due_date >= CurDate();
```

```sql
SELECT * FROM Vw_Assignments_Due;
```

### Question C.4

Create a view that shows the number of day left before the due date for each assignment (title, module name, hand up method, number of day left).  

### Answer C.4

---
