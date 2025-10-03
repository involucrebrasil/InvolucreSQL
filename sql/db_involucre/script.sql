SELECT
    d.id                    AS id_descarte,
    d.descarte_kg,
    d.custo_estimado,
    d.horario               AS horario_descarte,
    d.observacao,

    -- Embalagem
    e.id                   AS id_embalagem,
    e.nome                 AS nome_embalagem,
    e.tipo                 AS tipo_embalagem,
    e.valor_kg             AS valor_kg_embalagem,
    e.fornecedor           AS fornecedor_embalagem,

    -- Motivo
    m.id                   AS id_motivo,
    m.nome                 AS nome_motivo,
    m.descricao            AS descricao_motivo,

    -- Empregado
    emp.id                 AS id_empregado,
    emp.nome               AS nome_empregado,
    emp.sobrenome,
    emp.cpf,
    emp.email              AS email_empregado,
    emp.cargo,
    emp.tipo               AS tipo_empregado,

    -- Empresa (relacionada ao empregado)
    emp.cod_empresa,
    emp_e.nome             AS nome_empresa,
    emp_e.email            AS email_empresa,
    emp_e.cnpj,
    emp_e.uf               AS uf_empresa,
    emp_e.cidade           AS cidade_empresa,
    emp_e.bairro           AS bairro_empresa,
    emp_e.cep              AS cep_empresa,

    -- Plano da Empresa
    p.id                   AS id_plano,
    p.nome                 AS nome_plano,
    p.preco                AS preco_plano,
    p.descricao            AS descricao_plano,

    -- Mídia do descarte
    mid.caminho_arquivo,
    mid.horario            AS horario_midia

FROM descarte d
         LEFT JOIN embalagem e ON d.cod_embalagem = e.id
         LEFT JOIN motivo m ON d.cod_motivo = m.id
         LEFT JOIN empregado emp ON d.cod_empregado = emp.id
         LEFT JOIN empresa emp_e ON emp.cod_empresa = emp_e.id
         LEFT JOIN plano p ON emp_e.cod_plano = p.id
         LEFT JOIN telefone_empresa te ON emp_e.id = te.cod_empresa
         LEFT JOIN midia mid ON d.cod_midia = mid.id;
