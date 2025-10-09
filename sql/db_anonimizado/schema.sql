-- Criando tabela empresa anonimizada
CREATE TABLE empresa_anonimizada
(
    -- Informações de empresa anonimizada
    id     INT PRIMARY KEY,
    nome   VARCHAR(60),
    email  VARCHAR(60) UNIQUE,
    cnpj   CHAR(14) UNIQUE,

    -- Informações de endereço de empresa anonimizada
    uf     VARCHAR(2),
    cidade VARCHAR(60),
    cep    CHAR(8),
    bairro VARCHAR(60),
    rua    VARCHAR(60),
    numero VARCHAR(5)
);

-- Criando tabela telefone de empresa anonimizado
CREATE TABLE telefone_anonimizado_empresa
(
    -- Informações de telefone de empresa anonimizado
    id          INT PRIMARY KEY,
    telefone   CHAR(15) UNIQUE,
    cod_empresa INT REFERENCES empresa_anonimizada (id)
);

-- Criando tabela empregado anonimizado
CREATE TABLE empregado_anonimizado
(
    -- Informações de empregado anonimizado
    id                 INT PRIMARY KEY,
    nome               VARCHAR(60),
    sobrenome          VARCHAR(70),
    cpf                CHAR(11) UNIQUE,
    email              VARCHAR(60) UNIQUE,
    senha              CHAR(64),
    telefone_empregado CHAR(15) UNIQUE,
    cargo              VARCHAR(50),
    tipo               VARCHAR(10),

    -- Informações de endereço de empregado anonimizado
    uf                 VARCHAR(2),
    cidade             VARCHAR(60),
    bairro             VARCHAR(60),
    cep                CHAR(8),
    rua                VARCHAR(60),
    numero             VARCHAR(5),
    cod_empresa        INT REFERENCES empresa_anonimizada (id)
);