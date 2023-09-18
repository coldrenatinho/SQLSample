Scrip Original da criação do MER
Caso Scrip Final a pasta acima "AtividadeFinal.sql" não possa ser utilzado 
Pode ser utilizado o Scrip "Original" para criar o banco e sua tabelas 

Havendo duas opções para importar os dados

1. Utilizar os CSV's Armazendados na pasta "Sheets" arquivos:
	"ICAOcadastro-de-aerodromos.UTF-8.csv"
	"Voos_Operados_em_Maio_de_2020.csv"

Os dois arquivo deverão ser copiados para a pasta padão de compartilhamento do MySQL no scrip utilizado no sistema operacional Windowns
Segue a pasta:

'C:\\ProgramData\\MySQL\\MySQL Server 8.1\\Uploads\\'"

2. Utilizar inset gerado pelo MySQL

Deve ser utilizado o Scrip "EscriptUtilizado.sql"
Até sua marcação: 
"-----------------------------FIM AERÓDROMO---------------------------------"

Após utilizar os inserts localizados no diretório: "../InsertData"
Arquivos:
anac_aerodromo,
anac_empresa,
anac_municipio,
anac_periodo,
anac_voooperado,

Os inserts devem ser executados no banco de dados "Anac"