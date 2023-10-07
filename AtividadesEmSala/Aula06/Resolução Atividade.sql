use dbauxilio29_03;

show tables;

#Atividade - 01
select *
from Beneficiario
where nis_beneficiario = 0 or nis_beneficiario is null;

#Atividade - 02
select *
from Beneficiario
where nis_beneficiario <> 0 and nis_beneficiario is not null;

#Atividade - 03
select *
from Beneficiario
where nome_responsavel like '%Não se aplica%' or nome_responsavel is null;

#Atividade - 04
select b.nome_beneficiario, r.nome_responsavel
from Beneficiario b
join responsavel r on b.nome_responsavel = r.nome_responsavel;


#Atividade - 05
select r.*, count(*) as Qtd
from responsavel r
join beneficiario b on r.nome_responsavel = b.nome_responsavel
where b.nome_responsavel not like '%Não se aplica%' and b.nome_responsavel not like '%Invalido%' and not(b.nome_responsavel) is null
group by b.nome_responsavel
having Qtd > 1
order by Qtd desc, b.nome_responsavel asc;

#Atividade - 06
select b.nome_beneficiario as 'Nome do Beneficiario', count(p.num_parcela) as 'Quandidade de parcelas', sum(p.valor) as 'valor total'
from Beneficiario b
join parcela_rel p on (b.nome_beneficiario = p.nome_beneficiario and p.id_enquadramento = 3)
group by p.nome_beneficiario
order by b.nome_beneficiario asc;

#Atividade - 07
select b.nome_beneficiario as 'Nome do Beneficiario', count(p.num_parcela) as 'Quandidade de parcelas', sum(p.valor) as 'valor total'
from Beneficiario b
join parcela_rel p on (b.nome_beneficiario = p.nome_beneficiario)
group by p.nome_beneficiario
order by b.nome_beneficiario asc;

#Atividade - 08
select nome_beneficiario as 'Nome Beneficiaro', sum(valor) as 'Valor Total Recebido'
from parcela_rel p
group by p.nome_beneficiario
order by sum(valor) desc
limit 1;

#Atividade - 09
select nome_beneficiario as 'Nome Beneficiaro', sum(valor) as 'Valor Total Recebido'
from parcela_rel p
group by p.nome_beneficiario
order by sum(valor) desc
limit 10;

#Atividade 11
select Nome_beneficiario, count(*)
from beneficiario
where Nome_beneficiario like '%maria de fatima%'
group by Nome_beneficiario
order by count(*) desc;

#Atividde 12

#Atividade 13
select *
from Beneficiario as Beneficiario
join Municipio  as Municipio on (Beneficiario.id_municipio_ibge = Municipio.idmunicipioIBGE)
where Municipio.estado like 'MT';

#Atividade - 14
select *
from Beneficiario as Beneficiario
join Municipio  as Municipio on (Beneficiario.id_municipio_ibge = Municipio.idmunicipioIBGE)
WHERE Municipio.idmunicipioIBGE = 5107909;

select Municipio.Estado, format(sum(parcela.valor), 'D', 'pt-BR') as 'Valor total recebido UF'
from parcela_rel as parcela
join beneficiario as beneficiario on(beneficiario.nome_beneficiario = parcela.nome_beneficiario)
join Municipio as Municipio on (Beneficiario.id_municipio_ibge = Municipio.idmunicipioIBGE)
group by Municipio.Estado
order by Municipio.Estado asc;


select Municipio.Estado, Municipio.nome_municipio as 'Nome municipio', format(sum(parcela.valor), 'D', 'pt-BR') as 'Valor total recebido UF'
from parcela_rel as parcela
join beneficiario as beneficiario on(beneficiario.nome_beneficiario = parcela.nome_beneficiario)
join Municipio as Municipio on (Beneficiario.id_municipio_ibge = Municipio.idmunicipioIBGE)
group by Municipio.Estado, Municipio.idmunicipioIBGE
order by Municipio.Estado asc, Municipio.idmunicipioIBGE asc;

