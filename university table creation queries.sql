-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`person` (
  `ssn` INT UNSIGNED NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `birth-date` DATE NOT NULL,
  `sex` ENUM('male', 'female') NOT NULL,
  `address` VARCHAR(45) NULL,
  `phone number` VARCHAR(11) NULL,
  PRIMARY KEY (`ssn`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `ssn_UNIQUE` ON `university`.`person` (`ssn` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`student` (
  `student-id` INT UNSIGNED NOT NULL,
  `major` INT UNSIGNED NOT NULL,
  `degree` ENUM('bs', 'ms', 'PhD') NOT NULL,
  `person_ssn` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`student-id`, `person_ssn`),
  CONSTRAINT `fk_student_person1`
    FOREIGN KEY (`person_ssn`)
    REFERENCES `university`.`person` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `student-id_UNIQUE` ON `university`.`student` (`student-id` ASC) VISIBLE;

CREATE INDEX `fk_student_person1_idx` ON `university`.`student` (`person_ssn` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`department` (
  `department-id` INT UNSIGNED NOT NULL,
  `departmet name` VARCHAR(20) NOT NULL,
  `department-address` VARCHAR(30) NULL,
  PRIMARY KEY (`department-id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `department-name_UNIQUE` ON `university`.`department` (`department-id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`employee` (
  `employee-id` INT NOT NULL,
  `salary` INT UNSIGNED NULL,
  `rank` ENUM('simple', 'manager') NULL,
  `person_ssn` INT UNSIGNED NOT NULL,
  `department_department-id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`employee-id`, `person_ssn`, `department_department-id`),
  CONSTRAINT `fk_employee_person1`
    FOREIGN KEY (`person_ssn`)
    REFERENCES `university`.`person` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_department1`
    FOREIGN KEY (`department_department-id`)
    REFERENCES `university`.`department` (`department-id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_employee_person1_idx` ON `university`.`employee` (`person_ssn` ASC) VISIBLE;

CREATE INDEX `fk_employee_department1_idx` ON `university`.`employee` (`department_department-id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course-id` INT UNSIGNED NOT NULL,
  `time` VARCHAR(3) NOT NULL,
  `year` YEAR(4) NOT NULL,
  `term` ENUM('1', '2') NOT NULL,
  `course-name` VARCHAR(20) NOT NULL,
  `credit-hour` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`course-id`, `time`, `year`, `term`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `course-id_UNIQUE` ON `university`.`course` (`course-id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`professor` (
  `professor-id` INT NOT NULL,
  `rank` ENUM('professor', 'associate professor', 'assistant professor', 'instructor') NULL,
  `department_department-id` INT UNSIGNED NOT NULL,
  `person_ssn` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`professor-id`),
  CONSTRAINT `fk_teacher_department1`
    FOREIGN KEY (`department_department-id`)
    REFERENCES `university`.`department` (`department-id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teacher_person1`
    FOREIGN KEY (`person_ssn`)
    REFERENCES `university`.`person` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_teacher_department1_idx` ON `university`.`professor` (`department_department-id` ASC) VISIBLE;

CREATE INDEX `fk_teacher_person1_idx` ON `university`.`professor` (`person_ssn` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`book` (
  `book-id` INT NOT NULL,
  `title` VARCHAR(20) NULL,
  `author-name` VARCHAR(30) NULL,
  `publish year` YEAR(4) NULL,
  `edition` INT NULL,
  `publisher` VARCHAR(20) NULL,
  PRIMARY KEY (`book-id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `book-id_UNIQUE` ON `university`.`book` (`book-id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`library`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`library` (
  `lib-id` INT NOT NULL,
  `library-name` VARCHAR(30) NOT NULL,
  `contact no` VARCHAR(11) NULL,
  `lib-loc` VARCHAR(30) NULL,
  PRIMARY KEY (`lib-id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`register`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`register` (
  `student_student-id` INT UNSIGNED NOT NULL,
  `student_person_ssn` INT UNSIGNED NOT NULL,
  `employee_employee-id` INT NOT NULL,
  `employee_department_department-id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`student_student-id`, `student_person_ssn`, `employee_employee-id`, `employee_department_department-id`),
  CONSTRAINT `fk_student_has_employee_student1`
    FOREIGN KEY (`student_student-id` , `student_person_ssn`)
    REFERENCES `university`.`student` (`student-id` , `person_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_register_employee1`
    FOREIGN KEY (`employee_employee-id` , `employee_department_department-id`)
    REFERENCES `university`.`employee` (`employee-id` , `department_department-id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_student_has_employee_student1_idx` ON `university`.`register` (`student_student-id` ASC, `student_person_ssn` ASC) VISIBLE;

CREATE INDEX `fk_register_employee1_idx` ON `university`.`register` (`employee_employee-id` ASC, `employee_department_department-id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`student_borrows_book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`student_borrows_book` (
  `student_student-id` INT UNSIGNED NOT NULL,
  `book_book-id` INT NOT NULL,
  `library_lib-id` INT NOT NULL,
  PRIMARY KEY (`student_student-id`, `book_book-id`, `library_lib-id`),
  CONSTRAINT `fk_student_has_library_student1`
    FOREIGN KEY (`student_student-id`)
    REFERENCES `university`.`student` (`student-id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_borrows_book_book1`
    FOREIGN KEY (`book_book-id`)
    REFERENCES `university`.`book` (`book-id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_borrows_book_library1`
    FOREIGN KEY (`library_lib-id`)
    REFERENCES `university`.`library` (`lib-id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_student_has_library_student1_idx` ON `university`.`student_borrows_book` (`student_student-id` ASC) VISIBLE;

CREATE INDEX `fk_student_borrows_book_book1_idx` ON `university`.`student_borrows_book` (`book_book-id` ASC) VISIBLE;

CREATE INDEX `fk_student_borrows_book_library1_idx` ON `university`.`student_borrows_book` (`library_lib-id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`prerequisite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`prerequisite` (
  `course_course-id1` INT UNSIGNED NOT NULL,
  `course_course-id2` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`course_course-id1`, `course_course-id2`),
  CONSTRAINT `fk_course_has_course_course1`
    FOREIGN KEY (`course_course-id1`)
    REFERENCES `university`.`course` (`course-id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_has_course_course2`
    FOREIGN KEY (`course_course-id2`)
    REFERENCES `university`.`course` (`course-id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_course_has_course_course2_idx` ON `university`.`prerequisite` (`course_course-id2` ASC) VISIBLE;

CREATE INDEX `fk_course_has_course_course1_idx` ON `university`.`prerequisite` (`course_course-id1` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`libraries and departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`libraries and departments` (
  `library_lib-id` INT NOT NULL,
  `department_department-id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`library_lib-id`, `department_department-id`),
  CONSTRAINT `fk_library_has_department_library1`
    FOREIGN KEY (`library_lib-id`)
    REFERENCES `university`.`library` (`lib-id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_library_has_department_department1`
    FOREIGN KEY (`department_department-id`)
    REFERENCES `university`.`department` (`department-id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_library_has_department_department1_idx` ON `university`.`libraries and departments` (`department_department-id` ASC) VISIBLE;

CREATE INDEX `fk_library_has_department_library1_idx` ON `university`.`libraries and departments` (`library_lib-id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`library_has_book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`library_has_book` (
  `library_lib-id` INT NOT NULL,
  `book_book-id` INT NOT NULL,
  PRIMARY KEY (`library_lib-id`, `book_book-id`),
  CONSTRAINT `fk_library_has_book_library1`
    FOREIGN KEY (`library_lib-id`)
    REFERENCES `university`.`library` (`lib-id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_library_has_book_book1`
    FOREIGN KEY (`book_book-id`)
    REFERENCES `university`.`book` (`book-id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_library_has_book_book1_idx` ON `university`.`library_has_book` (`book_book-id` ASC) VISIBLE;

CREATE INDEX `fk_library_has_book_library1_idx` ON `university`.`library_has_book` (`library_lib-id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`student_has_course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`student_has_course` (
  `student_student-id` INT UNSIGNED NOT NULL,
  `course_course-id` INT UNSIGNED NOT NULL,
  `course_time` VARCHAR(3) NOT NULL,
  `course_year` YEAR(4) NOT NULL,
  `course_term` ENUM('1', '2') NOT NULL,
  PRIMARY KEY (`student_student-id`, `course_course-id`, `course_time`, `course_year`, `course_term`),
  CONSTRAINT `fk_student_has_course_student1`
    FOREIGN KEY (`student_student-id`)
    REFERENCES `university`.`student` (`student-id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_has_course_course1`
    FOREIGN KEY (`course_course-id` , `course_time` , `course_year` , `course_term`)
    REFERENCES `university`.`course` (`course-id` , `time` , `year` , `term`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_student_has_course_course1_idx` ON `university`.`student_has_course` (`course_course-id` ASC, `course_time` ASC, `course_year` ASC, `course_term` ASC) VISIBLE;

CREATE INDEX `fk_student_has_course_student1_idx` ON `university`.`student_has_course` (`student_student-id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`class schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`class schedule` (
  `professor_professor-id` INT NOT NULL,
  `course_course-id` INT UNSIGNED NOT NULL,
  `course_time` VARCHAR(3) NOT NULL,
  `course_year` YEAR(4) NOT NULL,
  `course_term` ENUM('1', '2') NOT NULL,
  PRIMARY KEY (`professor_professor-id`, `course_course-id`, `course_time`, `course_year`, `course_term`),
  CONSTRAINT `fk_course_has_professor_course1`
    FOREIGN KEY (`course_course-id` , `course_time` , `course_year` , `course_term`)
    REFERENCES `university`.`course` (`course-id` , `time` , `year` , `term`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_has_professor_professor1`
    FOREIGN KEY (`professor_professor-id`)
    REFERENCES `university`.`professor` (`professor-id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_course_has_professor_professor1_idx` ON `university`.`class schedule` (`professor_professor-id` ASC) VISIBLE;

CREATE INDEX `fk_course_has_professor_course1_idx` ON `university`.`class schedule` (`course_course-id` ASC, `course_time` ASC, `course_year` ASC, `course_term` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
