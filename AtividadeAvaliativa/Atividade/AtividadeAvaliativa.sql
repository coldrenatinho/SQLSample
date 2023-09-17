#Atividade Avaliativa Laboratório de Banco de Dados
#RENATO ARAUJO DA SILVA
#UNEMAT - UNIVERSIDADE DO ESTADO DO MATO GROSSO
#https://github.com/coldrenatinho/
#@coldrenatinho
--------------------------------------------------------------
#https://skyvector.com/
#Metadados dataset dos voos: https://www.anac.gov.br/acesso-a-informacao/dados-abertos/areas-de-atuacao/voos-e-operacoes-aereas/tarifas-aereas-domesticas/46-tarifas-aereas-domesticas
#https://www.gov.br/anac/pt-br/assuntos/regulados/aerodromos/lista-de-aerodromos-civis-cadastrados
#DROP DATABASE Anac;

CREATE DATABASE IF NOT EXISTS Anac;

USE Anac;

CREATE TABLE IF NOT EXISTS Periodo(
	CodPeriodo INT PRIMARY KEY NOT NULL auto_increment,
    AnoReferencia INT NOT NULL,
    MesReferencia INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Municipio(
	CodMunicipio INT PRIMARY KEY NOT NULL auto_increment,
    UF CHAR(2) NOT NULL,
    NomeMunicipio VARCHAR(100) NOT NULL,
    CodIBGE INT
);

CREATE TABLE IF NOT EXISTS Empresa(
	CodEmpresa int PRIMARY KEY NOT NULL auto_increment,
    ICAOEmpresa VARCHAR(5) NOT NULL UNIQUE,
    NomeEmpresa VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Aerodromo(
	CodAerodromo INT NOT NULL auto_increment unique,
    AOCI VARCHAR(10) NOT NULL,
    CIAD VARCHAR(10) NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    CodMunicipio INT,
    #MunicipioAtendido VARCHAR(100) NOT NULL,
    #UF VARCHAR(2) NOT NULL,
    Latitude VARCHAR(200) NOT NULL,
    Longitude VARCHAR(200) NOT NULL,
    PRIMARY KEY (AOCI,CIAD)
);

CREATE TABLE IF NOT EXISTS VooOperado(
	ID_VooOperado INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    CodEmpresa INT NOT NULL,
    CodPeriodo INT NOT NULL,
    CodOrigem INT,
    CodDestino INT,
    Tarifa INT NOT NULL,
    AssentosComercializados INT NOT NULL
);

#-----------------------------CONSTAINT---------------------------------
ALTER TABLE VooOperado ADD CONSTRAINT foreign key FK_Aerodromo_CodOrigem (CodOrigem) REFERENCES Aerodromo (CodAerodromo);
ALTER TABLE VooOperado ADD CONSTRAINT foreign key FK_Aerodromo_CodDestino (CodDestino) REFERENCES Aerodromo (CodAerodromo);
ALTER TABLE VooOperado ADD constraint foreign key FK_Empres_CodEmpresa (CodEmpresa) REFERENCES Empresa (CodEmpresa);
ALTER TABLE VooOperado ADD constraint foreign key FK_Periodo_CodPeriodo (CodPeriodo) references Periodo (CodPeriodo);
ALTER TABLE Aerodromo ADD constraint foreign key FK_Aerodromo_CodMunicipio (CodMunicipio) REFERENCES Municipio (CodMunicipio);
#-----------------------------FIM CONSTRAINT---------------------------------
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

CREATE TABLE IF NOT EXISTS Import_VooOperado(
    ID_VooOperado INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    AnoReferencia INT,
    MesReferencia INT,
    ICAOEmpresaAerea VARCHAR(10),
    ICAOAerodromoOrigem VARCHAR(10),
    ICAOAerodromoDestino VARCHAR(10),
    Tarifa INT,
    AssentosComercializados int
);

#-----------------------------Dados do CSV---------------------------------
#AQUIVO DE CSV A SER IMPORTADO DEVE SER ALOCADO NO SEGUINTE DIRETÓRIO "C:\\ProgramData\\MySQL\\MySQL Server 8.1\\Uploads\\"
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.1\\Uploads\\ICAOcadastro-de-aerodromos.UTF-8.csv'
INTO TABLE Import_Aerodromo
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OACI,CIAD,NomeAerodromo,MunicipioAtendido,UF,Latitude,Longitude);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.1\\Uploads\\Voos_Operados_em_Maio_de_2020.csv'
INTO TABLE Import_VooOperado
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(AnoReferencia, MesReferencia, ICAOEmpresaAerea, ICAOAerodromoOrigem, ICAOAerodromoDestino, Tarifa, AssentosComercializados);
#-----------------------------Dados do CSV---------------------------------

#-----------------------------Import_Sheets---------------------------------



-----------------------------INSERT TABLES--------------------------------- 
insert into Anac.Periodo (AnoReferencia, MesReferencia)
SELECT AnoReferencia, MesReferencia
FROM Import_VooOperado
GROUP BY AnoReferencia, MesReferencia
ORDER BY AnoReferencia, MesReferencia;

insert into Anac.Empresa (ICAOEmpresa)
SELECT ICAOEmpresaAerea
FROM Import_VooOperado
group by ICAOEmpresaAerea;

insert into Anac.Municipio(UF, NomeMunicipio)
SELECT distinct UF, MunicipioAtendido
FROM Import_Aerodromo
GROUP BY UF, MunicipioAtendido
ORDER BY UF, MunicipioAtendido;

insert into Anac.Aerodromo(AOCI, CIAD, Nome,CodMunicipio,Latitude, Longitude)
SELECT OACI, CIAD ,NomeAerodromo ,(select CodMunicipio from Anac.Municipio WHERE ANAC.Municipio.NomeMunicipio = Import_Aerodromo.MunicipioAtendido LIMIT 1) as CodMunicipio,Latitude ,Longitude
FROM Import_Aerodromo;

insert into Anac.VooOperado(CodEmpresa, CodPeriodo, CodOrigem, CodDestino, Tarifa, AssentosComercializados)
select (SELECT CodEmpresa 
		FROM Anac.Empresa 
        where Anac.Empresa.ICAOEmpresa = Import_VooOperado.ICAOEmpresaAerea) as CodEmpresa,
       (SELECT CodPeriodo 
		FROM Anac.Periodo 
        where Import_VooOperado.AnoReferencia = Anac.Periodo.AnoReferencia 
        and Import_Sheets.Import_VooOperado.MesReferencia = Anac.Periodo.MesReferencia ) as CodPeriodo,
        (SELECT CodAerodromo 
        FROM Anac.Aerodromo 
        WHERE Anac.Aerodromo.AOCI = Import_VooOperado.ICAOAerodromoOrigem) as CodOrigem,
		(SELECT CodAerodromo 
        FROM Anac.Aerodromo 
        WHERE Anac.Aerodromo.AOCI = Import_VooOperado.ICAOAerodromoDestino) as CodDestino,
        Tarifa,
        AssentosComercializados
FROM Import_VooOperado;
