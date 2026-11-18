-- 1. Procedure de Operação: Registra voto com validações e recibo
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

    -- Validação: Opção de voto permitida
    IF v_opcao_formatada NOT IN ('FAVOR', 'CONTRA', 'ABSTENCAO') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Opcao invalida. Escolha FAVOR, CONTRA ou ABSTENCAO.');
    END IF;

    -- Validação: Consulta deve existir e estar com status ABERTA
    BEGIN
        SELECT status INTO v_status_consulta 
          FROM TB_CT_CONSULTA 
         WHERE id_consulta = p_id_consulta;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'Consulta #' || p_id_consulta || ' nao encontrada.');
    END;

    IF v_status_consulta != 'ABERTA' THEN
        RAISE_APPLICATION_ERROR(-20003, 'Voto rejeitado: consulta ' || v_status_consulta || '. Deve estar ABERTA.');
    END IF;

    -- Validação: Usuário deve existir no cadastro
    DECLARE
        v_dummy NUMBER;
    BEGIN
        SELECT 1 INTO v_dummy FROM TB_CT_USUARIO WHERE id_usuario = p_id_usuario;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20004, 'Usuario #' || p_id_usuario || ' nao encontrado.');
    END;

    -- Validação: Regra de Voto Único (impede voto duplicado pelo mesmo morador)
    SELECT COUNT(*) INTO v_qtd_votos_exist 
      FROM TB_CT_VOTO
     WHERE id_consulta = p_id_consulta 
       AND id_usuario = p_id_usuario;

    IF v_qtd_votos_exist > 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Voto duplicado: este morador ja votou nesta consulta.');
    END IF;

    -- Geração do recibo único para auditoria do cidadão
    v_novo_recibo := 'REC-C' || p_id_consulta || '-U' || p_id_usuario || '-' || TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS');

    -- Inserção do voto
    INSERT INTO TB_CT_VOTO (id_consulta, id_usuario, opcao_voto, codigo_recibo, data_voto)
    VALUES (p_id_consulta, p_id_usuario, v_opcao_formatada, v_novo_recibo, SYSDATE);

    -- Incremento atômico no contador de votos da consulta
    UPDATE TB_CT_CONSULTA 
       SET total_votos = total_votos + 1 
     WHERE id_consulta = p_id_consulta;

    p_codigo_recibo := v_novo_recibo;
    DBMS_OUTPUT.PUT_LINE('>> Voto computado com sucesso! Recibo: ' || p_codigo_recibo);
END PRC_REGISTRAR_VOTO;
/

-- 2. Procedure de Consulta/Processamento: Apura os votos e oficializa o encerramento
CREATE OR REPLACE PROCEDURE PRC_APURAR_CONSULTA (
    p_id_consulta       IN  NUMBER,
    p_resultado_final   OUT VARCHAR2,
    p_total_apurado     OUT NUMBER
) IS
    v_titulo            TB_CT_CONSULTA.titulo%TYPE;
    v_bairro            TB_CT_CONSULTA.bairro_alvo%TYPE;
    v_tema              TB_CT_TEMA.nome_tema%TYPE;
    v_votos_favor       NUMBER := 0;
    v_votos_contra      NUMBER := 0;
    v_votos_abstencao   NUMBER := 0;
    v_perc_favor        NUMBER(5,2) := 0;
    v_perc_contra       NUMBER(5,2) := 0;
    v_resultado         VARCHAR2(50);
BEGIN
    -- Busca dados cadastrais da consulta
    BEGIN
        SELECT c.titulo, c.bairro_alvo, t.nome_tema
          INTO v_titulo, v_bairro, v_tema
          FROM TB_CT_CONSULTA c
          JOIN TB_CT_TEMA t ON c.id_tema = t.id_tema
         WHERE c.id_consulta = p_id_consulta;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20010, 'Consulta publica #' || p_id_consulta || ' nao encontrada.');
    END;

    -- Totalização dos votos por opção
    SELECT COUNT(*),
           NVL(SUM(CASE WHEN opcao_voto = 'FAVOR' THEN 1 ELSE 0 END), 0),
           NVL(SUM(CASE WHEN opcao_voto = 'CONTRA' THEN 1 ELSE 0 END), 0),
           NVL(SUM(CASE WHEN opcao_voto = 'ABSTENCAO' THEN 1 ELSE 0 END), 0)
      INTO p_total_apurado, v_votos_favor, v_votos_contra, v_votos_abstencao
      FROM TB_CT_VOTO
     WHERE id_consulta = p_id_consulta;

    -- Regra de decisão do resultado oficial
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
            v_resultado := 'INCONCLUSIVA (EMPATE OU MAIORIA ABSTENCAO)';
        END IF;
    END IF;

    -- Atualiza consulta para status ENCERRADA com o resultado gravado
    UPDATE TB_CT_CONSULTA
       SET status             = 'ENCERRADA',
           data_fechamento    = NVL(data_fechamento, SYSDATE),
           total_votos        = p_total_apurado,
           resultado_apuracao = v_resultado
     WHERE id_consulta = p_id_consulta;

    p_resultado_final := v_resultado;

    -- Emissão da ata oficial de apuração
    DBMS_OUTPUT.PUT_LINE('================================================================');
    DBMS_OUTPUT.PUT_LINE('ATA DE APURACAO - CIDADE TECH');
    DBMS_OUTPUT.PUT_LINE('Consulta: #' || p_id_consulta || ' - ' || v_titulo);
    DBMS_OUTPUT.PUT_LINE('Tema: ' || v_tema || ' | Bairro: ' || v_bairro);
    DBMS_OUTPUT.PUT_LINE('Total Votos: ' || p_total_apurado);
    DBMS_OUTPUT.PUT_LINE('Favor: ' || v_votos_favor || ' (' || v_perc_favor || '%) | Contra: ' || v_votos_contra || ' (' || v_perc_contra || '%) | Abstencao: ' || v_votos_abstencao);
    DBMS_OUTPUT.PUT_LINE('Resultado: ' || v_resultado);
    DBMS_OUTPUT.PUT_LINE('================================================================');
END PRC_APURAR_CONSULTA;
/
