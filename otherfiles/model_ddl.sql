-- ============================================
-- Admin table
-- ============================================
CREATE TABLE admins (
    id INTEGER PRIMARY KEY,
    nome VARCHAR NOT NULL,
    cpf VARCHAR NOT NULL UNIQUE,
    email VARCHAR NOT NULL UNIQUE,
    telefone VARCHAR NOT NULL,
    hashed_password VARCHAR NOT NULL
);

CREATE INDEX ix_admins_nome ON admins (nome);
CREATE INDEX ix_admins_cpf ON admins (cpf);
CREATE INDEX ix_admins_email ON admins (email);
CREATE INDEX ix_admins_telefone ON admins (telefone);

-- ============================================
-- Empresa table
-- ============================================
CREATE TABLE empresas (
    id INTEGER PRIMARY KEY,
    nome VARCHAR NOT NULL,
    descricao VARCHAR NOT NULL,
    cidade VARCHAR NOT NULL,
    cep VARCHAR NOT NULL,
    no_empregados INTEGER NOT NULL,
    anos_func INTEGER NOT NULL,
    admin_id INTEGER NOT NULL,
    FOREIGN KEY(admin_id) REFERENCES admins(id)
);

CREATE INDEX ix_empresas_nome ON empresas (nome);
CREATE INDEX ix_empresas_descricao ON empresas (descricao);
CREATE INDEX ix_empresas_cidade ON empresas (cidade);
CREATE INDEX ix_empresas_cep ON empresas (cep);

-- ============================================
-- Competencia table
-- ============================================
CREATE TABLE competencias (
    id INTEGER PRIMARY KEY,
    nome VARCHAR NOT NULL UNIQUE
);

CREATE INDEX ix_competencias_id ON competencias (id);

-- ============================================
-- User table
-- ============================================
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    nome VARCHAR NOT NULL,
    cpf VARCHAR NOT NULL UNIQUE,
    email VARCHAR NOT NULL UNIQUE,
    telefone VARCHAR NOT NULL,
    hashed_password VARCHAR NOT NULL,
    area_trabalho VARCHAR NOT NULL,
    nivel_educacao VARCHAR NOT NULL
);

CREATE INDEX ix_users_nome ON users (nome);
CREATE INDEX ix_users_cpf ON users (cpf);
CREATE INDEX ix_users_email ON users (email);
CREATE INDEX ix_users_telefone ON users (telefone);
CREATE INDEX ix_users_area_trabalho ON users (area_trabalho);
CREATE INDEX ix_users_nivel_educacao ON users (nivel_educacao);

-- ============================================
-- VagaEmprego table
-- ============================================
CREATE TABLE vaga_emprego (
    id INTEGER PRIMARY KEY,
    titulo VARCHAR NOT NULL,
    descricao VARCHAR NOT NULL,
    modalidade VARCHAR NOT NULL,
    salario FLOAT NOT NULL,
    no_vagas INTEGER NOT NULL,
    empresa_id INTEGER NOT NULL,
    FOREIGN KEY(empresa_id) REFERENCES empresas(id)
);

CREATE INDEX ix_vaga_emprego_titulo ON vaga_emprego (titulo);
CREATE INDEX ix_vaga_emprego_modalidade ON vaga_emprego (modalidade);

-- ============================================
-- Experiencia table
-- ============================================
CREATE TABLE experiencias (
    id INTEGER PRIMARY KEY,
    empresa VARCHAR NOT NULL,
    cargo VARCHAR NOT NULL,
    anos INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE INDEX ix_experiencias_empresa ON experiencias (empresa);
CREATE INDEX ix_experiencias_cargo ON experiencias (cargo);

-- ============================================
-- Association Tables (Many-to-Many)
-- ============================================

-- user_competencia
CREATE TABLE user_competencia (
    user_id INTEGER,
    competencia_id INTEGER,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(competencia_id) REFERENCES competencias(id)
);

-- vaga_competencia
CREATE TABLE vaga_competencia (
    vaga_id INTEGER,
    competencia_id INTEGER,
    FOREIGN KEY(vaga_id) REFERENCES vaga_emprego(id),
    FOREIGN KEY(competencia_id) REFERENCES competencias(id)
);

-- user_vaga_association
CREATE TABLE user_vaga_association (
    user_id INTEGER,
    vaga_id INTEGER,
    PRIMARY KEY (user_id, vaga_id),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(vaga_id) REFERENCES vaga_emprego(id)
);
