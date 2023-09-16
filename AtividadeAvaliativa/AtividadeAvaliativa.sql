#Esquema de banco a ser utilzado na aulas do Laboratório de Banco de Dados
#RENATO ARAUJO DA SILVA
#UNEMAT - UNIVERSIDADE DO ESTADO DO MATO GROSSO
#https://github.com/coldrenatinho/
#@coldrenatinho

#-----------------------------AERÓDROMO---------------------------------
DROP DATABASE VOO;

CREATE DATABASE IF NOT EXISTS VOO;

USE VOO;

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



    

    
                              


