-- Criando tabela empresa anonimizada
CREATE TABLE empresa_anonimizada
(
    -- Informações de empresa anonimizada
    id     INT PRIMARY KEY,
    nome   VARCHAR(13),
    email  CHAR(64) UNIQUE,
    cnpj   VARCHAR(11),

    -- Informações de endereço de empresa anonimizada
    regiao     VARCHAR(20),
    cidade VARCHAR(3),
    cep    VARCHAR(3),
    bairro VARCHAR(3),
    rua    VARCHAR(7),
    numero INT,
    plano  VARCHAR(60)
);

-- Criando tabela telefone de empresa anonimizado
CREATE TABLE telefone_anonimizado_empresa
(
    -- Informações de telefone de empresa anonimizado
    id       INT PRIMARY KEY,
    telefone VARCHAR(4),
    empresa  VARCHAR(13)
);

-- Criando tabela empregado anonimizado
CREATE TABLE empregado_anonimizado
(
    -- Informações de empregado anonimizado
    id                 INT PRIMARY KEY,
    nome               VARCHAR(15),
    cpf                CHAR(64) UNIQUE,
    email              CHAR(64) UNIQUE,
    senha              CHAR(64),
    telefone_empregado VARCHAR(4),
    cargo              VARCHAR(50),
    tipo               VARCHAR(10),

    -- Informações de endereço de empregado anonimizado
    regiao                 VARCHAR(20),
    cidade             VARCHAR(3),
    bairro             VARCHAR(3),
    cep                VARCHAR(3),
    rua                VARCHAR(7),
    numero             INT,
    empresa            VARCHAR(12)
);