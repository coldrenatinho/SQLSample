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
USE Atividade02;
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
CREATE DATABASE Atividade04;
USE Atividade04;
#----------------------------------------------

#----------------------------------------------
#Tabela Diretor
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Diretor(
    CodDiretor INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(300) NOT NULL,
    AnoNascimento DATE NOT NULL
);

#----------------------------------------------
#Tabela Fimes
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Filme(
    CodFilme INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    NomeOriginal VARCHAR(200) NOT NULL,
    NomeExibicao VARCHAR(200),
    DataEtreia DATE,
    AnoLancamento DATE NOT NULL,
    CodDiretor INT NOT NULL,
    Tipo INT NOT NULL,
    Sinopse VARCHAR(400)
);
#----------------------------------------------
# Adiconando resitrição de chave estrangeira ao CodDiretor
#----------------------------------------------
ALTER TABLE FILME ADD CONSTRAINT FOREIGN KEY FK_Diretor_CodDiretor (CodDiretor) REFERENCES Diretor (CodDiretor);


#----------------------------------------------
#Tabela Premiacao
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Premiacao(
    CodPremiacao int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(200) NOT NULL,
    AnoPremiacao DATE NOT NULL
);

#----------------------------------------------
#Tabela Fimes Premiacao
#----------------------------------------------
CREATE TABLE IF NOT EXISTS FilmePremiacao(
    CodFilme INT NOT NULL,
    CodPremiacao INT NOT NULL,
    Classe Varchar(200) NOT NULL,
    Indicado VARCHAR(200)
);

#----------------------------------------------
#Adiocionando restrição de chave estrangeira a Tabela FilmesPremiacao (CodFilme,CodPremiacao)
#----------------------------------------------
ALTER TABLE FilmePremiacao ADD CONSTRAINT FOREIGN KEY FK_Filme_CodFilme (CodFilme) REFERENCES FILME (CodFilme);
ALTER TABLE FilmePremiacao ADD CONSTRAINT FOREIGN KEY FK_Premiacao_CodPremiacao (CodPremiacao) REFERENCES Premiacao (CodPremiacao);

#----------------------------------------------
#Tabela Horarios 
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Horario(
	CodHorario INT PRIMARY KEY NOT NULL,
    Horario TIME NOT NULL,
    Descricao VARCHAR(100) NOT NULL
);

#----------------------------------------------
#Tabela Salas
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Sala(
    CodSala INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    NomeSala VARCHAR(200) NOT NULL,
    Capacidade INT NOT NULL
);

#----------------------------------------------
#Tabela FilmesExebicao
#----------------------------------------------
CREATE TABLE IF NOT EXISTS FilmeExibicao(
    CodSala INT NOT NULL,
    CodFilme INT NULL NULL,
    CodHorario INT NOT NULL
);

#----------------------------------------------
#Adicionando restrição de chave estrairas a Tabela FilmeExibicao
#----------------------------------------------
ALTER TABLE FilmeExibicao ADD CONSTRAINT FOREIGN KEY FK_Sala_CodSala (CodSala) REFERENCES Sala (CodSala);
ALTER TABLE FilmeExibicao ADD CONSTRAINT FOREIGN KEY FK_Filme_CodFilme (CodSala) REFERENCES Filme (CodFilme);
ALTER TABLE FilmeExibicao ADD CONSTRAINT FOREIGN KEY FK_horario_CodHorario (CodHorario) REFERENCES Horario (CodHorario);


#----------------------------------------------
#Tabela Funcionario
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Funcionario(
    CodFuncionario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(200) NOT NULL,
    CPF INT NOT NULL UNIQUE,
    NomeSocial VARCHAR(200),
    DataAdimissao DATE NOT NULL,
    NumeroCarteiraTabalho INT NOT NULL UNIQUE,
    SalarioInicial FLOAT NOT NULL,
    Salario FLOAT NOT NULL
);

#----------------------------------------------
#Tabela Escala 
#Verifica Como pode ser definido de melhor forma a escala e horarios posteriormente
#----------------------------------------------
CREATE TABLE IF NOT EXISTS Escala(
    CodFuncionario INT NOT NULL,
    CodHorario INT NOT NULL,
    CodSala INT NOT NULL,
    CodFuncao INT NOT NULL
);

#----------------------------------------------
#Adicionando resitrição de chave estrageiras a tabela Escala
#----------------------------------------------
ALTER TABLE Escala ADD CONSTRAINT FOREIGN KEY FK_Funcionario_CodFuncionario (Codfuncionario) REFERENCES Funcionario (Codfuncionario);
ALTER TABLE Escala ADD CONSTRAINT FOREIGN KEY FK_Sala_CodSala (CodSala) REFERENCES FilmeExibicao (CodSala);
ALTER TABLE Escala ADD CONSTRAINT FOREIGN KEY FK_Horario_CodHorario (CodHorario) REFERENCES Horario (CodHorario);

CREATE TABLE IF NOT EXISTS Funcao(
	Codfuncionario INT NOT NULL,
    Descricao VARCHAR(200)
);

ALTER TABLE FUNCAO ADD CONSTRAINT FOREIGN KEY FK_Escala_CodFuncionario (CodFuncionario) REFERENCES Escala (CodFuncionario);

#-----------------------GERANDO INSERT NO BANCO 'Atividade0'-----------------------

#----------------------------------------------
#Inserir dados na tabela Diretor
#----------------------------------------------
INSERT INTO Diretor (Nome, AnoNascimento)
VALUES
    ('Diretor 1', '1990-01-01'),
    ('Diretor 2', '1985-02-15'),
    ('Diretor 3', '1978-08-20');

#----------------------------------------------
#Inserir dados na tabela Filme
#----------------------------------------------
INSERT INTO Filme (NomeOriginal, NomeExibicao, DataEtreia, AnoLancamento, CodDiretor, Tipo, Sinopse)
VALUES
    ('Filme 1', 'Filme Exibição 1', '2023-03-10', '2023-03-05', 1, 1, 'Sinopse do Filme 1'),
    ('Filme 2', 'Filme Exibição 2', '2023-04-15', '2023-04-10', 2, 2, 'Sinopse do Filme 2'),
    ('Filme 3', 'Filme Exibição 3', '2023-05-20', '2023-05-15', 3, 1, 'Sinopse do Filme 3');

#----------------------------------------------
#Inserir dados na tabela Premiacao
#----------------------------------------------
INSERT INTO Premiacao (Nome, AnoPremiacao)
VALUES
    ('Oscar', '2023-02-28'),
    ('Globo de Ouro', '2023-01-15'),
    ('Festival de Cannes', '2023-05-25');

#----------------------------------------------
#Inserir dados na tabela FilmePremiacao
#----------------------------------------------
INSERT INTO FilmePremiacao (CodFilme, CodPremiacao, Classe, Indicado)
VALUES
    (1, 1, 'Melhor Atriz', 'Julia Pé de Pato'),
    (2, 1, 'Fotografia', 'Pablo 4K'),
    (3, 3, 'Melhor Diretor', 'Katsoriro Otomo');

#----------------------------------------------
#Inserir dados na tabela Horario
#----------------------------------------------
INSERT INTO Horario (CodHorario, Horario, Descricao)
VALUES
    (1, '14:00:00', 'Matinê'),
    (2, '19:30:00', 'Noite'),
    (3, '22:00:00', 'Madrugada');

#----------------------------------------------
#Inserir dados na tabela Sala
#----------------------------------------------
INSERT INTO Sala (NomeSala, Capacidade)
VALUES
    ('Prime', 100),
    ('Estrangeiro', 80),
    ('Estréia', 120);

#----------------------------------------------
#Inserir dados na tabela FilmeExibicao
#----------------------------------------------
INSERT INTO FilmeExibicao (CodSala, CodFilme, CodHorario)
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3);

#----------------------------------------------
#Inserir dados na tabela Funcionario
#----------------------------------------------
INSERT INTO Funcionario (Nome, CPF, NomeSocial, DataAdimissao, NumeroCarteiraTabalho, SalarioInicial, Salario)
VALUES
    ('José', 123456789, '', '2023-01-10', 101, 2500.00, 2800.00),
    ('Maria', 234567890, '', '2023-02-15', 102, 2600.00, 2900.00),
    ('Abel', 345678901, '', '2023-03-20', 103, 2700.00, 3000.00);


#----------------------------------------------
#Inserir dados na tabela Escala
#----------------------------------------------
INSERT INTO Escala (CodFuncionario, CodHorario, CodSala, CodFuncao)
VALUES
    (1, 1, 1, 1),
    (2, 2, 2, 2),
    (3, 3, 3, 3);


#----------------------------------------------
#Inserir dados na tabela Funcao
#----------------------------------------------
INSERT INTO Funcao (Codfuncionario, Descricao)
VALUES
    (1, 'Operador de Caixa '),
    (2, 'Recepcionista'),
    (3, 'Pipoqueiro');


#-----------------------FIM INSERT NO BANCO 'Atividade04'-----------------------
#-----------------------FIM TIVIDADE 'Atividade04'-----------------------


#-----------------------INICIO ATIVIDADE 04 (part2)-----------------------
DROP DATABASE Atividade04Part2;
CREATE DATABASE IF NOT EXISTS Atividade04Part2;

USE Atividade04Part2;


CREATE TABLE IF NOT EXISTS Departamento(
    CodDepartamento INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(45) NOT NULL,
    Telefone VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS Empregado(
    Nome VARCHAR(200) NOT NULL,
    Sexo CHAR(1) NOT NULL,
    Salario DECIMAL(2) NOT NULL,
    Logradouro VARCHAR(100) NOT NULL,
    Bairro VARCHAR(100) NOT NULL,
    CEP VARCHAR(9) NOT NULL,
    NumeroLogradouro VARCHAR(9) NOT NULL,
    CodMatricula VARCHAR(10) PRIMARY KEY NOT NULL,
    CodDepartamento INT NOT NULL
);

ALTER TABLE Empregado ADD CONSTRAINT FOREIGN KEY FK_Departamento_CodDepartamento (CodDepartamento) REFERENCES Departamento (CodDepartamento);


CREATE TABLE IF NOT EXISTS Projeto(
    CodProjeto INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Localizacao VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS EmpregadoProjeto(
    CodMatricula VARCHAR(10),
    CodProjeto INT
);

ALTER TABLE EmpregadoProjeto ADD CONSTRAINT FOREIGN KEY FK_Empregado_CodMatricula (CodMatricula) REFERENCES Empregado (CodMatricula);
ALTER TABLE EmpregadoProjeto ADD CONSTRAINT FOREIGN KEY FK_Projeto_CodProjeto (CodProjeto) REFERENCES Projeto (CodProjeto);


CREATE TABLE IF NOT EXISTS EmpregadoTelefone(
    CodMatricula VARCHAR(10) NOT NULL,
    Telefone VARCHAR(10) PRIMARY KEY NOT NULL
);

ALTER TABLE EmpregadoTelefone ADD CONSTRAINT FOREIGN KEY FK_Empregado_CodMatricula (CodMatricula) REFERENCES Empregado(CodMatricula);


CREATE TABLE IF NOT EXISTS Dependentes(
    CodDependete VARCHAR(10) PRIMARY KEY NOT NULL,
    Nome VARCHAR(45) NOT NULL,
    Sexo CHAR(1) NOT NULL,
    Parentesco VARCHAR(45) NOT NULL,
    CodMatricula VARCHAR(10) NOT NULL
);

ALTER TABLE Dependentes ADD CONSTRAINT FOREIGN KEY FK_Empregado_CodMatricula (CodMatricula) REFERENCES Empregado (CodMatricula);



#-----------------------FIM TIVIDADE 04 (Part 2)-----------------------




#-----------------------INICIO ATIVIDADE 04 (Part 3)-----------------------
DROP DATABASE Atividade04Part3; #REALIZAR TESTE DO SCRIP NO TERMINAL
#----------------------------------------------
#Novo Banco Atividade04Part3
#----------------------------------------------
CREATE DATABASE IF NOT EXISTS Atividade04Part3;

USE Atividade04Part3;

CREATE TABLE IF NOT EXISTS Customer(
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Contact INT(11) NOT NULL,
    Customer_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT
);

CREATE TABLE IF NOT EXISTS Customer_Package(
    ID VARCHAR(50) PRIMARY KEY NOT NULL,
    Type VARCHAR(50) NOT NULL,
    Delivery_Date DATE NOT NULL,
    City_Rate FLOAT NOT NULL,
    Customer_ID INT NOT NULL,
    Receiver_ID VARCHAR(50) NOT NULL,
    Delivered_ID VARCHAR(50) NOT NULL,
    Weight FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS Rate(
    City_Rate FLOAT PRIMARY KEY NOT NULL,
    Weight FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS Receiver(
    Receiver_ID VARCHAR(50) PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Contact VARCHAR(50) NOT NULL,
    Customer_ID INT(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS Address(
    Address VARCHAR(50) PRIMARY KEY NOT NULL,
    ID VARCHAR(50) NOT NULL,
    Receiver_ID VARCHAR(50) NOT NULL,
    Customer_ID INT(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS Employee(
    Name VARCHAR(50) NOT NULL,
    Employee_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Contact INT(11) NOT NULL,
    CNIC VARCHAR(20) NOT NULL,
    Branch_ID VARCHAR(50) NOT NULL,
    Desing_ID INT(11) NOT NULL,
	Shift VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS Designation(
    Desing_ID INT(50) PRIMARY KEY NOT NULL,
    Salary INT NOT NULL,
    Desing_Desc VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Delivery_Packger(
    ID VARCHAR(50) PRIMARY KEY NOT NULL,
    Employee_ID INT(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS Branch(
    ID VARCHAR(50) PRIMARY KEY NOT NULL,
    Coty VARCHAR(50)
);


ALTER TABLE Receiver ADD CONSTRAINT FOREIGN KEY FK_Customer_Customer_ID (Customer_ID) REFERENCES Customer (Customer_ID);
ALTER TABLE Address ADD CONSTRAINT FOREIGN KEY FK_Receiver_Receiever_ID (Receiver_ID) REFERENCES Receiver (Receiver_ID);
ALTER TABLE Address ADD CONSTRAINT FOREIGN KEY FK_Customer_Customer_ID (Customer_ID) REFERENCES Customer (Customer_ID);
ALTER TABLE Address ADD CONSTRAINT FOREIGN KEY FK_Branch_ID (ID) REFERENCES Branch (ID);
ALTER TABLE Customer_Package ADD CONSTRAINT FOREIGN KEY FK_Customer_ID (Customer_ID) REFERENCES Customer (Customer_ID);
ALTER TABLE Customer_Package ADD CONSTRAINT FOREIGN KEY FK_Receiver_Receiever_ID (Receiver_ID) REFERENCES Receiver (Receiver_ID);
ALTER TABLE Customer_Package ADD CONSTRAINT FOREIGN KEY FK_Rate_City_Rate (City_Rate) REFERENCES Rate (City_Rate);
ALTER TABLE Customer_Package ADD CONSTRAINT FOREIGN KEY FK_Delivery_Boy_Delivered_ID (Delivered_ID) REFERENCES Delivery_Packger (ID);
ALTER TABLE Employee ADD CONSTRAINT FOREIGN KEY FK_Branch_ID (Branch_ID) REFERENCES Branch (ID);
ALTER TABLE Employee ADD CONSTRAINT FOREIGN KEY FK_Designation_Desing_ID (Desing_ID) REFERENCES Designation (Desing_ID);
ALTER TABLE Delivery_Packger ADD CONSTRAINT FOREIGN KEY FK_Employee_Employee_ID (Employee_ID) REFERENCES Employee (Employee_ID);
