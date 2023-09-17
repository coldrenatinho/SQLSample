#Esquema de banco a ser utilzado na aulas do Laboratório de Banco de Dados
#RENATO ARAUJO DA SILVA
#UNEMAT - UNIVERSIDADE DO ESTADO DO MATO GROSSO
#https://github.com/coldrenatinho/
#@coldrenatinho
--------------------------------------------------------------
#https://skyvector.com/
#Metadados dataset dos voos: https://www.anac.gov.br/acesso-a-informacao/dados-abertos/areas-de-atuacao/voos-e-operacoes-aereas/tarifas-aereas-domesticas/46-tarifas-aereas-domesticas
#https://www.gov.br/anac/pt-br/assuntos/regulados/aerodromos/lista-de-aerodromos-civis-cadastrados
#-----------------------------AERÓDROMO---------------------------------
#DROP DATABASE VooOperado;

CREATE DATABASE IF NOT EXISTS VooOperado;

USE VooOperado;

CREATE TABLE IF NOT EXISTS Perido(
	CodPeriodo INT PRIMARY KEY NOT NULL auto_increment,
    Ano INT NOT NULL,
    Mes INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Empresa(
	CodEmpresa int PRIMARY KEY NOT NULL auto_increment,
    SiglaEmpresa VARCHAR(5),
    NomeEmpresa VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Aeroporto(
	CodAeroporto INT PRIMARY KEY NOT NULL auto_increment NOT NULL,
    AOCI VARCHAR(5) NOT NULL,
    CIAD VARCHAR(5) NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    MunicipioAtendido VARCHAR(100) NOT NULL,
    UF VARCHAR(2) NOT NULL,
    Latitude VARCHAR(200) NOT NULL,
    Logitude VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS VooOperado(
	ID_VooOperado INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    CodEmpresa INT NOT NULL,
    CodPerido INT NOT NULL,
    CodOrigem INT NOT NULL,
    CodDestino INT NOT NULL,
    Tarifa INT NOT NULL,
    AssentosComercializados INT NOT NULL
);

ALTER TABLE VooOperado ADD CONSTRAINT foreign key FK_Aeroporto_CodOrigem (CodOrigem) REFERENCES Aeroporto (CodAeroporto);
ALTER TABLE VooOperado ADD CONSTRAINT foreign key FK_Aeroporto_CodDestino (CodDestino) REFERENCES Aeroporto (CodAeroporto);
ALTER TABLE VooOperado ADD constraint foreign key FK_Empres_CodEmpresa (CodEmpresa) REFERENCES Empresa (CodEmpresa);
#-----------------------------FIM AERÓDROMO---------------------------------



#-----------------------------Import_Sheets---------------------------------
DROP DATABASE Import_Sheets;
CREATE DATABASE IF NOT EXISTS Import_Sheets;

USE Import_Sheets;

CREATE TABLE IF NOT EXISTS Import_Aerodromo(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    OACI VARCHAR(10),
    CIAD VARCHAR(10),
    NomeAerodromo VARCHAR(200),
    MunicipioAtendido VARCHAR(100),
    UF CHAR(2),
    Latitude VARCHAR(100),
    Longitude VARCHAR(100)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.1\\Uploads\\ICAOcadastro-de-aerodromos.UTF-8.csv'
INTO TABLE Import_Aerodromo
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OACI,CIAD,NomeAerodromo,MunicipioAtendido,UF,Latitude,Longitude);


SELECT *
FROM Import_Aerodromo
    
                              


