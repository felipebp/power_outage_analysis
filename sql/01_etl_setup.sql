DROP TABLE IF EXISTS public.interrupcoes_energia_2025;

CREATE TABLE public.interrupcoes_energia_2025 (
    datageracaoconjuntodados DATE,
    ideconjuntounidadeconsumidora VARCHAR(50),
    dscconjuntounidadeconsumidora TEXT,
    dscalimentadorsubestacao TEXT,
    dscsubestacaodistribuicao TEXT,
    numordeminterrupcao VARCHAR(50),
    dsctipointerrupcao TEXT,
    idemotivointerrupcao VARCHAR(50),
    datainiciointerrupcao TIMESTAMP,
    datafiminterrupcao TIMESTAMP,
    dscfatogeradorinterrupcao TEXT,
    numniveltensao NUMERIC(10,2),
    numunidadeconsumidora INTEGER, 
    numconsumidorconjunto INTEGER, 
    numano INTEGER,
    nomagenteregulado TEXT,
    sigagente VARCHAR(255),
    numcpfcnpj VARCHAR(20)
);

COPY public.interrupcoes_energia_2025 
FROM '/tmp/interrupcoes_energia_eletrica_2025.csv' 
DELIMITER ';' 
CSV HEADER 
ENCODING 'UTF-8';