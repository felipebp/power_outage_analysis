-- Criando Tabela Dimensional
create table public.dim_causa_interrupcao (
		id_motivo INT primary key,
		causa_regulatoria varchar(100),
		descricao_abrangencia text
);

-- Inserção de Dados Oficiais da ANEEL
insert into public.dim_causa_interrupcao (id_motivo, causa_regulatoria, descricao_abrangencia)
values 
	(0, 'Interna - Próprias do Sistema', 'Falhas estruturais intrínsecas da rede: Falha de material ou equipamento, defeitos em transformadores, cabos partidos...'),
    (1, 'Interna - Causa de Unidade Consumidora', 'Ocorrências originadas por falhas de instalações particulares (do próprio cliente/consumidor)'),
    (2, 'Externa - Sobrecarga Técnica', 'Variações de demanda ou anomalias técnicas sistêmicas externas'),
    (3, 'Externa - Meio Ambiente', 'Eventos climáticos e fenômenos naturais diretos: Vento, descargas atmosféricas (raios), temporais, árvores...'),
    (4, 'Externa - Terceiros', 'Interferências humanas alheias à concessionária: Abalroamento de postes, vandalismo, furto de cabos, objetos na rede...'),
    (5, 'Programada', 'Desligamentos avisados previamente e agendados para manutenção, obras de expansão ou melhorias'),
    (6, 'Encargo de Transmissão / Geração', 'Falhas originadas fora da rede de distribuição, vindas da rede básica de alta tensão (Transmissoras) ou geradoras');
	