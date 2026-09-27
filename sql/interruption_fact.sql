select 
	idemotivointerrupcao,
	dscfatogeradorinterrupcao,
	count(*) as total_type
	
from public.interrupcoes_energia_2025

where dsctipointerrupcao = 'Não Programada'

group by 
	idemotivointerrupcao,
	dscfatogeradorinterrupcao

order by total_type desc;