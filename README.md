# Power Outage Analysis - ANEEL 2025

## Motivação

A iniciativa decorre da crescente demanda do setor industrial brasileiro por recursos energéticos com disponibilidade constante. Nesse sentido, torna-se indispensável a análise das interrupções no fornecimento de energia elétrica, a fim de mitigar prejuízos logísticos e operacionais das bases já instaladas, bem como nortear o planejamento estratégico na tomada de decisões.

## Stack

O sistema operacional de minha escolha para o projeto foi o Fedora Workstation 44, por tratar-se de uma kernel linux, permitindo interagir diretamente via terminal com o banco de dados, facilitando assim na manutenção.

A partir disso, orquestrei um container PostgreSQL via Podman/Docker para ser o Sistema Gerenciador de Banco de Dados. Nessa etapa é muito importante que seja definido um volume persistente para armazenamento dos dados do Postgres, evitando dores de cabeça futuras caso o container seja equivocadamente deletado.

O software escolhido para interagir com o SGBD foi o DBeaver CE por entregar uma interface intuitiva, com ferramentas otimizadas.

## Etapa de Testes

### Validando atributos da tabela criada
```sql
select *
from public.interrupcoes_energia_2025
limit 10;
```

<img width="823" height="224" alt="image" src="https://github.com/user-attachments/assets/5efe5e80-3631-462e-bfc5-cbbffda7abce" />

<img width="783" height="224" alt="image" src="https://github.com/user-attachments/assets/5b6db4f5-6ce0-46db-aa64-157b2ed5c239" />

<img width="770" height="226" alt="image" src="https://github.com/user-attachments/assets/a20f0543-5f23-4d16-8d78-65762cdd81ab" />

## Etapa de Análise

### Top 10 - Distribuidoras com mais quedas de energia
```sql
select 
	sigagente,
	count (*) as total_occurrences
from public.interrupcoes_energia_2025
group by sigagente
order by total_occurrences desc
limit 10;
```

<img width="343" height="290" alt="image" src="https://github.com/user-attachments/assets/1ef75d83-c80b-43d4-a9a0-898d54d181a3" />

### Top 10 - Distribuidoras mais demoradas para reestabelecer a energia
```SQL
select 
	sigagente as eletric_utility,
	
	count(*) as total_occurrences,
	
	round(
		percentile_cont(0.50) within group(
			order by extract(epoch from(datafiminterrupcao - datainiciointerrupcao))/3600
		)::numeric, 2
	) as median_time_hours,
	
	round(
		percentile_cont(0.90) within group(
			order by extract(epoch from(datafiminterrupcao - datainiciointerrupcao))/3600
		)::numeric, 2
	) as p90_time_hours,
	
	round(
		avg(extract(epoch from(datafiminterrupcao - datainiciointerrupcao))/3600)::numeric, 2
	) as mean_time_hours,
	
	round(
		max(extract(epoch from(datafiminterrupcao - datainiciointerrupcao))/3600)::numeric, 2
	) as max_hours
	
from 
	public.interrupcoes_energia_2025

where 
	datafiminterrupcao is not null
	and datainiciointerrupcao is not null
	and datafiminterrupcao > datainiciointerrupcao
	and extract(epoch from(datafiminterrupcao - datainiciointerrupcao))/3600 <= 720

group by 
	sigagente 
	
having
	count(*) > 6725

order by 
	median_time_hours desc

limit 10;
```
Para garantir relevância estatística e evitar que micro-cooperativas distorçam a análise de risco, aplicou-se um filtro na cláusula HAVING, correspondente ao percentil 25 do volume nacional, restringindo a análise às distribuidoras com mais de 6762 ocorrências anuais. Além disso, em 99% dos casos as companhias levaram cerca de 44 horas para reestabelecer o fornecimento, dado esse obtido com o percentil 99, que permite descartar o 1% superior possívelmente referente a catástrofes ou erros de registro.

<img width="1012" height="216" alt="image" src="https://github.com/user-attachments/assets/dbca23b7-45a3-4b86-84c9-ef8a79856a9a" />







