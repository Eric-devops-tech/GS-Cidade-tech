-- ============================================================================
-- PROJETO: Cidade Tech - Consultas e Acompanhamento de Decisões Comunitárias
-- DISCIPLINA: Mastering Relational and Non-Relational Database
-- ENTREGA: 05_plsql_stored_procedures.sql
-- DESCRIÇÃO: Dois Procedimentos Armazenados (Stored Procedures):
--            1) PRC_REGISTRAR_VOTO (Procedimento de Operação / DML Transacional)
--            2) PRC_APURAR_CONSULTA (Procedimento de Consulta e Processamento de Decisão)
-- AUTORES: Kayque Duarte (RM 567980), Eric Maciel (RM 567398), Gabriel Correa Souza (RM 567903)
-- TURMA: 2TDSPB
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. PROCEDIMENTO DE OPERAÇÃO: PRC_REGISTRAR_VOTO
-- Registra o voto de um cidadão com validação de status, regras de unicidade 
-- e atualização atômica do totalizador da consulta.
-- ----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_REGISTRAR_VOTO (
    p_id_consulta   IN  NUMBER,
    p_id_usuario    IN  NUMBER,
    p_opcao_voto    IN  VARCHAR2,
    p_codigo_recibo OUT VARCHAR2
) IS
    v_status_consulta   TB_CT_CONSULTA.status%TYPE;
    v_qtd_votos_exist   NUMBER := 0;
    v_opcao_formatada   VARCHAR2(15);
    v_novo_recibo       VARCHAR2(64);
BEGIN
    v_opcao_formatada := UPPER(TRIM(p_opcao_voto));

    -- Validação 1: Opção de voto válida
    IF v_opcao_formatada NOT IN ('FAVOR', 'CONTRA', 'ABSTENCAO') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Opção de voto inválida. Escolha FAVOR, CONTRA ou ABSTENCAO.');
    END IF;

    -- Validação 2: Verificar se a consulta existe e se está ABERTA
    BEGIN
        SELECT status
          INTO v_status_consulta
          FROM TB_CT_CONSULTA
         WHERE id_consulta = p_id_consulta;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'Consulta pública com ID ' || p_id_consulta || ' não encontrada.');
    END;

    IF v_status_consulta != 'ABERTA' THEN
        RAISE_APPLICATION_ERROR(-20003, 'Votação rejeitada: a consulta está com status ' || v_status_consulta || 
                                        '. Votos só são permitidos em consultas com status ABERTA.');
    END IF;

    -- Validação 3: Verificar se o usuário existe
    DECLARE
        v_dummy NUMBER;
    BEGIN
        SELECT 1 INTO v_dummy FROM TB_CT_USUARIO WHERE id_usuario = p_id_usuario;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20004, 'Usuário com ID ' || p_id_usuario || ' não encontrado no sistema.');
    END;

    -- Validação 4: Regra de Negócio - Voto Único por morador por consulta
    SELECT COUNT(*)
      INTO v_qtd_votos_exist
      FROM TB_CT_VOTO
     WHERE id_consulta = p_id_consulta
       AND id_usuario  = p_id_usuario;

    IF v_qtd_votos_exist > 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Voto duplicado detectado: o usuário já registrou voto nesta consulta.');
    END IF;

    -- Geração de recibo pseudo-hash único para auditoria do cidadão
    v_novo_recibo := 'REC-C' || p_id_consulta || '-U' || p_id_usuario || '-' || 
                     TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS');

    -- Inserção do voto
    INSERT INTO TB_CT_VOTO (
        id_consulta,
        id_usuario,
        opcao_voto,
        codigo_recibo,
        data_voto
    ) VALUES (
        p_id_consulta,
        p_id_usuario,
        v_opcao_formatada,
        v_novo_recibo,
        SYSDATE
    );

    -- Atualização atômica do totalizador na consulta
    UPDATE TB_CT_CONSULTA
       SET total_votos = total_votos + 1
     WHERE id_consulta = p_id_consulta;

    p_codigo_recibo := v_novo_recibo;
    
    DBMS_OUTPUT.PUT_LINE('>> SUCESSO: Voto registrado com sucesso na Consulta #' || p_id_consulta || 
                         '! Recibo gerado: ' || p_codigo_recibo);
END PRC_REGISTRAR_VOTO;
/

-- ----------------------------------------------------------------------------
-- 2. PROCEDIMENTO DE CONSULTA / PROCESSAMENTO: PRC_APURAR_CONSULTA
-- Realiza a apuração detalhada dos votos, atualiza o resultado oficial 
-- e gera a certidão de apuração comunitária.
-- ----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PRC_APURAR_CONSULTA (
    p_id_consulta       IN  NUMBER,
    p_resultado_final   OUT VARCHAR2,
    p_total_apurado     OUT NUMBER
) IS
    v_titulo            TB_CT_CONSULTA.titulo%TYPE;
    v_bairro            TB_CT_CONSULTA.bairro_alvo%TYPE;
    v_status_atual      TB_CT_CONSULTA.status%TYPE;
    v_tema              TB_CT_TEMA.nome_tema%TYPE;
    
    v_votos_favor       NUMBER := 0;
    v_votos_contra      NUMBER := 0;
    v_votos_abstencao   NUMBER := 0;
    v_perc_favor        NUMBER(5,2) := 0;
    v_perc_contra       NUMBER(5,2) := 0;
    v_resultado         VARCHAR2(50);
BEGIN
    -- 1. Obter dados cadastrais da consulta
    BEGIN
        SELECT c.titulo, c.bairro_alvo, c.status, t.nome_tema
          INTO v_titulo, v_bairro, v_status_atual, v_tema
          FROM TB_CT_CONSULTA c
          JOIN TB_CT_TEMA t ON c.id_tema = t.id_tema
         WHERE c.id_consulta = p_id_consulta;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20010, 'Consulta pública com ID ' || p_id_consulta || ' não encontrada para apuração.');
    END;

    -- 2. Totalização analítica dos votos
    SELECT COUNT(*),
           NVL(SUM(CASE WHEN opcao_voto = 'FAVOR' THEN 1 ELSE 0 END), 0),
           NVL(SUM(CASE WHEN opcao_voto = 'CONTRA' THEN 1 ELSE 0 END), 0),
           NVL(SUM(CASE WHEN opcao_voto = 'ABSTENCAO' THEN 1 ELSE 0 END), 0)
      INTO p_total_apurado,
           v_votos_favor,
           v_votos_contra,
           v_votos_abstencao
      FROM TB_CT_VOTO
     WHERE id_consulta = p_id_consulta;

    -- 3. Definição do resultado com base em percentual
    IF p_total_apurado = 0 THEN
        v_resultado := 'INCONCLUSIVA (SEM VOTOS)';
    ELSE
        v_perc_favor  := ROUND((v_votos_favor / p_total_apurado) * 100, 2);
        v_perc_contra := ROUND((v_votos_contra / p_total_apurado) * 100, 2);

        IF v_perc_favor > 50.00 THEN
            v_resultado := 'APROVADA';
        ELSIF v_perc_contra > 50.00 THEN
            v_resultado := 'REJEITADA';
        ELSE
            v_resultado := 'INCONCLUSIVA (EMPATE OU MAIORIA ABSTENÇÃO)';
        END IF;
    END IF;

    -- 4. Atualização de encerramento e persistência do parecer no banco
    UPDATE TB_CT_CONSULTA
       SET status             = 'ENCERRADA',
           data_fechamento    = NVL(data_fechamento, SYSDATE),
           total_votos        = p_total_apurado,
           resultado_apuracao = v_resultado
     WHERE id_consulta = p_id_consulta;

    p_resultado_final := v_resultado;

    -- 5. Emissão do Relatório Oficial de Apuração
    DBMS_OUTPUT.PUT_LINE('================================================================');
    DBMS_OUTPUT.PUT_LINE('            ATA OFICIAL DE APURAÇÃO - CIDADE TECH               ');
    DBMS_OUTPUT.PUT_LINE('================================================================');
    DBMS_OUTPUT.PUT_LINE('Consulta Pública    : #' || p_id_consulta || ' - ' || v_titulo);
    DBMS_OUTPUT.PUT_LINE('Área Temática       : ' || v_tema);
    DBMS_OUTPUT.PUT_LINE('Bairro Contemplado  : ' || v_bairro);
    DBMS_OUTPUT.PUT_LINE('Data de Encerramento: ' || TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('CONTAGEM DE VOTOS REGISTRADOS:');
    DBMS_OUTPUT.PUT_LINE('  * Total de Moradores Votantes : ' || p_total_apurado);
    DBMS_OUTPUT.PUT_LINE('  * Votos a Favor               : ' || v_votos_favor || ' (' || v_perc_favor || '%)');
    DBMS_OUTPUT.PUT_LINE('  * Votos Contra                : ' || v_votos_contra || ' (' || v_perc_contra || '%)');
    DBMS_OUTPUT.PUT_LINE('  * Votos em Abstenção          : ' || v_votos_abstencao);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('VEREDITO FINAL DA COMUNIDADE: ' || v_resultado);
    DBMS_OUTPUT.PUT_LINE('================================================================');
END PRC_APURAR_CONSULTA;
/
