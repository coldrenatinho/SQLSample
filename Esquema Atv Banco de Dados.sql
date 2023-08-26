#Esquema de banco a ser utilzado na aulas do Laboratório de Banco de Dados
#RENATO ARAUJO DA SILVA
#UNEMAT - UNIVERSIDADE DO ESTADO DO MATO GROSSO

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
    NomeConvernio INT NOT NULL,
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

 #1.1