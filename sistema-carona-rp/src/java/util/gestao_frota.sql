SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `frota` ;
CREATE SCHEMA IF NOT EXISTS `frota` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `frota` ;

-- -----------------------------------------------------
-- Table `frota`.`tipo_veiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frota`.`tipo_veiculo` ;

CREATE  TABLE IF NOT EXISTS `frota`.`tipo_veiculo` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(20) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frota`.`veiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frota`.`veiculo` ;

CREATE  TABLE IF NOT EXISTS `frota`.`veiculo` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `placa` CHAR(7) NULL ,
  `renavam` MEDIUMTEXT NULL ,
  `cor` VARCHAR(20) NULL ,
  `modelo` VARCHAR(20) NULL ,
  `marca` VARCHAR(20) NULL ,
  `ano` INT NULL ,
  `capacidade_passageiros` INT NULL ,
  `capacidade_carga` INT NULL ,
  `tipo_veiculo` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Veiculo_TipoVeiculo2_idx` (`tipo_veiculo` ASC) ,
  CONSTRAINT `fk_Veiculo_TipoVeiculo2`
    FOREIGN KEY (`tipo_veiculo` )
    REFERENCES `frota`.`tipo_veiculo` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frota`.`opcional_veiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frota`.`opcional_veiculo` ;

CREATE  TABLE IF NOT EXISTS `frota`.`opcional_veiculo` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frota`.`tipo_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frota`.`tipo_usuario` ;

CREATE  TABLE IF NOT EXISTS `frota`.`tipo_usuario` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frota`.`estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frota`.`estado` ;

CREATE  TABLE IF NOT EXISTS `frota`.`estado` (
  `id` INT NOT NULL ,
  `nome` VARCHAR(255) NULL ,
  `sigla` CHAR(2) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frota`.`cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frota`.`cidade` ;

CREATE  TABLE IF NOT EXISTS `frota`.`cidade` (
  `id` INT NOT NULL ,
  `nome` VARCHAR(255) NULL ,
  `estado` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cidade_estado1_idx` (`estado` ASC) ,
  CONSTRAINT `fk_cidade_estado1`
    FOREIGN KEY (`estado` )
    REFERENCES `frota`.`estado` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frota`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frota`.`usuario` ;

CREATE  TABLE IF NOT EXISTS `frota`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(255) NOT NULL ,
  `login` VARCHAR(255) NOT NULL ,
  `senha` VARCHAR(255) NOT NULL ,
  `tipo_usuario` INT NOT NULL ,
  `email` VARCHAR(255) NOT NULL ,
  `telefone` VARCHAR(11) NULL ,
  `celular` VARCHAR(11) NULL ,
  `rg` VARCHAR(20) NOT NULL ,
  `siape` INT NULL ,
  `numero_cnh` BIGINT NULL ,
  `validade_cnh` DATE NULL ,
  `categoria_cnh` VARCHAR(3) NULL ,
  `rua` VARCHAR(255) NULL ,
  `numero` INT NULL ,
  `complemento` VARCHAR(255) NULL ,
  `cep` VARCHAR(8) NULL ,
  `cidade` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Usuario_TipoUsuario1_idx` (`tipo_usuario` ASC) ,
  INDEX `fk_Usuario_cidade1_idx` (`cidade` ASC) ,
  CONSTRAINT `fk_Usuario_TipoUsuario1`
    FOREIGN KEY (`tipo_usuario` )
    REFERENCES `frota`.`tipo_usuario` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Usuario_cidade1`
    FOREIGN KEY (`cidade` )
    REFERENCES `frota`.`cidade` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frota`.`veiculo_opcional_veiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frota`.`veiculo_opcional_veiculo` ;

CREATE  TABLE IF NOT EXISTS `frota`.`veiculo_opcional_veiculo` (
  `veiculo` INT NOT NULL ,
  `opcional_veiculo` INT NOT NULL ,
  PRIMARY KEY (`veiculo`, `opcional_veiculo`) ,
  INDEX `fk_Veiculo_OpcionaisVeiculo_OpcionaisVeiculo1_idx` (`opcional_veiculo` ASC) ,
  INDEX `fk_Veiculo_OpcionaisVeiculo_Veiculo1_idx` (`veiculo` ASC) ,
  CONSTRAINT `fk_Veiculo_OpcionalVeiculo_Veiculo1`
    FOREIGN KEY (`veiculo` )
    REFERENCES `frota`.`veiculo` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Veiculo_OpcionalVeiculo_OpcionaisVeiculo1`
    FOREIGN KEY (`opcional_veiculo` )
    REFERENCES `frota`.`opcional_veiculo` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frota`.`situacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frota`.`situacao` ;

CREATE  TABLE IF NOT EXISTS `frota`.`situacao` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frota`.`viagem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frota`.`viagem` ;

CREATE  TABLE IF NOT EXISTS `frota`.`viagem` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `veiculo` INT NOT NULL ,
  `motorista` INT NOT NULL ,
  `cidade_origem` INT NOT NULL ,
  `data_saida` DATETIME NULL ,
  `local_saida` VARCHAR(255) NULL ,
  `cidade_retorno` INT NOT NULL ,
  `data_retorno` DATETIME NULL ,
  `local_retorno` VARCHAR(255) NULL ,
  `percurso` VARCHAR(255) NULL ,
  `observacoes` TEXT NULL ,
  `justificativa_rejeite` TEXT NULL ,
  `situacao_viagem` INT NOT NULL ,
  `data_inicio_real` DATETIME NULL ,
  `kilometragem_inicio` INT NULL ,
  `data_fim_real` DATETIME NULL ,
  `kilometragem_fim` INT NULL ,
  `observacoes_percurso` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_viagem_veiculo1_idx` (`veiculo` ASC) ,
  INDEX `fk_viagem_usuario1_idx` (`motorista` ASC) ,
  INDEX `fk_viagem_cidade1_idx` (`cidade_origem` ASC) ,
  INDEX `fk_viagem_cidade2_idx` (`cidade_retorno` ASC) ,
  INDEX `fk_viagem_situacao_solicitacao1_idx` (`situacao_viagem` ASC) ,
  CONSTRAINT `fk_viagem_veiculo1`
    FOREIGN KEY (`veiculo` )
    REFERENCES `frota`.`veiculo` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_viagem_usuario1`
    FOREIGN KEY (`motorista` )
    REFERENCES `frota`.`usuario` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_viagem_cidade1`
    FOREIGN KEY (`cidade_origem` )
    REFERENCES `frota`.`cidade` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_viagem_cidade2`
    FOREIGN KEY (`cidade_retorno` )
    REFERENCES `frota`.`cidade` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_viagem_situacao_solicitacao1`
    FOREIGN KEY (`situacao_viagem` )
    REFERENCES `frota`.`situacao` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frota`.`solicitacao_viagem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frota`.`solicitacao_viagem` ;

CREATE  TABLE IF NOT EXISTS `frota`.`solicitacao_viagem` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `solicitante` INT NOT NULL ,
  `data_saida` DATETIME NULL ,
  `local_saida` VARCHAR(255) NULL ,
  `data_retorno` DATETIME NULL ,
  `local_retorno` VARCHAR(255) NULL ,
  `justificativa` TEXT NULL ,
  `observacoes` TEXT NULL ,
  `origem` INT NOT NULL ,
  `destino` INT NOT NULL ,
  `percurso` TEXT NULL ,
  `situacao_solicitacao` INT NOT NULL ,
  `viagem` INT NULL ,
  `eh_passageiro` TINYINT(1) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_viagem_cidade1_idx` (`origem` ASC) ,
  INDEX `fk_viagem_cidade_retorno_idx` (`destino` ASC) ,
  INDEX `fk_solicitacao_viagem_usuario1_idx` (`solicitante` ASC) ,
  INDEX `fk_solicitacao_viagem_situacao_solicitacao1_idx` (`situacao_solicitacao` ASC) ,
  INDEX `fk_solicitacao_viagem_viagem1_idx` (`viagem` ASC) ,
  CONSTRAINT `fk_viagem_cidade_origem`
    FOREIGN KEY (`origem` )
    REFERENCES `frota`.`cidade` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_viagem_cidade_destino`
    FOREIGN KEY (`destino` )
    REFERENCES `frota`.`cidade` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_solicitacao_viagem_usuario1`
    FOREIGN KEY (`solicitante` )
    REFERENCES `frota`.`usuario` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_solicitacao_viagem_situacao_solicitacao1`
    FOREIGN KEY (`situacao_solicitacao` )
    REFERENCES `frota`.`situacao` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_solicitacao_viagem_viagem1`
    FOREIGN KEY (`viagem` )
    REFERENCES `frota`.`viagem` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frota`.`passageiro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frota`.`passageiro` ;

CREATE  TABLE IF NOT EXISTS `frota`.`passageiro` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(255) NOT NULL ,
  `rg` VARCHAR(255) NOT NULL ,
  `email` VARCHAR(255) NOT NULL ,
  `endereco` VARCHAR(255) NOT NULL ,
  `eh_servidor` TINYINT(1) NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `rg_UNIQUE` (`rg` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `frota`.`solicitacao_viagem_passageiro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `frota`.`solicitacao_viagem_passageiro` ;

CREATE  TABLE IF NOT EXISTS `frota`.`solicitacao_viagem_passageiro` (
  `solicitacao_viagem` INT NOT NULL ,
  `passageiro` INT NOT NULL ,
  PRIMARY KEY (`solicitacao_viagem`, `passageiro`) ,
  INDEX `fk_solicitacao_viagem_passageiro_passageiro1_idx` (`passageiro` ASC) ,
  INDEX `fk_solicitacao_viagem_passageiro_solicitacao_viagem1_idx` (`solicitacao_viagem` ASC) ,
  CONSTRAINT `fk_solicitacao_viagem_passageiro_solicitacao_viagem1`
    FOREIGN KEY (`solicitacao_viagem` )
    REFERENCES `frota`.`solicitacao_viagem` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_solicitacao_viagem_passageiro_passageiro1`
    FOREIGN KEY (`passageiro` )
    REFERENCES `frota`.`passageiro` (`id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `frota` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
