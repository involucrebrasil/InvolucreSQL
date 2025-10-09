-- Listar empresas por uf
SELECT * FROM empresa
WHERE UF = 'PE';

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
SELECT empg.id, concat(empg.nome, empg.sobrenome) as "nome_completo", sum(d.descarte_kg) as "total", emps.nome as "empresa"
from empregado empg
join empresa emps on emps.id = empg.cod_empresa
join descarte d on empg.id = d.cod_empregado
GROUP BY empg.nome, empg.sobrenome, empg.id, empresa
ORDER BY 3 DESC;

-- Descarte por mês
CREATE VIEW descarte_por_mes as
SELECT TO_CHAR(DATE_TRUNC('month', horario), 'Month') AS mes, SUM(descarte_kg) AS total_descarte
FROM descarte
GROUP BY DATE_TRUNC('month', horario)
ORDER BY DATE_TRUNC('month', horario);

SELECT * from descarte_por_mes;
SELECT *FROM descarte_por_embalagem ORDER BY 3;

select * from descarte
WHERE cod_embalagem = 3