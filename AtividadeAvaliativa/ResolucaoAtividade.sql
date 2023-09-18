/*
1) Faça uma consulta em Linguagem SQL que seja capaz de retornar todos os voos originados no
estado de Mato Grosso
2) Faça uma consulta em Linguagem SQL que seja capaz de retornar todos os voos originados na
cidade de Sinop.
3) Faça uma consulta em Linguagem SQL que retorna todas as cidades que tem mais de um
aeroporto cadastrado.
4) Faça uma consulta em Linguagem SQL que seja capaz de retornar quantos voos cada empresa
aérea fez durante o período cadastrado.
5) Faça uma consulta em Linguagem SQL que seja capaz de retornar qual voo teve o valor valor de
tarifa registrado.
6) Faça uma consulta em Linguagem SQL que seja capaz de retornar qual voo teve o maior número
de assentos vendidos.
*?
*/
#-----------------RESOLUÇÃO 1-----------------
use anac;
SELECT V.ID_VooOperado, cast(p.MesReferencia as char) as Mes, cast(p.AnoReferencia as char) as Ano ,ICAOEmpresa Empresa, V.AssentosComercializados, m.NomeMunicipio, m.UF
FROM anac.voooperado v
join anac.aerodromo a on
a.CodAerodromo = v.CodOrigem or a.CodAerodromo = v.CodDestino
JOIN anac.municipio m on 
m.CodMunicipio = a.CodMunicipio
JOIN anac.periodo p
on p.CodPeriodo = v.CodPeriodo
JOIN Empresa e on
e.CodEmpresa = v.CodEmpresa
WHERE m.UF = 'MT'
ORDER BY m.NomeMunicipio
;

#-----------------RESOLUÇÃO 2-----------------
use anac;
SELECT V.ID_VooOperado, cast(p.MesReferencia as char) as Mes, cast(p.AnoReferencia as char) as Ano ,ICAOEmpresa Empresa, V.AssentosComercializados, m.NomeMunicipio, m.UF
FROM anac.voooperado v
join anac.aerodromo a on
a.CodAerodromo = v.CodOrigem
JOIN anac.municipio m on 
m.CodMunicipio = a.CodMunicipio
JOIN anac.periodo p
on p.CodPeriodo = v.CodPeriodo
JOIN Empresa e on
e.CodEmpresa = v.CodEmpresa
WHERE m.NomeMunicipio like 'SINOP'
ORDER BY v.ID_VooOperado;


#-----------------RESOLUÇÃO 3-----------------
SELECT m.CodMunicipio ,m.NomeMunicipio, count(*) as Qunatidade
FROM anac.municipio m
JOIN anac.aerodromo a
ON m.CodMunicipio = a.CodMunicipio
GROUP BY m.CodMunicipio
having count(a.CodMunicipio) > 1
ORDER BY m.NomeMunicipio;


#-----------------RESOLUÇÃO 4----------------
SELECT p.CodPeriodo, e.ICAOEmpresa, count(v.ID_VooOperado) as 'Soma Voo Operados'
FROM anac.voooperado v
join anac.empresa e on
e.CodEmpresa = v.CodEmpresa
join anac.periodo p on
v.CodPeriodo = p.CodPeriodo
group by p.CodPeriodo, e.ICAOEmpresa
order by ICAOEmpresa;

/*
5) Faça uma consulta em Linguagem SQL que seja capaz de retornar qual voo teve o valor (maior ?) valor de
tarifa registrado. #PDF TEM Erro de digiração entedo que deve ser retornado o maior valor
*/

#-----------------RESOLUÇÃO 5-----------------
SELECT v.ID_VooOperado, e.ICAOEmpresa, aorg.Nome, adest.Nome, v.Tarifa, v.AssentosComercializados
FROM anac.voooperado v
join anac.empresa e on
e.CodEmpresa = v.CodEmpresa
join anac.aerodromo aorg on
aorg.CodAerodromo = v.CodOrigem
join anac.aerodromo adest on
adest.CodAerodromo = v.CodDestino
group by V.ID_VooOperado
order by v.Tarifa desc
limit 1;

#-----------------RESOLUÇÃO 6-----------------
SELECT v.ID_VooOperado, e.ICAOEmpresa, aorg.Nome, adest.Nome, v.Tarifa, v.AssentosComercializados
FROM anac.voooperado v
join anac.empresa e on
e.CodEmpresa = v.CodEmpresa
join anac.aerodromo aorg on
aorg.CodAerodromo = v.CodOrigem
join anac.aerodromo adest on
adest.CodAerodromo = v.CodDestino
group by V.ID_VooOperado
order by v.AssentosComercializados desc
limit 1;


