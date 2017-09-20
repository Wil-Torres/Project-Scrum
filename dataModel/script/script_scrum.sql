use project_scrum;
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema project_scrum
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema project_scrum
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `project_scrum` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema project_scrum
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema project_scrum
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `project_scrum` DEFAULT CHARACTER SET utf8 ;
USE `project_scrum` ;

-- -----------------------------------------------------
-- Table `project_scrum`.`proyectos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_scrum`.`proyectos` (
  `proyectos_id` INT NOT NULL AUTO_INCREMENT,
  `proyectos_nombre` VARCHAR(45) NULL,
  `proyectos_observaciones` VARCHAR(45) NULL,
  PRIMARY KEY (`proyectos_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_scrum`.`backlog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_scrum`.`backlog` (
  `backlog_id` INT NOT NULL AUTO_INCREMENT,
  `backlog_nombre` VARCHAR(45) NOT NULL,
  `backlog_descripcion` VARCHAR(100) NULL,
  `backlog_prioridad` INT NULL,
  `backlog_estado` TINYINT(1) NULL,
  `backlog_tareas` BLOB NULL,
  `backlog_proyecto` INT NULL,
  PRIMARY KEY (`backlog_id`),
  INDEX `proyecto_backlog_idx` (`backlog_proyecto` ASC),
  CONSTRAINT `proyecto_backlog`
    FOREIGN KEY (`backlog_proyecto`)
    REFERENCES `project_scrum`.`proyectos` (`proyectos_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_scrum`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_scrum`.`estados` (
  `estados_id` INT NOT NULL AUTO_INCREMENT,
  `estados_nombre` VARCHAR(45) NULL COMMENT 'Especifica las los estados de una tarea \n(ToDo, InProgress, Testing, Done)',
  `estados_descripcion` VARCHAR(45) NULL COMMENT 'Especifica el estado actual de la tarea.',
  PRIMARY KEY (`estados_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_scrum`.`tareas_demora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_scrum`.`tareas_demora` (
  `tareasD_id` INT NOT NULL AUTO_INCREMENT,
  `tareasD_descripcion` VARCHAR(45) NULL,
  `tareas_demoracol` VARCHAR(45) NULL,
  PRIMARY KEY (`tareasD_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_scrum`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_scrum`.`roles` (
  `roles_id` INT NOT NULL AUTO_INCREMENT,
  `roles_descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`roles_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_scrum`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_scrum`.`usuarios` (
  `usuarios_id` INT NOT NULL,
  `usuarios_usuario` VARCHAR(45) NULL,
  `usuarios_password` VARCHAR(45) NULL,
  `usuarios_nombre_completo` VARCHAR(45) NULL,
  `usuarios_jefe` INT(11) NULL,
  `usuarios_rol` INT(11) NULL,
  PRIMARY KEY (`usuarios_id`),
  INDEX `usuario_rol_idx` (`usuarios_rol` ASC),
  CONSTRAINT `usuario_rol`
    FOREIGN KEY (`usuarios_rol`)
    REFERENCES `project_scrum`.`roles` (`roles_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_scrum`.`tareas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_scrum`.`tareas` (
  `tarea_id` INT NOT NULL AUTO_INCREMENT,
  `tareas_historia` VARCHAR(45) NULL,
  `tareas_nombre` VARCHAR(45) NULL,
  `tareas_fecha` DATETIME NULL,
  `tareas_origen` INT NULL,
  `tareas_estado` INT NULL,
  `tareas_responsable` INT NULL,
  `tareas_demora` INT NULL,
  `tareas_puntos` INT NULL,
  `tareas_puntos_ejecutados` INT NULL,
  `tareas_finalizacion` TINYINT(1) NULL,
  `tareas_backlog` INT NULL,
  PRIMARY KEY (`tarea_id`),
  INDEX `tareas_estado_idx` (`tareas_estado` ASC),
  INDEX `tareas_origen_idx` (`tareas_origen` ASC),
  INDEX `tareas_demora_idx` (`tareas_demora` ASC),
  INDEX `tareas_usuarios_idx` (`tareas_responsable` ASC),
  INDEX `tareas_backlog_idx` (`tareas_backlog` ASC),
  CONSTRAINT `tareas_estado`
    FOREIGN KEY (`tareas_estado`)
    REFERENCES `project_scrum`.`estados` (`estados_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tareas_origen`
    FOREIGN KEY (`tareas_origen`)
    REFERENCES `project_scrum`.`tareas` (`tarea_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tareas_demora`
    FOREIGN KEY (`tareas_demora`)
    REFERENCES `project_scrum`.`tareas_demora` (`tareasD_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tareas_usuarios`
    FOREIGN KEY (`tareas_responsable`)
    REFERENCES `project_scrum`.`usuarios` (`usuarios_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tareas_backlog`
    FOREIGN KEY (`tareas_backlog`)
    REFERENCES `project_scrum`.`backlog` (`backlog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_scrum`.`bitacora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_scrum`.`bitacora` (
  `bitacora_id` INT NOT NULL AUTO_INCREMENT,
  `bitacora_fecha` DATE NULL,
  `bitacora_hora_inicio` TIME NULL,
  `bitacora_hora_fin` TIME NULL,
  `Observaciones` VARCHAR(100) NULL,
  `bitacoracol` VARCHAR(45) NULL,
  PRIMARY KEY (`bitacora_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_scrum`.`sprints`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_scrum`.`sprints` (
  `sprints_id` INT NOT NULL AUTO_INCREMENT,
  `sprints_fecha_inicio` DATETIME NULL,
  `sprints_fecha_fin` DATETIME NULL,
  `sprints_historia` INT NULL,
  `sprints_bitacora` INT NULL,
  PRIMARY KEY (`sprints_id`),
  INDEX `sprint_bitacora_idx` (`sprints_bitacora` ASC),
  INDEX `sprint_backlog_idx` (`sprints_historia` ASC),
  CONSTRAINT `sprint_bitacora`
    FOREIGN KEY (`sprints_bitacora`)
    REFERENCES `project_scrum`.`bitacora` (`bitacora_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sprint_backlog`
    FOREIGN KEY (`sprints_historia`)
    REFERENCES `project_scrum`.`backlog` (`backlog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `project_scrum` ;

-- -----------------------------------------------------
-- Table `project_scrum`.`rols`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_scrum`.`rols` (
  `rols_id` INT(11) NOT NULL AUTO_INCREMENT,
  `rols_name` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`rols_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
