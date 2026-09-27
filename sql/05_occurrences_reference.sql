select 
	round(percentile_cont(0.25) within group (order by total_occurrences)::numeric, 0) as p25_volume,
	round(percentile_cont(0.50) within group (order by total_occurrences)::numeric, 0) as p50_volume,
	round(avg(total_occurrences)::numeric,0) as mean_volume
from (
	select sigagente, count(*) as total_occurrences
	from public.interrupcoes_energia_2025
	group by sigagente
) tmp_table;