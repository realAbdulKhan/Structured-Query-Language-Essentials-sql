
# Structured Query Language (SQL) - Project

***This assignment is worth 100% of your overall mark***

***Upload your completed assessment to the link provided on Moodle.***

*Plagiarism of any kind will incur a 0% mark.*

*Late submission will not be accepted - 0% will be awarded for late hand-in.*

**Guidelines:**

*You are responsible for implementing the database for a student app that allows students to view their time table, view assingments due and take part in a forum.  The following contains the schema for the database.*

## Relational Schema

**COURSE**(course_id, course_name)

**MODULE** (module_id  module_name, course_id\*)

**COURSE_MODULE**(course_ID\*, module_ID\*)

**USER**(user_id, user_name, email, date_created,  phone, course_id \*)

**GRADE**(module_id\* , student_id\*, grade)

**TIMETABLE** (module_id\*, semester, day, time, room , class_group)

**ASSIGNMENT**(assignment_id, title, due_date, percentage_wt, hand_up_method, module_id\*)

**FORUM**(question_id, question_title, question_content, date_time, user_id)

**REPLY**( reply_id, question_id\*, reply_content, date_time, user_id\*)

*Note: underline attributes make up the primary key for that relation,  \* indicates the attribute is a foreign key.*

*If data or the case study is unclear, or information missing (e.g. data types, column constraints etc.) please make assumptions as to what it most appropriate.*

*Save the file as a script file, i.e. with a .SQL extension that can be run.  There should be no text in the file that is not code or comments.*
**

**Section A – Creating the tables**:

## Section A

### Question A.1

Write the MySQL commands to create the tables from the relational schema above.  

   *Take the following into consideration when creating the relations*:

- Decide on the **most appropriate data types** for each attribute
- Create correct constraints for primary (underlined) and foreign keys (\*).
- All primary and foreign key to be created be at table level, and should be named.

- COURSE:
  - course_id should be of type varchar(20)
  - course_name cannot be NULL and must be unique
- MODULE:
  - module_id should be varchar(255)
  - module_name cannot be null
- USER:
  - user_id is an auto_increment type
  - gender can only be M or F value
  - All fields cannot contain a null value
  - Default value for *county* must `Tipperary`
- GRADE
  - Grade is a numeric value
- TIMETABLE
  - Day can only be one of the following values (Mon, Tues, Wed, Thurs, Fri).
  - Semester can only be one of the following values(1, 2, 3, 4, 5, 6, 7, 8)
- ASSIGNMENT
  - assignment_id should be an auto increment number.
- FORUM
  - question_id should be an auto increment number.
- REPLY
  - reply_id should be an auto increment number.

### Answer A.1

```sql
CREATE TABLE IF NOT EXISTS `Student_db`.`Course` (
  `Course_Id` VARCHAR(20) NOT NULL,
  `Course_Name` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `Course_Id_UNIQUE` (`Course_Id` ASC) ,
  PRIMARY KEY (`Course_Id`),
  UNIQUE INDEX `Course_Name_UNIQUE` (`Course_Name` ASC) );


-- -----------------------------------------------------
-- Table `Student_db`.`Module`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_db`.`Module` (
  `Module_Id` VARCHAR(255) NOT NULL,
  `Module_Name` VARCHAR(255) NOT NULL,
  `Course_Id` VARCHAR(20) NOT NULL,
  UNIQUE INDEX `Course_Id_UNIQUE` (`Module_Id` ASC) ,
  PRIMARY KEY (`Module_Id`),
  INDEX `fk_Module_Course_idx` (`Course_Id` ASC) ,
  CONSTRAINT `fk_Module_Course`
    FOREIGN KEY (`Course_Id`)
    REFERENCES `Student_db`.`Course` (`Course_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );
```

## Section B – Inserting records (data) into the tables:**

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

| module_id | module_name                                 |
|-----------|---------------------------------------------|
| CSC102    | Computer System Concepts                    |
| ECOMP     | Electronics for Computing                   |
| IPD104    | Interpersonal Development                   |
| MM102     | Mathematical Methods                        |
| MMT       | Mathematics for Computing                   |
| Net1      | Introduction to Computer Networks           |
| OOP102    | Introduction to Object Oriented Programming |
| OS1       | Operating Systems Fundamentals              |
| OSM2      | Operating Systems Management                |
| PDC101    | Programme Design Concepts                   |
| Prog 101  | Introduction to Programming                 |
| WDF       | Web Development Fundamentals                |

### Answer B.2

### Question B.3

Add in your own data to the *course_module* table and the *timetable* table (3 records).

### Answer B.3

### Question B.4

Insert the following data into the assignment table.

| Assignment ID | Title                    | Due Date   | Time Due | Percent Wt | Hand Up Method   | Module ID |
|---------------|--------------------------|------------|----------|------------|------------------|-----------|
| 1             | Programming a Calculator | 2018-10-04 | 12:00:00 | 30         | Upload to Moodle | Prog101   |
| 2             | Build a Computer         | 2018-09-27 | 12:00:00 | 30         | Upload to Moodle | CSC102    |
| 3             | Mathematics Research     | 2018-11-26 | 12:00:00 | 20         | Upload to Moodle | MMT       |

### Answer B.4

### Question B.5

Enter two users into the user’s table (make this up yourself).

### Answer B.5

### Question B.6

Create two questions in the forum tables.

### Answer B.6

### Question B.7

Provide one reply to one of your questions.

### Answer B.7

## Section C – View and Queries

Write SQL commands for the following

### Question C.1

Create a View that shows the timetable for Group 1B for semester 1, order by Day, time ascend.  Also show the code to view the data within this View

### Answer C.1

### Question C.2

Create a view that shows all free classes for Group 1A for semester 1.

### Answer C.2

### Question C.3

Create a view that shows all assignment due (i.e. title, module Name, due date).   Must not show assignment where due date has passed.

### Answer C.3

### Question C.4

Create a view that shows the number of day left before the due date for each assignment (title, module name, hand up method, number of day left).  

### Answer C.4

---
