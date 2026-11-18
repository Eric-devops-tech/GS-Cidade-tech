-- 1. Limpeza de registros prévios
DELETE FROM TB_CT_VOTO;
DELETE FROM TB_CT_CONSULTA;
DELETE FROM TB_CT_TEMA;
DELETE FROM TB_CT_USUARIO;

-- 2. Carga de Usuários (gestores comunitários e cidadãos)
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

-- 3. Carga de Temas de interesse comunitário
INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Mobilidade Urbana', 'Propostas de ciclovias, micro-ônibus e calçadas acessíveis.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Saúde Comunitária', 'Melhorias em UBS e campanhas de saúde preventiva.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Meio Ambiente & Sustentabilidade', 'Hortas comunitárias, reciclagem e praças verdes.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Iluminação & Zeladoria', 'Lâmpadas LED, descarte de entulho e limpeza de bueiros.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Segurança Cidadã', 'Câmeras integradas, rondas e iluminação de pontos escuros.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Cultura & Lazer', 'Ocupação de espaços públicos e feiras locais.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Educação & Capacitação', 'Inclusão digital, cursos e reforço escolar.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Acessibilidade & Inclusão', 'Rampas de acesso e piso tátil para pessoas com deficiência.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Esporte Comunitário', 'Revitalização de quadras e academias ao ar livre.', 'S');

INSERT INTO TB_CT_TEMA (nome_tema, descricao, status_ativo)
VALUES ('Habitação & Regularização', 'Orientação jurídica e apoio em regularização fundiária.', 'S');

-- 4. Carga de Consultas Públicas
INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (1, 1, 'Implantação de Ciclofaixa Conectando a Treze de Maio à Estação', 'Faixa exclusiva segregada para bicicletas e patinetes.', 'Bela Vista', 'ENCERRADA', DATE '2026-09-01', DATE '2026-09-30', 6, 'APROVADA');

INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (4, 1, 'Modernização da Iluminação em LED no Entorno da Praça Dom Orione', 'Substituição das lâmpadas antigas por LED inteligente.', 'Bela Vista', 'ABERTA', DATE '2026-10-01', DATE '2026-11-30', 4, 'PENDENTE');

INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (3, 2, 'Criação de Horta Comunitária Urbana em Terreno Ocioso', 'Cultivo orgânico colaborativo cuidado pelos moradores.', 'Pinheiros', 'ABERTA', DATE '2026-10-15', DATE '2026-12-15', 3, 'PENDENTE');

INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (6, 1, 'Feira Noturna de Gastronomia e Artesanato na Mooca', 'Espaço aos sábados para pequenos comerciantes locais.', 'Mooca', 'ABERTA', DATE '2026-10-20', DATE '2026-11-25', 2, 'PENDENTE');

INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (2, 2, 'Ampliação do Horário de Atendimento da UBS Santana até as 22h', 'Triagem clínica e farmácia para trabalhadores noturnos.', 'Santana', 'ENCERRADA', DATE '2026-08-01', DATE '2026-08-31', 1, 'APROVADA');

INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (5, 1, 'Instalação de Totens de Emergência Integrados ao Batalhão', 'Botão de emergência direto para socorro e segurança.', 'Bela Vista', 'RASCUNHO', NULL, NULL, 0, 'PENDENTE');

INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (8, 2, 'Requalificação de Calçadas no Eixo Comercial de Pinheiros', 'Acessibilidade universal para idosos e cadeirantes.', 'Pinheiros', 'RASCUNHO', NULL, NULL, 0, 'PENDENTE');

INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (9, 1, 'Reforma Completa do Complexo Esportivo de Santo Amaro', 'Gramado sintético e pista de caminhada revitalizados.', 'Santo Amaro', 'ABERTA', DATE '2026-11-01', DATE '2026-12-01', 2, 'PENDENTE');

INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (7, 1, 'Centro de Inclusão Tecnológica e Robótica para Jovens', 'Espaço comunitário com computadores e cursos técnicos.', 'Bela Vista', 'ABERTA', DATE '2026-10-25', DATE '2026-11-30', 0, 'PENDENTE');

INSERT INTO TB_CT_CONSULTA (id_tema, id_gestor, titulo, descricao, bairro_alvo, status, data_abertura, data_fechamento, total_votos, resultado_apuracao)
VALUES (10, 2, 'Mutirão de Assistência Técnica e Regularização Fundiária', 'Apoio técnico para famílias em áreas de vulnerabilidade.', 'Pinheiros', 'ENCERRADA', DATE '2026-07-01', DATE '2026-07-31', 2, 'REJEITADA');

-- 5. Carga de Votos Registrados
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (1, 3, 'FAVOR', 'REC-C1-U01-A9F8E12', DATE '2026-09-05');
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (1, 4, 'FAVOR', 'REC-C1-U02-B8E7D34', DATE '2026-09-06');
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (1, 11, 'FAVOR', 'REC-C1-U09-C7D6C56', DATE '2026-09-10');
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (1, 6, 'CONTRA', 'REC-C1-U04-D6C5B78', DATE '2026-09-12');
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (1, 7, 'FAVOR', 'REC-C1-U05-E5B4A90', DATE '2026-09-15');
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (1, 10, 'FAVOR', 'REC-C1-U08-F4A3912', DATE '2026-09-20');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (2, 3, 'FAVOR', 'REC-C2-U01-1122334', DATE '2026-10-02');
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (2, 4, 'FAVOR', 'REC-C2-U02-2233445', DATE '2026-10-03');
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (2, 11, 'ABSTENCAO', 'REC-C2-U09-3344556', DATE '2026-10-05');
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (2, 7, 'FAVOR', 'REC-C2-U05-4455667', DATE '2026-10-08');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (3, 5, 'FAVOR', 'REC-C3-U03-5566778', DATE '2026-10-16');
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (3, 7, 'FAVOR', 'REC-C3-U05-6677889', DATE '2026-10-18');
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (3, 8, 'CONTRA', 'REC-C3-U06-7788990', DATE '2026-10-20');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (4, 6, 'FAVOR', 'REC-C4-U04-8899001', DATE '2026-10-22');
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (4, 10, 'FAVOR', 'REC-C4-U08-9900112', DATE '2026-10-23');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (5, 8, 'FAVOR', 'REC-C5-U06-0011223', DATE '2026-08-15');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (8, 9, 'FAVOR', 'REC-C8-U07-1234567', DATE '2026-11-05');
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (8, 12, 'CONTRA', 'REC-C8-U10-2345678', DATE '2026-11-06');

INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (10, 5, 'CONTRA', 'REC-C10-U03-3456789', DATE '2026-07-10');
INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
VALUES (10, 7, 'CONTRA', 'REC-C10-U05-4567890', DATE '2026-07-12');

COMMIT;
