-- ============================================================================
-- PROJETO: Cidade Tech - Consultas e Acompanhamento de Decisões Comunitárias
-- DISCIPLINA: Mastering Relational and Non-Relational Database
-- ENTREGA: 06_exec_tests_evidence.sql
-- DESCRIÇÃO: Bateria de testes e evidências de execução dos componentes PL/SQL.
-- AUTORES: Kayque Duarte (RM 567980), Eric Maciel (RM 567398), Gabriel Correa Souza (RM 567903)
-- TURMA: 2TDSPB
-- ============================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED;

PROMPT ------------------------------------------------------------------------
PROMPT TESTE 1: REGISTRO DE VOTO VÁLIDO VIA PROCEDURE OPERACIONAL
PROMPT ------------------------------------------------------------------------
DECLARE
    v_recibo VARCHAR2(64);
BEGIN
    -- Morador Beatriz Santos vota a FAVOR na Consulta 2 (Iluminação Bela Vista - ABERTA)
    PRC_REGISTRAR_VOTO(
        p_id_consulta   => 2,
        p_id_usuario    => (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'beatriz.santos@email.com'),
        p_opcao_voto    => 'FAVOR',
        p_codigo_recibo => v_recibo
    );
    DBMS_OUTPUT.PUT_LINE('Recibo retornado pela procedure: ' || v_recibo);
END;
/

PROMPT ------------------------------------------------------------------------
PROMPT TESTE 2: TENTATIVA DE VOTO DUPLICADO (DEVE DISPARAR REGRA DE NEGÓCIO)
PROMPT ------------------------------------------------------------------------
DECLARE
    v_recibo VARCHAR2(64);
BEGIN
    -- Tentando votar novamente com a mesma usuária na mesma consulta
    PRC_REGISTRAR_VOTO(
        p_id_consulta   => 2,
        p_id_usuario    => (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'beatriz.santos@email.com'),
        p_opcao_voto    => 'CONTRA',
        p_codigo_recibo => v_recibo
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Exceção capturada com sucesso: ' || SQLERRM);
END;
/

PROMPT ------------------------------------------------------------------------
PROMPT TESTE 3: TENTATIVA DE VOTO EM CONSULTA EM RASCUNHO (NÃO ABERTA)
PROMPT ------------------------------------------------------------------------
DECLARE
    v_recibo VARCHAR2(64);
BEGIN
    -- Tentando votar na Consulta 6 que está com status 'RASCUNHO'
    PRC_REGISTRAR_VOTO(
        p_id_consulta   => 6,
        p_id_usuario    => (SELECT id_usuario FROM TB_CT_USUARIO WHERE email = 'eric.maciel@fiap.com.br'),
        p_opcao_voto    => 'FAVOR',
        p_codigo_recibo => v_recibo
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Exceção capturada com sucesso: ' || SQLERRM);
END;
/

PROMPT ------------------------------------------------------------------------
PROMPT TESTE 4: APURAÇÃO OFICIAL VIA PROCEDURE DE PROCESSAMENTO
PROMPT ------------------------------------------------------------------------
DECLARE
    v_resultado VARCHAR2(50);
    v_total     NUMBER;
BEGIN
    -- Apuração da Consulta 2 (Iluminação LED Bela Vista)
    PRC_APURAR_CONSULTA(
        p_id_consulta     => 2,
        p_resultado_final => v_resultado,
        p_total_apurado   => v_total
    );
    DBMS_OUTPUT.PUT_LINE('Retorno final da procedure -> Veredito: ' || v_resultado || ' | Total apurado: ' || v_total);
END;
/

PROMPT ------------------------------------------------------------------------
PROMPT TESTE 5: EXECUÇÃO DO BLOCO ANÔNIMO DE CLASSIFICAÇÃO COM IF/ELSIF/ELSE
PROMPT ------------------------------------------------------------------------
@@03_plsql_anonymous_block.sql

PROMPT ------------------------------------------------------------------------
PROMPT TESTE 6: EXECUÇÃO DO CURSOR EXPLÍCITO COM ESTRUTURA DE REPETIÇÃO
PROMPT ------------------------------------------------------------------------
@@04_plsql_cursor_loop.sql
