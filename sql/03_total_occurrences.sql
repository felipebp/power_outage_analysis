select 
	sigagente,
	count (*) as total_occurrences
from public.interrupcoes_energia_2025
group by sigagente
order by total_occurrences desc
limit 10;