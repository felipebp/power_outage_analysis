select 
	sigagente as eletric_utility,
	count(*) as total_occurrences,
	round(avg(extract(epoch from(datafiminterrupcao - datainiciointerrupcao))/3600), 2) as mean_time_to_fix,
	max(extract(epoch from(datafiminterrupcao - datainiciointerrupcao))/3600) as max_time_to_fix
from 
	public.interrupcoes_energia_2025
where 
	datafiminterrupcao is not null
	and datainiciointerrupcao is not null
group by 
	sigagente 
order by 
	mean_time_to_fix desc
limit 10;