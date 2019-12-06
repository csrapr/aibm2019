-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bd_urg
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bd_urg
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_urg` DEFAULT CHARACTER SET utf8 ;
USE `bd_urg` ;

-- -----------------------------------------------------
-- Table `bd_urg`.`urg_inform_geral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_urg`.`urg_inform_geral` (
  `URG_EPISODIO` INT NULL,
  `DATAHORA_ADM` DATETIME NULL,
  `DATAHORA_ALTA` DATETIME NULL,
  `ALTA_DES_ESPECIALIDADE` TEXT(128) NULL,
  `DES_LOCAL` TEXT(128) NULL,
  `DES_PROVENIENCIA` TEXT(128) NULL,
  `SEXO` TEXT(128) NULL,
  `DTA_NASCIMENTO` TEXT(128) NULL,
  `DES_CAUSA` TEXT(128) NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_urg`.`dim_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_urg`.`dim_data` (
  `id_data` INT NOT NULL AUTO_INCREMENT,
  `valor` DATE NOT NULL,
  PRIMARY KEY (`id_data`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_urg`.`dim_des_local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_urg`.`dim_des_local` (
  `id_des_local` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_des_local`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_urg`.`dim_des_proveniencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_urg`.`dim_des_proveniencia` (
  `id_des_proveniencia` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_des_proveniencia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_urg`.`dim_des_causa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_urg`.`dim_des_causa` (
  `id_des_causa` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_des_causa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_urg`.`dim_sexo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_urg`.`dim_sexo` (
  `id_sexo` INT NOT NULL AUTO_INCREMENT,
  `valor` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_sexo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_urg`.`dim_alta_des_especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_urg`.`dim_alta_des_especialidade` (
  `id_alta_des_especialidade` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_alta_des_especialidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_urg`.`fact_urgencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_urg`.`fact_urgencia` (
  `id_fact` INT NOT NULL AUTO_INCREMENT,
  `urg_episodio` INT NOT NULL,
  `adm_time` TIME NOT NULL,
  `alta_time` TIME NOT NULL,
  `data_adm` INT NOT NULL,
  `data_alta` INT NOT NULL,
  `local` INT NOT NULL,
  `proveniencia` INT NOT NULL,
  `causa` INT NOT NULL,
  `sexo` INT NOT NULL,
  `especialidade` INT NOT NULL,
  `data_nascimento` INT NOT NULL,
  PRIMARY KEY (`id_fact`),
  INDEX `fk_fact_urgencia_dim_data_idx` (`data_adm` ASC) VISIBLE,
  INDEX `fk_fact_urgencia_dim_data1_idx` (`data_alta` ASC) VISIBLE,
  INDEX `fk_fact_urgencia_dim_des_local1_idx` (`local` ASC) VISIBLE,
  INDEX `fk_fact_urgencia_dim_des_proveniencia1_idx` (`proveniencia` ASC) VISIBLE,
  INDEX `fk_fact_urgencia_dim_des_causa1_idx` (`causa` ASC) VISIBLE,
  INDEX `fk_fact_urgencia_dim_sexo1_idx` (`sexo` ASC) VISIBLE,
  INDEX `fk_fact_urgencia_dim_alta_des_especialidade1_idx` (`especialidade` ASC) VISIBLE,
  INDEX `fk_fact_urgencia_dim_data2_idx` (`data_nascimento` ASC) VISIBLE,
  CONSTRAINT `fk_fact_urgencia_dim_data`
    FOREIGN KEY (`data_adm`)
    REFERENCES `bd_urg`.`dim_data` (`id_data`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_urgencia_dim_data1`
    FOREIGN KEY (`data_alta`)
    REFERENCES `bd_urg`.`dim_data` (`id_data`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_urgencia_dim_des_local1`
    FOREIGN KEY (`local`)
    REFERENCES `bd_urg`.`dim_des_local` (`id_des_local`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_urgencia_dim_des_proveniencia1`
    FOREIGN KEY (`proveniencia`)
    REFERENCES `bd_urg`.`dim_des_proveniencia` (`id_des_proveniencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_urgencia_dim_des_causa1`
    FOREIGN KEY (`causa`)
    REFERENCES `bd_urg`.`dim_des_causa` (`id_des_causa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_urgencia_dim_sexo1`
    FOREIGN KEY (`sexo`)
    REFERENCES `bd_urg`.`dim_sexo` (`id_sexo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_urgencia_dim_alta_des_especialidade1`
    FOREIGN KEY (`especialidade`)
    REFERENCES `bd_urg`.`dim_alta_des_especialidade` (`id_alta_des_especialidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_urgencia_dim_data2`
    FOREIGN KEY (`data_nascimento`)
    REFERENCES `bd_urg`.`dim_data` (`id_data`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
