drop schema public CASCADE;
create schema public;

-- Criando tabela administrador
CREATE TABLE administrador
(
    -- Informações de administrador
    id    SERIAL PRIMARY KEY,
    email VARCHAR(60) UNIQUE NOT NULL,
    senha CHAR(64) NOT NULL
);

-- Criando tabela plano
CREATE TABLE plano
(
    -- Informações de plano
    id        SERIAL PRIMARY KEY,
    nome      VARCHAR(60) NOT NULL,
    preco     MONEY NOT NULL CHECK (preco > 0::MONEY),
    descricao TEXT
);

-- Criando tabela empresa
CREATE TABLE empresa
(
    -- Informações de empresa
    id        SERIAL PRIMARY KEY,
    nome      VARCHAR(60) NOT NULL,
    email     VARCHAR(60) UNIQUE NOT NULL,
    cnpj      CHAR(18) NOT NULL CHECK (cnpj ~'^[0-9]{2}\.[0-9]{3}\.[0-9]{3}\/[0-9]{4}\-[0-9]{2}$'),

    --     Informações do endereço de empresa
    uf        VARCHAR(2) NOT NULL,
    cidade    VARCHAR(60) NOT NULL,
    bairro    VARCHAR(60) NOT NULL,
    cep       CHAR(9),
    rua       VARCHAR(60),
    numero    INT CHECK (numero > 0),
    cod_plano INT REFERENCES plano(id)
);

-- Criando tabela telefone de empresa
CREATE TABLE telefone_empresa
(
    -- Informações de telefone de empresa
    id          SERIAL PRIMARY KEY,
    telefone    CHAR(20) NOT NULL UNIQUE,
    cod_empresa INT REFERENCES empresa(id)
);

-- Criando tabela de empregado
CREATE TABLE empregado
(
    -- Informações de empregado
    id                 SERIAL PRIMARY KEY,
    nome               VARCHAR(70) NOT NULL,
    sobrenome          VARCHAR(60),
    cpf                CHAR(14) NOT NULL UNIQUE CHECK (cpf ~'^[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}$'),
    email              VARCHAR(60) UNIQUE NOT NULL,
    senha              CHAR(64) NOT NULL,
    telefone_empregado CHAR(20) NOT NULL UNIQUE,
    cargo              VARCHAR(50) NOT NULL,
    tipo               VARCHAR(10) CHECK (tipo IN ('OPERARIO', 'GESTOR')),

    --     Informações de endereço do empregado
    uf                 VARCHAR(2) NOT NULL CHECK (uf ~'^[A-Z]{2}$'),
    cidade             VARCHAR(60) NOT NULL,
    bairro             VARCHAR(60) NOT NULL,
    cep                CHAR(9),
    rua                VARCHAR(60),
    numero             INT CHECK (numero > 0),
    cod_empresa        INT REFERENCES empresa(id)
);

-- Criando tabela de setor turno
CREATE TABLE setor_turno
(
    -- Informações de setor turno
    id          SERIAL PRIMARY KEY,
    nome        VARCHAR(60) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim    TIME NOT NULL CHECK (hora_inicio < hora_fim)
);

-- Criando tabela de motivo
CREATE TABLE motivo
(
    -- Informações de motivo
    id        SERIAL PRIMARY KEY,
    nome      VARCHAR(60) NOT NULL,
    descricao TEXT
);

-- Criando tabela de embalagem
CREATE TABLE embalagem
(
    -- Informações de embalagem
    id         SERIAL PRIMARY KEY,
    nome       VARCHAR(60) NOT NULL,
    tipo       VARCHAR(50) NOT NULL,
    valor_kg   MONEY CHECK (valor_kg >= 0::MONEY) DEFAULT 0,
    fornecedor VARCHAR(60)
);

-- Criando tabela de midia
CREATE TABLE midia
(
    -- Informações de midia
    id              SERIAL PRIMARY KEY,
    caminho_arquivo TEXT,
    arquivo         BYTEA,
    horario         TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Criando tabela de descarte
CREATE TABLE descarte
(
    -- Informações de descarte
    id             SERIAL PRIMARY KEY,
    descarte_kg    NUMERIC(10,2) NOT NULL CHECK (descarte_kg >= 0),
    custo_estimado MONEY CHECK (custo_estimado >= 0::MONEY),
    horario        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    observacao     TEXT,
    cod_embalagem  INT REFERENCES embalagem(id),
    cod_motivo     INT REFERENCES motivo(id),
    cod_empregado  INT REFERENCES empregado(id),
    cod_midia      INT REFERENCES midia(id)
);

-- Criando tabela de armazena
CREATE TABLE armazena
(
    -- Informações de armazena
    cod_embalagem   INT REFERENCES embalagem(id),
    cod_setor_turno INT REFERENCES setor_turno(id)
);

-- Criando tabela de trabalha em
CREATE TABLE trabalha_em
(
    -- Informações de trabalha em
    cod_setor_turno INT REFERENCES setor_turno(id),
    cod_empregado   INT REFERENCES empregado(id)
);