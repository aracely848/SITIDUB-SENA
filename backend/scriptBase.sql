-- MySQL Script generated by MySQL Workbench
-- Fri Nov  1 15:37:03 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`INFORMACION PERSONAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`INFORMACION PERSONAL` (
  `idInformacionPersonal` INT NOT NULL,
  `lugarNacimiento` VARCHAR(45) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `rh` VARCHAR(5) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idInformacionPersonal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EPS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EPS` (
  `idSeguridadSocial` INT NOT NULL,
  `eps` VARCHAR(30) NULL,
  `estrato` INT NOT NULL,
  PRIMARY KEY (`idSeguridadSocial`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TIPO DOCUMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TIPO DOCUMENTO` (
  `tipoDocumento` VARCHAR(5) NOT NULL,
  `lugarExpedicion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tipoDocumento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PERSONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PERSONA` (
  `numeroDocumento` VARCHAR(12) NOT NULL,
  `nombre1` VARCHAR(30) NOT NULL,
  `nombre2` VARCHAR(30) NULL,
  `apellido1` VARCHAR(30) NOT NULL,
  `apellido2` VARCHAR(30) NULL,
  `INFORMACION PERSONAL_idInformacionPersonal` INT NOT NULL,
  `SEGURIDAD SOCIAL_idSeguridadSocial` INT NOT NULL,
  `TIPO DOCUMENTO_tipoDocumento` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`numeroDocumento`, `TIPO DOCUMENTO_tipoDocumento`),
  INDEX `fk_PERSONA_INFORMACION PERSONAL1_idx` (`INFORMACION PERSONAL_idInformacionPersonal` ASC) VISIBLE,
  INDEX `fk_PERSONA_SEGURIDAD SOCIAL1_idx` (`SEGURIDAD SOCIAL_idSeguridadSocial` ASC) VISIBLE,
  INDEX `fk_PERSONA_TIPO DOCUMENTO1_idx` (`TIPO DOCUMENTO_tipoDocumento` ASC) VISIBLE,
  CONSTRAINT `fk_PERSONA_INFORMACION PERSONAL1`
    FOREIGN KEY (`INFORMACION PERSONAL_idInformacionPersonal`)
    REFERENCES `mydb`.`INFORMACION PERSONAL` (`idInformacionPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PERSONA_SEGURIDAD SOCIAL1`
    FOREIGN KEY (`SEGURIDAD SOCIAL_idSeguridadSocial`)
    REFERENCES `mydb`.`EPS` (`idSeguridadSocial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PERSONA_TIPO DOCUMENTO1`
    FOREIGN KEY (`TIPO DOCUMENTO_tipoDocumento`)
    REFERENCES `mydb`.`TIPO DOCUMENTO` (`tipoDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CONTACTO TELEFONICO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CONTACTO TELEFONICO` (
  `tipo` VARCHAR(15) NOT NULL,
  `clase_telefono` VARCHAR(20) NOT NULL,
  `numero_telefono` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CONTACTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CONTACTO` (
  `idCONTACTO` INT NOT NULL,
  `email_contacto` VARCHAR(50) NULL,
  `PERSONA_numeroDocumento` VARCHAR(12) NOT NULL,
  `CONTACTO TELEFONICO_tipo` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idCONTACTO`),
  INDEX `fk_CONTACTO_PERSONA1_idx` (`PERSONA_numeroDocumento` ASC) VISIBLE,
  INDEX `fk_CONTACTO_CONTACTO TELEFONICO1_idx` (`CONTACTO TELEFONICO_tipo` ASC) VISIBLE,
  CONSTRAINT `fk_CONTACTO_PERSONA1`
    FOREIGN KEY (`PERSONA_numeroDocumento`)
    REFERENCES `mydb`.`PERSONA` (`numeroDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONTACTO_CONTACTO TELEFONICO1`
    FOREIGN KEY (`CONTACTO TELEFONICO_tipo`)
    REFERENCES `mydb`.`CONTACTO TELEFONICO` (`tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`GRADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`GRADO` (
  `curso` VARCHAR(10) NOT NULL,
  `grado` VARCHAR(15) NULL,
  PRIMARY KEY (`curso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OBSERVACIONES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OBSERVACIONES` (
  `tipo_observacion` VARCHAR(15) NOT NULL,
  `des_observacion` VARCHAR(45) NOT NULL,
  `PERSONA_numeroDocumento` VARCHAR(12) NOT NULL,
  `PERSONA_TIPO DOCUMENTO_tipoDocumento` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`tipo_observacion`),
  INDEX `fk_OBSERVACIONES_PERSONA1_idx` (`PERSONA_numeroDocumento` ASC, `PERSONA_TIPO DOCUMENTO_tipoDocumento` ASC) VISIBLE,
  CONSTRAINT `fk_OBSERVACIONES_PERSONA1`
    FOREIGN KEY (`PERSONA_numeroDocumento` , `PERSONA_TIPO DOCUMENTO_tipoDocumento`)
    REFERENCES `mydb`.`PERSONA` (`numeroDocumento` , `TIPO DOCUMENTO_tipoDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`METODO DE PAGO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`METODO DE PAGO` (
  `idMETODO_PAGO` INT NOT NULL,
  PRIMARY KEY (`idMETODO_PAGO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PAGO_MES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PAGO_MES` (
  `numeroComprobante` VARCHAR(30) NOT NULL,
  `fechaPago` DATE NOT NULL,
  `METODO DE PAGO_idMETODO_PAGO` INT NOT NULL,
  PRIMARY KEY (`numeroComprobante`),
  INDEX `fk_PAGO MES_METODO DE PAGO1_idx` (`METODO DE PAGO_idMETODO_PAGO` ASC) VISIBLE,
  CONSTRAINT `fk_PAGO MES_METODO DE PAGO1`
    FOREIGN KEY (`METODO DE PAGO_idMETODO_PAGO`)
    REFERENCES `mydb`.`METODO DE PAGO` (`idMETODO_PAGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ESTUDIANTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ESTUDIANTE` (
  `PERSONA_numeroDocumento` VARCHAR(12) NOT NULL,
  `PERSONA_TIPO DOCUMENTO_tipoDocumento` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`PERSONA_numeroDocumento`, `PERSONA_TIPO DOCUMENTO_tipoDocumento`),
  CONSTRAINT `fk_ESTUDIANTE_PERSONA1`
    FOREIGN KEY (`PERSONA_numeroDocumento` , `PERSONA_TIPO DOCUMENTO_tipoDocumento`)
    REFERENCES `mydb`.`PERSONA` (`numeroDocumento` , `TIPO DOCUMENTO_tipoDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = ScaleDB;


-- -----------------------------------------------------
-- Table `mydb`.`MATRICULA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MATRICULA` (
  `idPension` INT NOT NULL,
  `GRADO_curso` VARCHAR(10) NOT NULL,
  `ESTUDIANTE_PERSONA_numeroDocumento` VARCHAR(12) NOT NULL,
  `ESTUDIANTE_PERSONA_TIPO DOCUMENTO_tipoDocumento` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`idPension`),
  INDEX `fk_MATRICULA_GRADO1_idx` (`GRADO_curso` ASC) VISIBLE,
  INDEX `fk_MATRICULA_ESTUDIANTE1_idx` (`ESTUDIANTE_PERSONA_numeroDocumento` ASC, `ESTUDIANTE_PERSONA_TIPO DOCUMENTO_tipoDocumento` ASC) VISIBLE,
  CONSTRAINT `fk_MATRICULA_GRADO1`
    FOREIGN KEY (`GRADO_curso`)
    REFERENCES `mydb`.`GRADO` (`curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MATRICULA_ESTUDIANTE1`
    FOREIGN KEY (`ESTUDIANTE_PERSONA_numeroDocumento` , `ESTUDIANTE_PERSONA_TIPO DOCUMENTO_tipoDocumento`)
    REFERENCES `mydb`.`ESTUDIANTE` (`PERSONA_numeroDocumento` , `PERSONA_TIPO DOCUMENTO_tipoDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RESPONSABLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RESPONSABLE` (
  `ocupacion` VARCHAR(35) NOT NULL,
  `profesion` VARCHAR(35) NOT NULL,
  `PERSONA_numeroDocumento` VARCHAR(12) NOT NULL,
  `PERSONA_TIPO DOCUMENTO_tipoDocumento` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`PERSONA_numeroDocumento`, `PERSONA_TIPO DOCUMENTO_tipoDocumento`),
  CONSTRAINT `fk_RESPONSABLE_PERSONA1`
    FOREIGN KEY (`PERSONA_numeroDocumento` , `PERSONA_TIPO DOCUMENTO_tipoDocumento`)
    REFERENCES `mydb`.`PERSONA` (`numeroDocumento` , `TIPO DOCUMENTO_tipoDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RESPONSABLE_has_ESTUDIANTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RESPONSABLE_has_ESTUDIANTE` (
  `RESPONSABLE_PERSONA_numeroDocumento` VARCHAR(12) NOT NULL,
  `RESPONSABLE_PERSONA_TIPO DOCUMENTO_tipoDocumento` VARCHAR(5) NOT NULL,
  `ESTUDIANTE_PERSONA_numeroDocumento` VARCHAR(12) NOT NULL,
  `ESTUDIANTE_PERSONA_TIPO DOCUMENTO_tipoDocumento` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`RESPONSABLE_PERSONA_numeroDocumento`, `RESPONSABLE_PERSONA_TIPO DOCUMENTO_tipoDocumento`, `ESTUDIANTE_PERSONA_numeroDocumento`, `ESTUDIANTE_PERSONA_TIPO DOCUMENTO_tipoDocumento`),
  INDEX `fk_RESPONSABLE_has_ESTUDIANTE_ESTUDIANTE1_idx` (`ESTUDIANTE_PERSONA_numeroDocumento` ASC, `ESTUDIANTE_PERSONA_TIPO DOCUMENTO_tipoDocumento` ASC) VISIBLE,
  INDEX `fk_RESPONSABLE_has_ESTUDIANTE_RESPONSABLE1_idx` (`RESPONSABLE_PERSONA_numeroDocumento` ASC, `RESPONSABLE_PERSONA_TIPO DOCUMENTO_tipoDocumento` ASC) VISIBLE,
  CONSTRAINT `fk_RESPONSABLE_has_ESTUDIANTE_RESPONSABLE1`
    FOREIGN KEY (`RESPONSABLE_PERSONA_numeroDocumento` , `RESPONSABLE_PERSONA_TIPO DOCUMENTO_tipoDocumento`)
    REFERENCES `mydb`.`RESPONSABLE` (`PERSONA_numeroDocumento` , `PERSONA_TIPO DOCUMENTO_tipoDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RESPONSABLE_has_ESTUDIANTE_ESTUDIANTE1`
    FOREIGN KEY (`ESTUDIANTE_PERSONA_numeroDocumento` , `ESTUDIANTE_PERSONA_TIPO DOCUMENTO_tipoDocumento`)
    REFERENCES `mydb`.`ESTUDIANTE` (`PERSONA_numeroDocumento` , `PERSONA_TIPO DOCUMENTO_tipoDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PARENTESCO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PARENTESCO` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MATRICULA_has_PAGO_MES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MATRICULA_has_PAGO_MES` (
  `MATRICULA_idPension` INT NOT NULL,
  `PAGO_MES_numeroComprobante` VARCHAR(30) NOT NULL,
  `MES` VARCHAR(45) NULL,
  `VALOR` VARCHAR(45) NULL,
  `SALDO` VARCHAR(45) NULL,
  PRIMARY KEY (`MATRICULA_idPension`, `PAGO_MES_numeroComprobante`),
  INDEX `fk_MATRICULA_has_PAGO_MES_PAGO_MES1_idx` (`PAGO_MES_numeroComprobante` ASC) VISIBLE,
  INDEX `fk_MATRICULA_has_PAGO_MES_MATRICULA1_idx` (`MATRICULA_idPension` ASC) VISIBLE,
  CONSTRAINT `fk_MATRICULA_has_PAGO_MES_MATRICULA1`
    FOREIGN KEY (`MATRICULA_idPension`)
    REFERENCES `mydb`.`MATRICULA` (`idPension`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MATRICULA_has_PAGO_MES_PAGO_MES1`
    FOREIGN KEY (`PAGO_MES_numeroComprobante`)
    REFERENCES `mydb`.`PAGO_MES` (`numeroComprobante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_tipoDocumento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_tipoDocumento` (
  `des_tipoDocumento` VARCHAR(5) NOT NULL,
  `lugarExpedicion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`des_tipoDocumento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_observaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_observaciones` (
  `tipoObservacion` VARCHAR(15) NOT NULL,
  `des_observacion` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`tipoObservacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_persona` (
  `numeroDocumento` VARCHAR(12) NOT NULL,
  `nombre1` VARCHAR(30) NOT NULL,
  `nombre2` VARCHAR(30) NULL,
  `apellido1` VARCHAR(30) NOT NULL,
  `apellido2` VARCHAR(30) NULL,
  `lugarNacimiento` VARCHAR(45) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `tbl_tipoDocumento_des_tipoDocumento` VARCHAR(5) NOT NULL,
  `tbl_observaciones_tipoObservacion` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`numeroDocumento`, `tbl_tipoDocumento_des_tipoDocumento`),
  INDEX `fk_tbl_persona_tbl_tipoDocumento1_idx` (`tbl_tipoDocumento_des_tipoDocumento` ASC) VISIBLE,
  INDEX `fk_tbl_persona_tbl_observaciones1_idx` (`tbl_observaciones_tipoObservacion` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_persona_tbl_tipoDocumento1`
    FOREIGN KEY (`tbl_tipoDocumento_des_tipoDocumento`)
    REFERENCES `mydb`.`tbl_tipoDocumento` (`des_tipoDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_persona_tbl_observaciones1`
    FOREIGN KEY (`tbl_observaciones_tipoObservacion`)
    REFERENCES `mydb`.`tbl_observaciones` (`tipoObservacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_rh`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_rh` (
  `des_rh` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`des_rh`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_eps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_eps` (
  `des_eps` VARCHAR(30) NOT NULL,
  `estrato` INT NOT NULL,
  PRIMARY KEY (`des_eps`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_teléfono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_teléfono` (
  `clase` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`clase`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_pagoMes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_pagoMes` (
  `numeroComprobante` VARCHAR(30) NOT NULL,
  `formaPago` VARCHAR(15) NOT NULL,
  `fechaPago` DATE NOT NULL,
  `mesCancelado` VARCHAR(30) NOT NULL,
  `responsableColegio` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`numeroComprobante`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_matricula` (
  `id_matricula` INT NOT NULL AUTO_INCREMENT,
  `curso` INT NOT NULL,
  `fechaInicial` DATE NOT NULL,
  `fechaFinal` DATE NULL,
  `estado` TINYINT NOT NULL,
  `grado` VARCHAR(15) NULL,
  PRIMARY KEY (`id_matricula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_estudiante` (
  `tbl_matricula_id_matricula` INT NOT NULL,
  `tbl_persona_numeroDocumento` VARCHAR(12) NOT NULL,
  `tbl_persona_tbl_tipoDocumento_des_tipoDocumento` VARCHAR(5) NOT NULL,
  `tbl_eps_des_eps` VARCHAR(30) NOT NULL,
  `tbl_rh_des_rh` VARCHAR(50) NOT NULL,
  INDEX `fk_tbl_estudiante_tbl_matricula1_idx` (`tbl_matricula_id_matricula` ASC) VISIBLE,
  PRIMARY KEY (`tbl_persona_numeroDocumento`, `tbl_persona_tbl_tipoDocumento_des_tipoDocumento`),
  INDEX `fk_tbl_estudiante_tbl_eps1_idx` (`tbl_eps_des_eps` ASC) VISIBLE,
  INDEX `fk_tbl_estudiante_tbl_rh1_idx` (`tbl_rh_des_rh` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_estudiante_tbl_matricula1`
    FOREIGN KEY (`tbl_matricula_id_matricula`)
    REFERENCES `mydb`.`tbl_matricula` (`id_matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_estudiante_tbl_persona1`
    FOREIGN KEY (`tbl_persona_numeroDocumento` , `tbl_persona_tbl_tipoDocumento_des_tipoDocumento`)
    REFERENCES `mydb`.`tbl_persona` (`numeroDocumento` , `tbl_tipoDocumento_des_tipoDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_estudiante_tbl_eps1`
    FOREIGN KEY (`tbl_eps_des_eps`)
    REFERENCES `mydb`.`tbl_eps` (`des_eps`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_estudiante_tbl_rh1`
    FOREIGN KEY (`tbl_rh_des_rh`)
    REFERENCES `mydb`.`tbl_rh` (`des_rh`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_parentesco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_parentesco` (
  `des_parentesco` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`des_parentesco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_responsable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_responsable` (
  `ocupacion` VARCHAR(35) NOT NULL,
  `profesion` VARCHAR(35) NOT NULL,
  `tbl_persona_numeroDocumento` VARCHAR(12) NOT NULL,
  `tbl_persona_tbl_tipoDocumento_des_tipoDocumento` VARCHAR(5) NOT NULL,
  `tbl_parentesco_des_parentesco` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`tbl_persona_numeroDocumento`, `tbl_persona_tbl_tipoDocumento_des_tipoDocumento`),
  INDEX `fk_tbl_responsable_tbl_parentesco1_idx` (`tbl_parentesco_des_parentesco` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_responsable_tbl_persona1`
    FOREIGN KEY (`tbl_persona_numeroDocumento` , `tbl_persona_tbl_tipoDocumento_des_tipoDocumento`)
    REFERENCES `mydb`.`tbl_persona` (`numeroDocumento` , `tbl_tipoDocumento_des_tipoDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_responsable_tbl_parentesco1`
    FOREIGN KEY (`tbl_parentesco_des_parentesco`)
    REFERENCES `mydb`.`tbl_parentesco` (`des_parentesco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_matricula_has_tbl_pagoMes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_matricula_has_tbl_pagoMes` (
  `tbl_matricula_id_matricula` INT NOT NULL,
  `tbl_pagoMes_numeroComprobante` VARCHAR(30) NOT NULL,
  `mes` VARCHAR(15) NOT NULL,
  `valorCancelado` FLOAT NOT NULL,
  `saldo` FLOAT NOT NULL,
  PRIMARY KEY (`tbl_matricula_id_matricula`, `tbl_pagoMes_numeroComprobante`),
  INDEX `fk_tbl_matricula_has_tbl_pagoMes_tbl_pagoMes1_idx` (`tbl_pagoMes_numeroComprobante` ASC) VISIBLE,
  INDEX `fk_tbl_matricula_has_tbl_pagoMes_tbl_matricula1_idx` (`tbl_matricula_id_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_matricula_has_tbl_pagoMes_tbl_matricula1`
    FOREIGN KEY (`tbl_matricula_id_matricula`)
    REFERENCES `mydb`.`tbl_matricula` (`id_matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_matricula_has_tbl_pagoMes_tbl_pagoMes1`
    FOREIGN KEY (`tbl_pagoMes_numeroComprobante`)
    REFERENCES `mydb`.`tbl_pagoMes` (`numeroComprobante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tbl_persona_has_tbl_teléfono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tbl_persona_has_tbl_teléfono` (
  `tbl_persona_numeroDocumento` VARCHAR(12) NOT NULL,
  `tbl_persona_tbl_tipoDocumento_des_tipoDocumento` VARCHAR(5) NOT NULL,
  `tbl_teléfono_clase` VARCHAR(15) NOT NULL,
  `numero` INT(15) NOT NULL,
  PRIMARY KEY (`tbl_persona_numeroDocumento`, `tbl_persona_tbl_tipoDocumento_des_tipoDocumento`, `tbl_teléfono_clase`),
  INDEX `fk_tbl_persona_has_tbl_teléfono_tbl_teléfono1_idx` (`tbl_teléfono_clase` ASC) VISIBLE,
  INDEX `fk_tbl_persona_has_tbl_teléfono_tbl_persona1_idx` (`tbl_persona_numeroDocumento` ASC, `tbl_persona_tbl_tipoDocumento_des_tipoDocumento` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_persona_has_tbl_teléfono_tbl_persona1`
    FOREIGN KEY (`tbl_persona_numeroDocumento` , `tbl_persona_tbl_tipoDocumento_des_tipoDocumento`)
    REFERENCES `mydb`.`tbl_persona` (`numeroDocumento` , `tbl_tipoDocumento_des_tipoDocumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_persona_has_tbl_teléfono_tbl_teléfono1`
    FOREIGN KEY (`tbl_teléfono_clase`)
    REFERENCES `mydb`.`tbl_teléfono` (`clase`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
