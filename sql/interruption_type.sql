select 
	dsctipointerrupcao,
	count(*) as total_type
from
	public.interrupcoes_energia_2025
group by dsctipointerrupcao 
order by total_type 
