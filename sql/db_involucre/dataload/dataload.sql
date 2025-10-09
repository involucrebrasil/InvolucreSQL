-- Extensão de criptografia
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Inserindo os emails e senhas do administradores
INSERT INTO administrador (nome, email, senha)
VALUES ('Davi', 'davialiaga4@gmail.com', ENCODE(digest('Jones', 'sha256'), 'hex')),
       ('Noé', 'noirraceon@gmail.com', ENCODE(digest('Involucre', 'sha256'), 'hex')),
       ('João Vitor', 'maldonadjoao326@gmail.com', ENCODE(digest('26022010', 'sha256'), 'hex')),
       ('Enzo', 'enzoanegue@gmail.com', ENCODE(digest('Aneguinho', 'sha256'), 'hex')),
       ('Bella', 'isabellagimenesdossantos@gmail.com', ENCODE(digest('Elle', 'sha256'), 'hex')),
       ('João Pedro', 'joao.capelli@germinare.org.br', ENCODE(digest('Java_Escripte', 'sha256'), 'hex')),
       ('Achiles', 'achiles.silva@germinare.org.br', ENCODE(digest('Achiles', 'sha256'), 'hex'));

-- Dados de plano
INSERT INTO plano (nome, preco, descricao)
VALUES ('Standard Mensal', 149.99, 'Plano básico para pequenas empresas'),
       ('Standard Anual', 1439.99, 'Plano básico para pequenas empresas'),
       ('Pro Mensal', 199.99, 'Plano intermediário, ideal para empresas em expansão'),
       ('Pro Anual', 1919.99, 'Plano intermediário, ideal para empresas em expansão'),
       ('Premium Mensal', 399.99, 'Plano completo, ideal para grandes empresas'),
       ('Premium Anual', 3839.99, 'Plano completo, ideal para grandes empresas');

-- Dados de empresa
INSERT INTO empresa (nome, email, cnpj, uf, cidade, bairro, cep, rua, numero, cod_plano)
VALUES ('JMax', 'contato@jmax.com', '14.380.200/0001-21', 'SP', 'São Paulo', 'Freguesia do Ó', '02961-070', 'Monjolo',
        400, 6),
       ('Aragão', 'noscontate@aragao5.com.br', '17.535.201/0001-88', 'MT', 'Feliz Natal', 'Centro', '78885-000',
        'Maravilha', 823, 5),
       ('Ceres Haume', 'rh@cereshaume.com', '65.298.200/0002-21', 'MG', 'Itabira', 'Fênix', '35901-226',
        'José Hindemburgo Gonçalves', 764, 3),
       ('Küster Alimentos', 'kusteralimentos@gmail.com', '22.548.102/0001-01', 'RS', 'Porto Alegre', 'Moinhos de Vento',
        '90570-001', 'Independência', 789, 4),
       ('Maluceli Bebidas', 'juridico@maluceli.com.br', '09.265.011/0001-21', 'BA', 'Salvador', 'Pelourinho',
        '40026-270', 'do Tijolo', 456, 2);

-- Dados de telefone de empresa
INSERT INTO telefone_empresa (telefone, cod_empresa)
VALUES ('(11) 96154-4521', 1),
       ('(66) 95112-8554', 2),
       ('(66) 94451-8955', 2),
       ('(51) 91215-8887', 4);

-- Dados de empregado
INSERT INTO empregado (nome, sobrenome, cpf, email, telefone_empregado, cargo, tipo, uf, cidade, bairro, cep, rua,
                       numero, cod_empresa, senha)
VALUES ('Ricardo', 'Estrella', '551.888.022-89', 'ringo_estrella@gmail.com', '(11) 96139-4309', 'Operário', 'OPERÁRIO', 'SP',
        'São Paulo', 'Freguesia do Ó', '02910-055', 'Balsa', 123, 1, ENCODE(digest('1234567890', 'sha256'), 'hex')),
       ('João', 'Lino', '382.222.125-87', 'john.lino@aragao5.com.br', '(66) 98455-1122', 'Gerente de Produção',
        'GESTOR', 'MT', 'Feliz Natal', 'Centro', '78885-000', 'Maravilha', 10, 2, ENCODE(digest('MinhaSenha', 'sha256'), 'hex')),
       ('Jorge', 'Hélio', '026.198.544-00', 'jorge_helio@cereshaume.com', '(31) 98744-7788', 'Operário',
        'OPERÁRIO', 'MG', 'Itabira', 'Fênix', '35901-226', 'Mares', 50, 3, ENCODE(digest('Jonses', 'sha256'), 'hex')),
       ('Paulo', 'Lobato', '455.888.542-77', 'paulomclobato@kusteralimentos.com', '(51) 99670-8452', 'Diretor Geral',
        'GESTOR', 'RS', 'Porto Alegre', 'Moinhos de Vento', '90510-040', 'Hilário Ribeiro', 252, 4, ENCODE(digest('6363636!', 'sha256'), 'hex')),
       ('Caio Venceslau', 'Cunha', '546.759.412-88', 'caio.cunha@maluceli.com.br', '(71) 94026-9445',
        'Auxiliar de Produção', 'OPERÁRIO', 'BA', 'Salvador', 'Pelourinho', '40026-270', 'Dna. Amália Chinen', 277, 5, ENCODE(digest('BalticASDFGHJ', 'sha256'), 'hex'));

-- Dados de motivo
INSERT INTO motivo (nome, descricao)
VALUES ('Dano no transporte', 'A embalagem foi danificada durante o transporte interno ou externo'),
       ('Vedação incorreta', 'A tampa ou lacre não foi selado corretamente'),
       ('Rótulo errado', 'O rótulo impresso não corresponde ao conteúdo ou lote correto'),
       ('Superaquecimento', 'A embalagem foi danificada por excesso de calor'),
       ('Excesso de material', 'Houve uso de material acima do necessárip'),
       ('Falha na linha', 'Ocorreu uma falha mecânica na linha de enchimento automático'),
       ('Contaminação', 'Resíduos de produtos anteriores na embalagem'),
       ('Armazenamento incorreto', 'A embalagem foi exposta a condições inadequadas antes da entrega'),
       ('Devolução de cliente', 'O cliente devolveu o produto por falhas visuais na embalagem'),
       ('Outro', 'Outro motivo não especificado');

-- Dados de embalagem
INSERT INTO embalagem (nome, tipo, valor_kg)
VALUES ('Plástico PET', 'Plástico', 1.20),
       ('Garrafa de Refrigerante', 'Vidro', 0.48),
       ('Lata de alumínio', 'Metal', 11.4),
       ('Saco de Lixo 50L', 'Plástico', 4.1),
       ('Caixa de Papelão Média', 'Papel', 3.2);

-- Dados de mídia
INSERT INTO midia (caminho_arquivo)
VALUES ('C:\Users\jmax\Pictures\Camera Roll\embalagens.jpg'),
       ('C:\Users\aragao\Pictures\Camera Roll\descarte.jpg'),
       ('C:\Users\cereshaume\Pictures\Camera Roll\embalagem_danificada.png'),
       ('C:\Users\kusteralimentos\Pictures\Camera Roll\garrafa.jpg');

-- Dados de descarte
INSERT INTO descarte (descarte_kg, custo_estimado, observacao, cod_embalagem, cod_motivo, cod_empregado, cod_midia)
VALUES (2, 2.4, NULL, 1, 1, 1, NULL),
       (3.23, 36.82, 'Estavam sujas com resíduos estranhos', 3, 10, 3, 2),
       (5, 2.4, NULL, 2, 4, 5, NULL);