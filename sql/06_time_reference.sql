select 

	round(percentile_cont(0.99) within group (
	order by extract(epoch from(datafiminterrupcao - datainiciointerrupcao))/3600)
	::numeric, 2
	) as p99_time,
	
	round(percentile_cont(0.95) within group(
	order by extract(epoch from(datafiminterrupcao - datainiciointerrupcao))/3600)
	::numeric, 2
	) as p95_time
	
from 
	public.interrupcoes_energia_2025
	
where
	datafiminterrupcao is not null
	and datainiciointerrupcao is not null
	and datafiminterrupcao > datainiciointerrupcao;