
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS AlwaysTogether DEFAULT CHARACTER SET utf8 ;
USE AlwaysTogether ;


CREATE TABLE IF NOT EXISTS Usuario (
  idUsuario INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(100) NULL,
  senha VARCHAR(255) NULL,
  PRIMARY KEY (idUsuario))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table UF
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS UF (
  idUF INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NULL,
  sigla VARCHAR(2) NULL,
  PRIMARY KEY (idUF))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Cidade
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cidade (
  idCidade INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NULL,
  UF_idUF INT NOT NULL,
  PRIMARY KEY (idCidade),
  INDEX fk_Cidade_UF1_idx (UF_idUF ASC),
  CONSTRAINT fk_Cidade_UF1
    FOREIGN KEY (UF_idUF)
    REFERENCES UF (idUF)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Endereco
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Endereco (
  idEndereco INT NOT NULL AUTO_INCREMENT,
  bairro VARCHAR(100) NULL,
  rua VARCHAR(250) NULL,
  numero INT NULL,
  complemento VARCHAR(100) NULL,
  Cidade_idCidade INT NOT NULL,
  PRIMARY KEY (idEndereco),
  INDEX fk_Endereco_Cidade1_idx (Cidade_idCidade ASC),
  CONSTRAINT fk_Endereco_Cidade1
    FOREIGN KEY (Cidade_idCidade)
    REFERENCES Cidade (idCidade)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Funcionario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Funcionario (
  idFuncionario INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NULL,
  cargo VARCHAR(50) NULL,
  cpf VARCHAR(11) NULL,
  dataNascimento DATE NULL,
  Usuario_idUsuario INT NOT NULL,
  Endereco_idEndereco INT NOT NULL,
  PRIMARY KEY (idFuncionario),
  INDEX fk_Funcionario_Usuario1_idx (Usuario_idUsuario ASC),
  INDEX fk_Funcionario_Endereco1_idx (Endereco_idEndereco ASC),
  CONSTRAINT fk_Funcionario_Usuario1
    FOREIGN KEY (Usuario_idUsuario)
    REFERENCES Usuario (idUsuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Funcionario_Endereco1
    FOREIGN KEY (Endereco_idEndereco)
    REFERENCES Endereco (idEndereco)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Casamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Casamento (
  idCasamento INT NOT NULL,
  status VARCHAR(30) NULL,
  data DATE NULL,
  hora TIMESTAMP NULL,
  qtdConvidados INT NULL,
  nomePadre VARCHAR(100) NULL,
  igreja VARCHAR(100) NULL,
  localLuaMel VARCHAR(100) NULL,
  PRIMARY KEY (idCasamento))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Padrinhos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Padrinhos (
  idPadrinhos INT NOT NULL AUTO_INCREMENT,
  Conjuges VARCHAR(200) NULL,
  email VARCHAR(100) NULL,
  Casamento_idCasamento INT NOT NULL,
  PRIMARY KEY (idPadrinhos),
  INDEX fk_Padrinhos_Casamento1_idx (Casamento_idCasamento ASC),
  CONSTRAINT fk_Padrinhos_Casamento1
    FOREIGN KEY (Casamento_idCasamento)
    REFERENCES Casamento (idCasamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Orcamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Orcamento (
  idOrcamento INT NOT NULL AUTO_INCREMENT,
  dataOrcado DATE NULL,
  Funcionario_idFuncionario INT NOT NULL,
  Casamento_idCasamento INT NOT NULL,
  PRIMARY KEY (idOrcamento),
  INDEX fk_Orcamento_Funcionario1_idx (Funcionario_idFuncionario ASC),
  INDEX fk_Orcamento_Casamento1_idx (Casamento_idCasamento ASC),
  CONSTRAINT fk_Orcamento_Funcionario1
    FOREIGN KEY (Funcionario_idFuncionario)
    REFERENCES Funcionario (idFuncionario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Orcamento_Casamento1
    FOREIGN KEY (Casamento_idCasamento)
    REFERENCES Casamento (idCasamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Propostas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Propostas (
  idPropostas INT NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(250) NULL,
  preco FLOAT NULL,
  tipo VARCHAR(10) NULL,
  Orcamento_idOrcamento INT NOT NULL,
  PRIMARY KEY (idPropostas),
  INDEX fk_Propostas_Orcamento1_idx (Orcamento_idOrcamento ASC),
  CONSTRAINT fk_Propostas_Orcamento1
    FOREIGN KEY (Orcamento_idOrcamento)
    REFERENCES Orcamento (idOrcamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Conjuge
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Conjuge (
  idConjuge INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(100) NULL,
  DataNascimento DATE NULL,
  Casamento_idCasamento INT NOT NULL,
  PRIMARY KEY (idConjuge),
  INDEX fk_Conjuge_Casamento1_idx (Casamento_idCasamento ASC),
  CONSTRAINT fk_Conjuge_Casamento1
    FOREIGN KEY (Casamento_idCasamento)
    REFERENCES Casamento (idCasamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


