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
	and extract(epoch from(datafiminterrupcao - datainiciointerrupcao))/3600 <= 44

group by 
	sigagente 
	
having
	count(*) >= 6762

order by 
	median_time_hours desc

limit 10;