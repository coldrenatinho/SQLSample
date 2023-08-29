#Esquema de banco a ser utilzado na aulas do Laboratório de Banco de Dados
#RENATO ARAUJO DA SILVA
#UNEMAT - UNIVERSIDADE DO ESTADO DO MATO GROSSO
#https://github.com/coldrenatinho/
#@coldrenatinho
 
#-----------------------INICIO ATIVIDADE 02-----------------------
DROP DATABASE Atividade02; #REALIZAR TESTE DO SCRIP NO TERMINAL
#----------------------------------------------
#Novo Banco Atividade02
#----------------------------------------------
CREATE DATABASE IF NOT EXISTS Atividade02;

 USE Atividade02;
#----------------------------------------------
#Tabela Paciente
#----------------------------------------------
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

#----------------------------------------------
#Tabela Medico
#----------------------------------------------
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

#----------------------------------------------
#Tabela Horario Medico
#----------------------------------------------
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

#----------------------------------------------
#inserção restrição por chave estrangeira na tabela HorarioMedico
#----------------------------------------------
ALTER TABLE HorarioMedico ADD constraint foreign key FK_Medico_CodMedico (CodMedico) REFERENCES Medico (CodMedico);

#----------------------------------------------
#Tabela Consulta
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Consulta(
    CodConsulta INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    CodPaciente INT NOT NULL,
    CodMedico INT NOT NULL,
    DiaConsulta DATETIME,
    StatusConsulta CHAR(200) # Atendido/Cancelada/Aberta
);

#----------------------------------------------
#inserção restrição por chave estrangeira na tabela Consutla
#----------------------------------------------
ALTER TABLE Consulta ADD constraint foreign key FK_Medico_CodMedico (CodMedico) REFERENCES Medico (CodMedico);
ALTER TABLE Consulta ADD constraint foreign key FK_Pacinte_CodPacinte (CodPaciente) REFERENCES Paciente (CodPaciente);

#----------------------------------------------
#inserção VIEW ConsultasAgendadas
#----------------------------------------------
CREATE OR REPLACE VIEW ViewConsulta AS
    SELECT c.CodConsulta, m.Nome AS 'Nome Medico', m.Especialidade as 'Especialide', p.Nome AS 'Nome Pacinte', c.DiaConsulta as 'Data Consulta', c.StatusConsulta as 'Status da Consulta'
    FROM Consulta C
    INNER JOIN Medico m on
    m.CodMedico = c.CodMedico
    INNER JOIN Paciente p on 
    p.CodPaciente = c.CodPaciente;

#-----------------------GERANDO INSERT NO BANCO 'Atividade02'-----------------------

#----------------------------------------------
#inserção tabela Paciente
#----------------------------------------------
INSERT INTO Paciente (Nome, RG, CPF, Sexo, DataNascimento, Logradouro, NumeroLogradouro, CEP, Bairro, Celular, NomeConvernio, CodMatriculConvenio)
VALUES
    ('Maria Silva', 12345678, 98765432, 'F', '1990-05-15', 'Rua A', 123, 12345678, 'Centro', 987654321, 'ConvenioSaude', 456),
    ('João Santos', 87654321, 54321678, 'M', '1985-10-20', 'Av. B', 456, 87654321, 'Bairro1', 987654321, 'ConvenioMed', 789),
    ('Ana Oliveira', 23456789, 87654321, 'F', '1988-02-28', 'Rua B', 456, 23456789, 'Bairro2', 876543210, 'PlanoVida', 123),
    ('Pedro Almeida', 34567890, 76543210, 'M', '1995-11-10', 'Av. C', 789, 34567890, 'Centro', 765432109, 'ConvenioSaude', 234);

#----------------------------------------------
#inserção tabela Medico
#----------------------------------------------
INSERT INTO Medico (Nome, CRM, Especialidade, CodHorario, Celular, CelularRecado, Logradouro, NumeroLogradouro, CEP, Bairro)
VALUES
    ('Dr. Ana Souza', 123456, 'Cardiologia', 1, 987654321, 987654322, 'Rua X', 789, 98765432, 'Centro'),
    ('Dr. Carlos Santos', 987654, 'Dermatologia', 2, 987654321, 987654322, 'Av. Y', 654, 87654321, 'Bairro2'),
    ('Dra. Luiza Rodrigues', 567890, 'Pediatria', 3, 876543210, 876543211, 'Rua Y', 987, 56789012, 'Bairro3'),
    ('Dr. Marcelo Lima', 678901, 'Ortopedia', 4, 765432109, 765432210, 'Av. Z', 123, 45678901, 'Centro');

#----------------------------------------------
#inserção tabela HorarioMedico
#----------------------------------------------
INSERT INTO HorarioMedico (CodHorario, CodMedico, DataInicio, DataFim, DiaSemanaInicio, DiaSemanaFim, HoraEtranda, DataSaida)
VALUES
    (1, 1, '2023-09-01', '2023-12-31', 1, 5, '08:00:00', '17:00:00'),
    (2, 2, '2023-09-01', '2023-12-31', 1, 5, '09:00:00', '18:00:00'),
    (3, 3, '2023-09-01', '2023-12-31', 1, 3, '10:00:00', '15:00:00'),
    (4, 4, '2023-09-01', '2023-12-31', 3, 5, '12:00:00', '20:00:00');

#----------------------------------------------
#inserção tabela Consutla
#----------------------------------------------
INSERT INTO Consulta (CodPaciente, CodMedico, DiaConsulta, StatusConsulta)
VALUES
    (1, 1, '2023-09-10 10:00:00', 'Atendido'),
    (2, 2, '2023-09-12 14:30:00', 'Aberta'),
    (1, 3, '2023-09-15 11:30:00', 'Atendido'),
    (3, 4, '2023-09-18 14:00:00', 'Aberta');

#-----------------------FIM DO INSERT-----------------------

#-----------------------LIMPEZA DO TERMINAL----------------------- 
#system cls #Limpa a tela terminal
#\! echo 'Ficha de atendimentos'; #Faz o print no terminal

#-----------------------Retorno da View-----------------------
SELECT *
FROM ViewConsulta;

#-----------------------FIM DA ATIVIDADE-----------------------


#-----------------------INICIO ATIVIDADE 03-----------------------
DROP DATABASE Atividade03; #REALIZAR TESTE DO SCRIP NO TERMINAL
#----------------------------------------------
#Novo Banco Atividade03
#----------------------------------------------
CREATE DATABASE IF NOT EXISTS Atividade03;
USE Atividade03;

#----------------------------------------------
#Tabela Instrutor
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Instrutor(
    CodInstrutor INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
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
#inserção Chave Estrageira Verificando o ID do Instrutor
#----------------------------------------------
ALTER TABLE TelefoneInstrutor ADD CONSTRAINT FOREIGN KEY FK_Instrutor_CodInstrutor (CodInstrutor) REFERENCES Instrutor (CodInstrutor);

#----------------------------------------------
#Tabela Atividade
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Atividade(
    CodAtividade INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Descricao VARCHAR(100)
);

#----------------------------------------------
#Tabela Turma
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Turma(
    CodTurma INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Horario TIME NOT NULL,
    Duracao INT NOT NULL,
    DataInicio DATE NOT NULL,
    DataFim DATE,
    CodAtividade int NOT NULL,
    CodInstrutor int NOT NULL
);

#----------------------------------------------
#Criação das restrição das chaves estrageirasCriação das restrição das chaves estrageiras
#----------------------------------------------
ALTER TABLE Turma ADD CONSTRAINT FOREIGN KEY FK_Atividade_CodAtividade (CodAtividade) REFERENCES Atividade (CodAtividade);
ALTER TABLE Turma ADD CONSTRAINT FOREIGN KEY FK_Instrutor_CodInstrutor (CodInstrutor) REFERENCES Instrutor (CodInstrutor);

#----------------------------------------------
#Tabela Aluno
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Aluno(
    CodMatricula INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    CodTurma INT NOT NULL,
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
#Criação das restrição das chaves estrageiras na tabela Aluno
#----------------------------------------------
ALTER TABLE Aluno ADD CONSTRAINT FOREIGN KEY FK_Turma_CodTurma (Codturma) REFERENCES Turma (CodTurma);



#----------------------------------------------
#Tabela Matricula
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Matricula(
    CodMatricula INT,
    CodTurma INT 
);

#----------------------------------------------
#FOREIGN KEY Tabela Matricula
#----------------------------------------------
ALTER TABLE Matricula ADD CONSTRAINT FOREIGN KEY FK_Aluno_CodMatricula (CodMatricula) REFERENCES Aluno (CodMatricula);
ALTER TABLE Matricula ADD CONSTRAINT FOREIGN KEY FK_Turma_CodTurma (CodTurma) REFERENCES Turma (CodTurma);

#----------------------------------------------
#Tabela Chamada
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Chamada(
    CodChamada INT NOT NULL,
    Data DATE,
    PRESENTE CHAR(1), #Valores S = Sim, N = Não
    CodMatricula INT ,
    CodTurma INT
);
#----------------------------------------------
#RESTRIÇÃO DE CHAVE ESTRANGEIRA NA TABELA CHAMADA
#----------------------------------------------
ALTER TABLE Chamada ADD CONSTRAINT FOREIGN KEY FK_Matricula_CodMatricula (CodMatricula) REFERENCES Matricula (CodMatricula);
ALTER TABLE Chamada ADD CONSTRAINT FOREIGN KEY FK_Matricula_CodTurma (CodTurma) REFERENCES Matricula (CodTurma);

#----------------------------------------------
#inserção View Turma
#----------------------------------------------

USE Atividade03;

CREATE OR REPLACE VIEW ViewTurma AS
SELECT
    t.CodTurma,
    t.Horario,
    t.Duracao,
    t.DataInicio,
    t.DataFim,
    a.Descricao AS Atividade,
    i.Nome AS Instrutor,
    al.Nome AS Aluno,
    al.DataMatricula,
    al.Logradouro AS EnderecoAluno,
    al.NumeroLogradouro AS NumeroEnderecoAluno,
    al.Bairro AS BairroAluno,
    al.CEP AS CEPAluno,
    al.Telefone AS TelefoneAluno,
    al.TelefoneRecado AS TelefoneRecadoAluno,
    al.DataNascimento AS DataNascimentoAluno,
    al.Altura AS AlturaAluno,
    al.Peso AS PesoAluno
FROM Turma t
JOIN Atividade a ON t.CodAtividade = a.CodAtividade
JOIN Instrutor i ON t.CodInstrutor = i.CodInstrutor
JOIN Matricula m ON t.CodTurma = m.CodTurma
JOIN Aluno al ON m.CodMatricula = al.CodMatricula;



#-----------------------GERANDO INSERT NO BANCO 'Atividade03'-----------------------
USE Atividade03;
#----------------------------------------------
#-Inserção de dados na tabela Instrutor
#----------------------------------------------
INSERT INTO Instrutor (RG, Nome, DataNascimento, Titulacao)
VALUES
    (123456789, 'João Silva', '1980-01-15', 2),
    (987654321, 'Maria Santos', '1985-05-20', 1);
#----------------------------------------------
#Inserção de dados na tabela TelefoneInstrutor
#----------------------------------------------
INSERT INTO TelefoneInstrutor (Numero, Tipo, CodInstrutor)
VALUES
    (123456789, 'Celular', 1),
    (987654321, 'Fixo', 2);

#----------------------------------------------
#Inserção de dados na tabela Atividade
#----------------------------------------------
INSERT INTO Atividade (Descricao)
VALUES
    ('Natação'),
    ('Yoga');

#----------------------------------------------
#Inserção de dados na tabela Turma
#----------------------------------------------
INSERT INTO Turma (Horario, Duracao, DataInicio, DataFim, CodAtividade, CodInstrutor)
VALUES
    ('09:00:00', 60, '2023-02-01', '2023-05-01', 1, 1),
    ('15:00:00', 90, '2023-03-01', '2023-06-01', 2, 2);

#----------------------------------------------
#Inserção de dados na tabela Aluno
#----------------------------------------------
INSERT INTO Aluno (CodTurma, DataMatricula, Nome, Logradouro, NumeroLogradouro, Bairro, CEP, Telefone, TelefoneRecado, DataNascimento, Altura, Peso)
VALUES
    (1, '2023-01-10', 'Ana Oliveira', 'Rua A', 123, 'Centro', 12345678, 987654321, 987654322, '1995-08-25', 1.70, 65),
    (2, '2023-01-10', 'Pedro Almeida', 'Av. B', 456, 'Bairro1', 87654321, 987654321, 987654322, '1998-03-15', 1.80, 70);

#----------------------------------------------
#Inserção de dados na tabela Matricula
#----------------------------------------------
INSERT INTO Matricula (CodMatricula, CodTurma)
VALUES
    (1, 1),
    (2, 2);

#----------------------------------------------
#Inserção de dados na tabela Chamada
#----------------------------------------------
INSERT INTO Chamada (CodChamada, Data, PRESENTE, CodMatricula, CodTurma)
VALUES
    (1, '2023-02-05', 'S', 1, 1),
    (2, '2023-03-10', 'S', 2, 2);

#-----------------------LIMPEZA DO TERMINAL----------------------- 
#system cls #Limpa a tela terminal
#\! echo 'Ficha de atendimentos'; #Faz o print no terminal

#-----------------------Retorno da View-----------------------
USE Atividade03;
SELECT *
FROM ViewTurma;



#-----------------------FIM ATIVIDADE 03-----------------------



#-----------------------INICIO ATIVIDADE 04-----------------------
DROP DATABASE Atividade04; #REALIZAR TESTE DO SCRIP NO TERMINAL
#----------------------------------------------
#Novo Banco Atividade04
#----------------------------------------------
CREATE DATABASE IF NOT EXISTS Atividade04;

 USE Atividade04;

 /*
 CINEMA=
 SALA
 
 FILME
 HORARIOS


 FILMES>SALAS>HORARIOS

sala=
 ID > NOME
capacidade
 

 filme=

 nome lingua original
nome liguagem estrangeira
diretor
ano de laçamento
tipo
sinopse

Não existem dois filmes com nome em portugues e ano

premiação=
entidade
ano
tipo

 */