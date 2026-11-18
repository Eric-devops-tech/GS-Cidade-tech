-- ============================================================================
-- PROJETO: Cidade Tech - Consultas e Acompanhamento de Decisões Comunitárias
-- DISCIPLINA: Mastering Relational and Non-Relational Database
-- ENTREGA: 02_dml_inserts.sql
-- DESCRIÇÃO: Carga inicial de dados de teste (mínimo de 10 registros por tabela)
-- AUTORES: Kayque Duarte (RM 567980), Eric Maciel (RM 567398), Gabriel Correa Souza (RM 567903)
-- TURMA: 2TDSPB
-- ============================================================================

-- Limpeza de registros prévios
DELETE FROM TB_CT_VOTO;
DELETE FROM TB_CT_CONSULTA;
DELETE FROM TB_CT_TEMA;
DELETE FROM TB_CT_USUARIO;

-- ----------------------------------------------------------------------------
-- 1. CARGA: TB_CT_USUARIO (12 usuários: 2 gestores comunitários + 10 cidadãos)
-- ----------------------------------------------------------------------------
INSERT INTO TB_CT_USUARIO (nome, email, senha_hash, papel, bairro, data_cadastro)
VALUES ('Carlos Eduardo Mendes', 'gestor.carlos@cidadetech.org', '$2a$12$K1dZ...gestor1', 'GESTOR', 'Bela Vista', DATE '2026-01-10');

INSERT INTO TB_CT_USUARIO (nome, email, senha_hash, papel, bairro, data_cadastro)
VALUES ('Mariana Guimarães Rocha', 'gestora.mariana@cidadetech.org', '$2a$12$K1dZ...gestor2', 'GESTOR', 'Pinheiros', DATE '2026-01-15');

INSERT INTO TB_CT_USUARIO (nome, email, senha_hash, papel, bairro, data_cadastro)
VALUES ('Eric Maciel', 'eric.maciel@fiap.com.br', '$2a$12$K1dZ...morador1', 'CIDADAO', 'Bela Vista', DATE '2026-02-01');

INSERT INTO TB_CT_USUARIO (nome, email, senha_hash, papel, bairro, data_cadastro)
VALUES ('Kayque Duarte', 'kayque.duarte@fiap.com.br', '$2a$12$K1dZ...morador2', 'CIDADAO', 'Bela Vista', DATE '2026-02-02');

INSERT INTO TB_CT_USUARIO (nome, email, senha_hash, papel, bairro, data_cadastro)
VALUES ('Gabriel Correa Souza', 'gabriel.correa@fiap.com.br', '$2a$12$K1dZ...morador3', 'CIDADAO', 'Pinheiros', DATE '2026-02-03');

INSERT INTO TB_CT_USUARIO (nome, email, senha_hash, papel, bairro, data_cadastro)
VALUES ('Beatriz Lima Santos', 'beatriz.santos@email.com', '$2a$12$K1dZ...morador4', 'CIDADAO', 'Mooca', DATE '2026-02-05');

INSERT INTO TB_CT_USUARIO (nome, email, senha_hash, papel, bairro, data_cadastro)
VALUES ('Lucas Ribeiro Alves', 'lucas.alves@email.com', '$2a$12$K1dZ...morador5', 'CIDADAO', 'Pinheiros', DATE '2026-02-10');

INSERT INTO TB_CT_USUARIO (nome, email, senha_hash, papel, bairro, data_cadastro)
VALUES ('Juliana Ferreira Castro', 'juliana.castro@email.com', '$2a$12$K1dZ...morador6', 'CIDADAO', 'Santana', DATE '2026-02-12');

INSERT INTO TB_CT_USUARIO (nome, email, senha_hash, papel, bairro, data_cadastro)
VALUES ('Rodrigo Nascimento Silva', 'rodrigo.silva@email.com', '$2a$12$K1dZ...morador7', 'CIDADAO', 'Santo Amaro', DATE '2026-02-15');

INSERT INTO TB_CT_USUARIO (nome, email, senha_hash, papel, bairro, data_cadastro)
VALUES ('Fernanda Costa Oliveira', 'fernanda.costa@email.com', '$2a$12$K1dZ...morador8', 'CIDADAO', 'Mooca', DATE '2026-02-18');

INSERT INTO TB_CT_USUARIO (nome, email, senha_hash, papel, bairro, data_cadastro)
VALUES ('Thiago Martins Barbosa', 'thiago.martins@email.com', '$2a$12$K1dZ...morador9', 'CIDADAO', 'Bela Vista', DATE '2026-02-20');

INSERT INTO TB_CT_USUARIO (nome, email, senha_hash, papel, bairro, data_cadastro)
VALUES ('Camila Pires Vieira', 'camila.pires@email.com', '$2a$12$K1dZ...morador10', 'CIDADAO', 'Santo Amaro', DATE '2026-02-22');

-- ----------------------------------------------------------------------------
-- 2. CARGA: TB_CT_TEMA (10 temas de interesse comunitário)
-- ----------------------------------------------------------------------------
INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Mobilidade Urbana', 'Propostas de ciclovias, linhas circulares de micro-ônibus e calçadas acessíveis.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Saúde Comunitária', 'Melhorias em UBS, telemedicina preventiva e campanhas de vacinação local.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Meio Ambiente & Sustentabilidade', 'Hortas comunitárias, reciclagem seletiva e arborização de praças.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Iluminação & Zeladoria', 'Substituição por lâmpadas LED, descarte de entulho e limpeza de galerias pluviais.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Segurança Cidadã', 'Instalação de câmeras integradas, rondas comunitárias e iluminação em becos.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Cultura & Lazer', 'Ocupação de espaços públicos, feiras de produtores locais e cinema ao ar livre.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Educação & Capacitação', 'Polos de inclusão digital, oficinas para jovens e reforço escolar em centros sociais.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Acessibilidade & Inclusão', 'Rampas de acesso, guias táteis e sinalização sonora para pessoas com deficiência.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Esporte Comunitário', 'Revitalização de quadras poliesportivas, academias ao ar livre e pistas de caminhada.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Habitação & Regularização', 'Orientação jurídica comunitária e regularização fundiária de áreas periféricas.', 'S');

-- ----------------------------------------------------------------------------
-- 3. CARGA: TB_CT_CONSULTA (10 consultas com status variados: ABERTA, ENCERRADA, RASCUNHO)
-- ----------------------------------------------------------------------------
-- Consulta 1 (Encerrada - Bela Vista)
INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (
    (SELECT id_tema FROM TB_CT_TEMA WHERE nome_tema = 'Mobilidade Urbana'),
    (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'gestor.carlos@cidadetech.org'),
    'Implantação de Ciclofaixa Conectando a Rua Treze de Maio à Estação',
    'Consulta pública sobre a criação de faixa exclusiva segregada para bicicletas e patinetes.',
    'Bela Vista',
    'ENCERRADA',
    DATE '2026-09-01',
    DATE '2026-09-30',
    6,
    'APROVADA'
);

-- Consulta 2 (Aberta - Bela Vista)
INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (
    (SELECT id_tema FROM TB_CT_TEMA WHERE nome_tema = 'Iluminação & Zeladoria'),
    (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'gestor.carlos@cidadetech.org'),
    'Modernização da Iluminação em LED no Entorno da Praça Dom Orione',
    'Priorização de recursos do orçamento participativo para substituição das lâmpadas de vapor de sódio por LED.',
    'Bela Vista',
    'ABERTA',
    DATE '2026-10-01',
    DATE '2026-11-30',
    4,
    'PENDENTE'
);

-- Consulta 3 (Aberta - Pinheiros)
INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (
    (SELECT id_tema FROM TB_CT_TEMA WHERE nome_tema = 'Meio Ambiente & Sustentabilidade'),
    (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'gestora.mariana@cidadetech.org'),
    'Criação de Horta Comunitária Urbana em Terreno Público Ocioso',
    'Projeto de cultivo orgânico colaborativo administrado pelos próprios moradores com apoio técnico municipal.',
    'Pinheiros',
    'ABERTA',
    DATE '2026-10-15',
    DATE '2026-12-15',
    3,
    'PENDENTE'
);

-- Consulta 4 (Aberta - Mooca)
INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (
    (SELECT id_tema FROM TB_CT_TEMA WHERE nome_tema = 'Cultura & Lazer'),
    (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'gestor.carlos@cidadetech.org'),
    'Feira Noturna de Gastronomia e Artesanato Tradicional na Mooca',
    'Destinação de espaço aos sábados para pequenos comerciantes e artesãos do bairro.',
    'Mooca',
    'ABERTA',
    DATE '2026-10-20',
    DATE '2026-11-25',
    2,
    'PENDENTE'
);

-- Consulta 5 (Encerrada - Santana)
INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (
    (SELECT id_tema FROM TB_CT_TEMA WHERE nome_tema = 'Saúde Comunitária'),
    (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'gestora.mariana@cidadetech.org'),
    'Ampliação do Horário de Atendimento da UBS Santana até as 22h',
    'Consulta para estender a triagem clínica e farmácia para atendimento de trabalhadores noturnos.',
    'Santana',
    'ENCERRADA',
    DATE '2026-08-01',
    DATE '2026-08-31',
    1,
    'APROVADA'
);

-- Consulta 6 (Rascunho - Bela Vista)
INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (
    (SELECT id_tema FROM TB_CT_TEMA WHERE nome_tema = 'Segurança Cidadã'),
    (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'gestor.carlos@cidadetech.org'),
    'Instalação de Totens de Emergência e Câmeras Conectadas ao Batalhão',
    'Pontos de apoio com botão de emergência direto para socorro médico e patrulhamento preventivo.',
    'Bela Vista',
    'RASCUNHO',
    NULL,
    NULL,
    0,
    'PENDENTE'
);

-- Consulta 7 (Rascunho - Pinheiros)
INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (
    (SELECT id_tema FROM TB_CT_TEMA WHERE nome_tema = 'Acessibilidade & Inclusão'),
    (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'gestora.mariana@cidadetech.org'),
    'Requalificação de Calçadas e Rebaixamento de Guias no Eixo Comercial',
    'Plano de acessibilidade universal para idosos, cadeirantes e pessoas com mobilidade reduzida.',
    'Pinheiros',
    'RASCUNHO',
    NULL,
    NULL,
    0,
    'PENDENTE'
);

-- Consulta 8 (Aberta - Santo Amaro)
INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (
    (SELECT id_tema FROM TB_CT_TEMA WHERE nome_tema = 'Esporte Comunitário'),
    (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'gestor.carlos@cidadetech.org'),
    'Reforma Completa do Complexo Esportivo Municipal com Pista de Cooper',
    'Troca de gramado sintético, iluminação solar e instalação de bebedouros acessíveis.',
    'Santo Amaro',
    'ABERTA',
    DATE '2026-11-01',
    DATE '2026-12-01',
    2,
    'PENDENTE'
);

-- Consulta 9 (Aberta - Bela Vista)
INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (
    (SELECT id_tema FROM TB_CT_TEMA WHERE nome_tema = 'Educação & Capacitação'),
    (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'gestor.carlos@cidadetech.org'),
    'Centro de Inclusão Tecnológica e Robótica para Jovens da Rede Pública',
    'Espaço comunitário com computadores e cursos profissionalizantes de programação e dados.',
    'Bela Vista',
    'ABERTA',
    DATE '2026-10-25',
    DATE '2026-11-30',
    0,
    'PENDENTE'
);

-- Consulta 10 (Encerrada - Pinheiros)
INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (
    (SELECT id_tema FROM TB_CT_TEMA WHERE nome_tema = 'Habitação & Regularização'),
    (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'gestora.mariana@cidadetech.org'),
    'Mutirão de Assistência Técnica e Regularização Fundiária Comunitária',
    'Suporte com arquitetos e advogados populares para famílias em áreas de vulnerabilidade.',
    'Pinheiros',
    'ENCERRADA',
    DATE '2026-07-01',
    DATE '2026-07-31',
    2,
    'REJEITADA'
);

-- ----------------------------------------------------------------------------
-- 4. CARGA: TB_CT_VOTO (18 votos de teste com hashes simulados de recibo)
-- ----------------------------------------------------------------------------
-- Votos para Consulta 1 (Encerrada - Ciclofaixa Bela Vista - 6 votos: 5 FAVOR, 1 CONTRA)
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (1, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'eric.maciel@fiap.com.br'), 'FAVOR', 'REC-C1-U01-A9F8E12', DATE '2026-09-05');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (1, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'kayque.duarte@fiap.com.br'), 'FAVOR', 'REC-C1-U02-B8E7D34', DATE '2026-09-06');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (1, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'thiago.martins@email.com'), 'FAVOR', 'REC-C1-U09-C7D6C56', DATE '2026-09-10');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (1, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'beatriz.santos@email.com'), 'CONTRA', 'REC-C1-U04-D6C5B78', DATE '2026-09-12');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (1, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'lucas.alves@email.com'), 'FAVOR', 'REC-C1-U05-E5B4A90', DATE '2026-09-15');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (1, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'fernanda.costa@email.com'), 'FAVOR', 'REC-C1-U08-F4A3912', DATE '2026-09-20');

-- Votos para Consulta 2 (Aberta - Iluminação LED Bela Vista - 4 votos: 3 FAVOR, 1 ABSTENCAO)
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (2, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'eric.maciel@fiap.com.br'), 'FAVOR', 'REC-C2-U01-1122334', DATE '2026-10-02');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (2, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'kayque.duarte@fiap.com.br'), 'FAVOR', 'REC-C2-U02-2233445', DATE '2026-10-03');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (2, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'thiago.martins@email.com'), 'ABSTENCAO', 'REC-C2-U09-3344556', DATE '2026-10-05');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (2, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'lucas.alves@email.com'), 'FAVOR', 'REC-C2-U05-4455667', DATE '2026-10-08');

-- Votos para Consulta 3 (Aberta - Horta Comunitária Pinheiros - 3 votos: 2 FAVOR, 1 CONTRA)
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (3, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'gabriel.correa@fiap.com.br'), 'FAVOR', 'REC-C3-U03-5566778', DATE '2026-10-16');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (3, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'lucas.alves@email.com'), 'FAVOR', 'REC-C3-U05-6677889', DATE '2026-10-18');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (3, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'juliana.castro@email.com'), 'CONTRA', 'REC-C3-U06-7788990', DATE '2026-10-20');

-- Votos para Consulta 4 (Aberta - Feira Mooca - 2 votos: 2 FAVOR)
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (4, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'beatriz.santos@email.com'), 'FAVOR', 'REC-C4-U04-8899001', DATE '2026-10-22');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (4, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'fernanda.costa@email.com'), 'FAVOR', 'REC-C4-U08-9900112', DATE '2026-10-23');

-- Votos para Consulta 5 (Encerrada - UBS Santana - 1 voto: 1 FAVOR)
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (5, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'juliana.castro@email.com'), 'FAVOR', 'REC-C5-U06-0011223', DATE '2026-08-15');

-- Votos para Consulta 8 (Aberta - Reforma Centro Esportivo Santo Amaro - 2 votos: 1 FAVOR, 1 CONTRA)
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (8, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'rodrigo.silva@email.com'), 'FAVOR', 'REC-C8-U07-1234567', DATE '2026-11-05');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (8, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'camila.pires@email.com'), 'CONTRA', 'REC-C8-U10-2345678', DATE '2026-11-06');

-- Votos para Consulta 10 (Encerrada - Mutirão Pinheiros - 2 votos: 2 CONTRA)
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (10, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'gabriel.correa@fiap.com.br'), 'CONTRA', 'REC-C10-U03-3456789', DATE '2026-07-10');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (10, (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'lucas.alves@email.com'), 'CONTRA', 'REC-C10-U05-4567890', DATE '2026-07-12');

COMMIT;
