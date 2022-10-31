-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema flight_system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema flight_system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `flight_system` DEFAULT CHARACTER SET utf8 ;
USE `flight_system` ;

-- -----------------------------------------------------
-- Table `flight_system`.`passengers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_system`.`passengers` (
  `passenger_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`passenger_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_system`.`airlines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_system`.`airlines` (
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_system`.`airports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_system`.`airports` (
  `arrival_IATA_Code` INT NOT NULL,
  `departure_IATA_Code` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`arrival_IATA_Code`, `departure_IATA_Code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_system`.`flights`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_system`.`flights` (
  `number` INT NOT NULL,
  `airlines_name` VARCHAR(45) NOT NULL,
  `arrival_IATA_Code` INT NOT NULL,
  `departure_IATA_Code` INT NOT NULL,
  `departure_date_time` DATETIME NOT NULL,
  `arrival_date_time` DATETIME NOT NULL,
  `duration_in_minutes` TIME NOT NULL,
  `distance_in_miles` INT NOT NULL,
  PRIMARY KEY (`number`, `airlines_name`, `arrival_IATA_Code`, `departure_IATA_Code`),
  INDEX `fk_flights_airlines1_idx` (`airlines_name` ASC) VISIBLE,
  INDEX `fk_flights_airports1_idx` (`arrival_IATA_Code` ASC, `departure_IATA_Code` ASC) VISIBLE,
  CONSTRAINT `fk_flights_airlines1`
    FOREIGN KEY (`airlines_name`)
    REFERENCES `flight_system`.`airlines` (`name`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_flights_airports1`
    FOREIGN KEY (`arrival_IATA_Code` , `departure_IATA_Code`)
    REFERENCES `flight_system`.`airports` (`arrival_IATA_Code` , `departure_IATA_Code`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_system`.`flight_class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_system`.`flight_class` (
  `class_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`class_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_system`.`tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_system`.`tickets` (
  `ticket_number` INT NOT NULL,
  `passenger_id` INT NOT NULL,
  `flights_number` INT NOT NULL,
  `class_id` INT NOT NULL,
  `confirmation_number` INT NOT NULL,
  `price` DECIMAL(9,2) NOT NULL,
  PRIMARY KEY (`ticket_number`, `passenger_id`, `flights_number`, `class_id`),
  INDEX `fk_tickets_flights1_idx` (`flights_number` ASC) VISIBLE,
  INDEX `fk_tickets_passengers1_idx` (`passenger_id` ASC) VISIBLE,
  INDEX `fk_tickets_flight_class1_idx` (`class_id` ASC) VISIBLE,
  CONSTRAINT `fk_tickets_flights1`
    FOREIGN KEY (`flights_number`)
    REFERENCES `flight_system`.`flights` (`number`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tickets_passengers1`
    FOREIGN KEY (`passenger_id`)
    REFERENCES `flight_system`.`passengers` (`passenger_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tickets_flight_class1`
    FOREIGN KEY (`class_id`)
    REFERENCES `flight_system`.`flight_class` (`class_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
