#Esquema de banco a ser utilzado na aulas do Laboratório de Banco de Dados
#RENATO ARAUJO DA SILVA
#UNEMAT - UNIVERSIDADE DO ESTADO DO MATO GROSSO
#https://github.com/coldrenatinho/
#@coldrenatinho



/*

#TESTE

CREATE DATABASE IF NOT EXISTS Atividade01;

USE Atividade01;

CREATE TABLE IF NOT EXISTS Cliente(

    CodCliente INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Nome Varchar(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS MunicipioCliente(
    CodMunicipio INT PRIMARY KEY NOT NULL,
    CodCliente  INT
);
#Pedimos a alteração da tabela que vamos realizar crial a constraint <ALTER TABLE> {NOME TABELA} <ADD CONSTRAINT foreing key > {NOME DA CONTRAINT} ({Nome da tupla a ser referenciada}) <REFERENCES> {Nome da table de referencia "Primary key "};
 ALTER TABLE MunicipioCliente ADD constraint foreign key FK_Cliente_CodCliente (CodCliente) references Cliente (CodCliente);
 
 */
 
 
 #-----------------------------------------------------------------------------------------
 #Atividade 02

 CREATE DATABASE IF NOT EXISTS Atividade02;

 USE Atividade02;

CREATE TABLE IF NOT EXISTS Paciente(
    CodPaciente INT PRIMARY KEY AUTO_INCREMENT,
    Nome Char(200),
    RG INT NOT NULL UNIQUE,
    CPF INT NOT NULL UNIQUE,
    Sexo CHAR(1) NOT NULL,
    DataNascimento DATE,
    Logradouro char(200) NOT NULL,
    NumeroLogradouro int NOT NULL,
    CEP INT NOT NULL,
    Bairro CHAR(200) NOT NULL,
    Celular int(14) NOT NULL,
    NomeConvernio CHAR(200) NOT NULL,
    CodMatriculConvenio int NOT NULL
);

CREATE TABLE IF NOT EXISTS Medico(
    CodMedico int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Nome CHAR(200) NOT NULL,
    CRM INT NOT NULL UNIQUE,
    Especialidade char(200) NOT NULL,
    CodHorario int,
    Celular int(14) NOT NULL,
    CelularRecado int(14),
    Logradouro char(200) NOT NULL,
    NumeroLogradouro int NOT NULL,
    CEP INT NOT NULL,
    Bairro CHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS HorarioMedico(
    CodHorario INT PRIMARY KEY NOT NULL, #GeraLista de Horarios 
    CodMedico INT NOT NULL UNIQUE, #VICULA O HORÁRIO AO MÉDICO
    DataInicio DATETIME NOT NULL, #PERIODO DE VIGENCIA DO HORÁRIO POR EXEPLE DE 01/01/2023 ATÉ O FIM DO CONTRATO 02/03/2023
    DataFim DATETIME NOT NULL,
    DiaSemanaInicio int NOT NULL, #dia da semana iniciando pelo domingo(1)
    DiaSemanaFim int NOT NULL,
    HoraEtranda TIME NOT NULL, #Horario de atendimento Vinculado ao dia Da Semana
    DataSaida TIME NOT NULL
);

ALTER TABLE HorarioMedico ADD constraint foreign key FK_Medico_CodMedico (CodMedico) REFERENCES Medico (CodMedico);

CREATE TABLE IF NOT EXISTS Consulta(
    CodConsulta INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    CodPaciente INT NOT NULL,
    CodMedico INT NOT NULL,
    DiaConsulta DATETIME,
    StatusConsulta CHAR(200) # Atendido/Cancelada/Aberta
);

ALTER TABLE Consulta ADD constraint foreign key FK_Medico_CodMedico (CodMedico) REFERENCES Medico (CodMedico);
ALTER TABLE Consulta ADD constraint foreign key FK_Pacinte_CodPacinte (CodPaciente) REFERENCES Paciente (CodPaciente);
#-----------------------------------------------------------------------------------------
#Gerando um insert nas Tabelas Criadas acima
#-----------------------------------------------------------------------------------------
INSERT INTO Paciente (Nome, RG, CPF, Sexo, DataNascimento, Logradouro, NumeroLogradouro, CEP, Bairro, Celular, NomeConvernio, CodMatriculConvenio)
VALUES
    ('Maria Silva', 12345678, 98765432, 'F', '1990-05-15', 'Rua A', 123, 12345678, 'Centro', 987654321, 'ConvenioSaude', 456),
    ('João Santos', 87654321, 54321678, 'M', '1985-10-20', 'Av. B', 456, 87654321, 'Bairro1', 987654321, 'ConvenioMed', 789),
    ('Ana Oliveira', 23456789, 87654321, 'F', '1988-02-28', 'Rua B', 456, 23456789, 'Bairro2', 876543210, 'PlanoVida', 123),
    ('Pedro Almeida', 34567890, 76543210, 'M', '1995-11-10', 'Av. C', 789, 34567890, 'Centro', 765432109, 'ConvenioSaude', 234);

INSERT INTO Medico (Nome, CRM, Especialidade, CodHorario, Celular, CelularRecado, Logradouro, NumeroLogradouro, CEP, Bairro)
VALUES
    ('Dr. Ana Souza', 123456, 'Cardiologia', 1, 987654321, 987654322, 'Rua X', 789, 98765432, 'Centro'),
    ('Dr. Carlos Santos', 987654, 'Dermatologia', 2, 987654321, 987654322, 'Av. Y', 654, 87654321, 'Bairro2'),
    ('Dra. Luiza Rodrigues', 567890, 'Pediatria', 3, 876543210, 876543211, 'Rua Y', 987, 56789012, 'Bairro3'),
    ('Dr. Marcelo Lima', 678901, 'Ortopedia', 4, 765432109, 765432210, 'Av. Z', 123, 45678901, 'Centro');

INSERT INTO HorarioMedico (CodHorario, CodMedico, DataInicio, DataFim, DiaSemanaInicio, DiaSemanaFim, HoraEtranda, DataSaida)
VALUES
    (1, 1, '2023-09-01', '2023-12-31', 1, 5, '08:00:00', '17:00:00'),
    (2, 2, '2023-09-01', '2023-12-31', 1, 5, '09:00:00', '18:00:00'),
    (3, 3, '2023-09-01', '2023-12-31', 1, 3, '10:00:00', '15:00:00'),
    (4, 4, '2023-09-01', '2023-12-31', 3, 5, '12:00:00', '20:00:00');

INSERT INTO Consulta (CodPaciente, CodMedico, DiaConsulta, StatusConsulta)
VALUES
    (1, 1, '2023-09-10 10:00:00', 'Atendido'),
    (2, 2, '2023-09-12 14:30:00', 'Aberta'),
    (1, 3, '2023-09-15 11:30:00', 'Atendido'),
    (3, 4, '2023-09-18 14:00:00', 'Aberta');

#-----------------------FIM DO INSERT----------------------- 
system cls #Limpa a tela
\! echo 'Ficha de atendimentos'; #Faz o print NO TERMINAL


#-----------------------INSERINDO VIEW-----------------------

CREATE OR REPLACE VIEW ConsultaAgendada AS
    SELECT c.CodConsulta, m.Nome AS 'Nome Medico', m.Especialidade as 'Especialide', p.Nome AS 'Nome Pacinte', c.DiaConsulta as 'Data Consulta', c.StatusConsulta as 'Status da Consulta'
    FROM Consulta C
    INNER JOIN Medico m on
    m.CodMedico = c.CodMedico
    INNER JOIN Paciente p on 
    p.CodPaciente = c.CodPaciente;

#-----------------------INSERINDO VIEW-----------------------



#-----------------------Retorno da View-----------------------
SELECT *
FROM ConsultaAgendada;
#-----------------------Retorno da View-----------------------
#-----------------------FIM DA ATIVIDADE-----------------------


#-----------------------INICIO ATIVIDADE 03-----------------------

#----------------------------------------------
#Atividade03
#----------------------------------------------
#----------------------------------------------
#Novo Banco Atividade03
#----------------------------------------------
CREATE DATABASE IF NOT EXISTS Atividade03;

USE Atividade03;

#----------------------------------------------
#Tabela Instrutor
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Instrutor(
    CodInstrutor INT PRIMARY KEY NOT NULL AUTO_INCREMENT;
    RG int(9) NOT NULL UNIQUE,
    Nome CHAR(200) NOT NULL,
    DataNascimento DATE,
    Titulacao INT
);

#----------------------------------------------
#Tabela TelefoneInstrutor
#----------------------------------------------
CREATE TABLE IF NOT EXISTS TelefoneInstrutor(
    Codtelefone INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Numero int(9) NOT NULL,
    Tipo VARCHAR(45),
    CodInstrutor INT NOT NULL
);

#----------------------------------------------
#Adição Chave Estrageira Verificando o ID do Instrutor
#----------------------------------------------
ALTER TABLE TelefoneInstrutor ADD CONSTRAINT FOREIGN KEY FK_Instrutor_CodInstrutor (CodInstrutor) REFERENCES Instrutor (CodInstrutor);

#----------------------------------------------
#Tabela Aluno
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Aluno(
    CodAluno INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    CodTurma int NOT NULL,
    DataMatricula DATE NOT NULL,
    Nome VARCHAR(200) NOT NULL,
    Logradouro VARCHAR(200) NOT NULL,
    NumeroLogradouro int(5),
    Bairro VARCHAR(200) NOT NULL,
    CEP INT,
    Telefone INT,
    TelefoneRecado int,
    DataNascimento DATE NOT NULL,
    Altura FLOAT NOT NULL,
    Peso FLOAT NOT NULL
);

#----------------------------------------------
#Tabela Atividade
#----------------------------------------------
CREATE IF NOT EXISTS Atividade(
    CodAtividade INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Descricao VARCHAR(100)
);

#----------------------------------------------
#Tabela Turma
#----------------------------------------------
CREATE IF NOT EXISTS Turma(
    CodTurma INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Horario TIME NOT NULL,
    Duracao INT NOT NULL,
    DataInicio DATE NOT NULL,
    DataFim DATE,
    CodAtividade int NOT NULL,
    CodInstrutor int NOT NULL,
)





