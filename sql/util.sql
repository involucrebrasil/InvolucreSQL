-- Listar empresas por uf
SELECT * FROM empresa
WHERE UF = 'PE';

-- Listar descarte por embalagem
create VIEW descarte_por_embalagem as
SELECT e.nome as "embalagem", sum(d.descarte_kg) as "total"
from embalagem e
join descarte d on d.cod_embalagem = e.id
GROUP BY nome
ORDER BY 2 DESC;

-- Listar empregados com mais descarte
CREATE VIEW empregados_com_mais_descarte as
SELECT e.id, concat(e.nome, e.sobrenome) as "nome_completo", sum(d.descarte_kg) as "total"
from empregado e
join descarte d on e.id = d.cod_empregado
GROUP BY e.nome, e.sobrenome, e.id
ORDER BY 2 DESC
limit 5;

-- Descarte por mês
CREATE VIEW descarte_por_mes as
SELECT TO_CHAR(DATE_TRUNC('month', horario), 'Month') AS mes, SUM(descarte_kg) AS total_descarte
FROM descarte
GROUP BY DATE_TRUNC('month', horario)
ORDER BY DATE_TRUNC('month', horario);

SELECT * from descarte_por_mes