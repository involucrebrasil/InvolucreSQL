-- Listar descarte por embalagem
create VIEW descarte_por_embalagem as
SELECT
    e.nome as embalagem,
    SUM(d.descarte_kg) as descarte_kg,
    SUM(d.custo_estimado) as custo_estimado
FROM descarte d
         JOIN embalagem e ON e.id = d.cod_embalagem
GROUP BY e.nome
ORDER BY 2 DESC;

-- Listar empregados com mais descarte
CREATE VIEW empregados_com_mais_descarte as
SELECT empg.id, concat(empg.nome, ' ', empg.sobrenome) as "nome_completo", sum(d.descarte_kg) as "total", emps.nome as
    "empresa"
from empregado empg
join empresa emps on emps.id = empg.cod_empresa
join descarte d on empg.id = d.cod_empregado
GROUP BY empg.nome, empg.sobrenome, empg.id, empresa
ORDER BY 3 DESC
LIMIT 5;

-- Descarte por mês
CREATE VIEW descarte_por_mes as
SELECT TO_CHAR(DATE_TRUNC('month', horario), 'TMMonth') AS mes, -- converte data do descarte para mês
       SUM(descarte_kg) AS total_descarte
FROM descarte
GROUP BY DATE_TRUNC('month', horario), mes
ORDER BY DATE_TRUNC('month', horario);

-- Descartes em intervalo de tempo
CREATE VIEW intervalo_meses as
SELECT DATE_TRUNC('day', horario)  AS data,
       TO_CHAR(horario, 'TMMonth') AS mes_nome,
       EXTRACT(MONTH FROM horario) AS mes_num,
       EXTRACT(YEAR FROM horario)  AS ano,
       SUM(descarte_kg)            AS total_kg
FROM descarte
GROUP BY data, mes_nome, mes_num, ano, horario
ORDER BY DATE_TRUNC('day', horario);

-- Utilitários da página inicial
CREATE VIEW util as
SELECT count(DISTINCT epg.id) as empregados_registrados, -- usando distinct para pegar valores individuais de cada tabela
       count(DISTINCT d.id) as descartes_registrados,
       count(DISTINCT m.id) as motivos_registrados,
       count(DISTINCT emb.id) as embalagens_registradas,
       sum(d.descarte_kg) as total_descartado,
       sum(d.custo_estimado) as custo_total

from empregado epg
join descarte d on d.cod_empregado = epg.id
join motivo m on m.id = d.cod_motivo
join embalagem emb on emb.id = d.cod_embalagem;

create view tendencia_descartes as
select to_char(date_trunc('month', horario), 'TMMonth') as mes, -- converte data para mês
       sum(descarte_kg) as total_descartes
from descarte
where horario >= (current_date - INTERVAL '2 months') -- usa INTERVAL de dois meses para pegar mês anterior completo
GROUP BY DATE_TRUNC('month', horario), mes
ORDER BY DATE_TRUNC('month', horario) DESC
LIMIT 2;

create view tendencia_embalagens as
select e.nome as embalagem, sum(d.descarte_kg) as qtd,
       sum(d.descarte_kg) * 100 / (select sum(descarte_kg) from descarte) as percentual
from descarte d
join embalagem e on e.id = d.cod_embalagem
group by e.nome
order by qtd desc
limit 1;

create view tendencia_motivos as
select m.nome as motivo, count(*) as total_descartes,
       count(*) * 100 / (select count(*) from descarte) as percentual
from descarte d
join motivo m on m.id = d.cod_motivo
group by m.nome
order by total_descartes desc
limit 1;