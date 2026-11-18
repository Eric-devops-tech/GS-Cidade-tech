DECLARE
    v_recibo    VARCHAR2(64);
    v_veredito  VARCHAR2(50);
    v_total     NUMBER;
BEGIN
    -- Reset de segurança da Consulta 2 (permite re-execuções sem erro)
    DELETE FROM TB_CT_VOTO WHERE id_consulta = 2 AND id_usuario = 6;
    UPDATE TB_CT_CONSULTA SET status = 'ABERTA' WHERE id_consulta = 2;

    DBMS_OUTPUT.PUT_LINE('--- TESTE 1: REGISTRO DE VOTO VALIDO ---');
    -- Morador Beatriz vota FAVOR na consulta 2 (Iluminação LED Bela Vista - status ABERTA)
    PRC_REGISTRAR_VOTO(
        p_id_consulta   => 2,
        p_id_usuario    => 6,
        p_opcao_voto    => 'FAVOR',
        p_codigo_recibo => v_recibo
    );

    DBMS_OUTPUT.PUT_LINE('--- TESTE 2: TENTATIVA DE VOTO DUPLICADO ---');
    BEGIN
        -- Tentando votar novamente com a mesma usuária na mesma consulta
        PRC_REGISTRAR_VOTO(
            p_id_consulta   => 2,
            p_id_usuario    => 6,
            p_opcao_voto    => 'CONTRA',
            p_codigo_recibo => v_recibo
        );
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Regra acionada com sucesso: ' || SQLERRM);
    END;

    DBMS_OUTPUT.PUT_LINE('--- TESTE 3: TENTATIVA DE VOTO EM CONSULTA EM RASCUNHO ---');
    BEGIN
        -- Tentando votar na consulta 6 (status RASCUNHO)
        PRC_REGISTRAR_VOTO(
            p_id_consulta   => 6,
            p_id_usuario    => 3,
            p_opcao_voto    => 'FAVOR',
            p_codigo_recibo => v_recibo
        );
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Regra acionada com sucesso: ' || SQLERRM);
    END;

    DBMS_OUTPUT.PUT_LINE('--- TESTE 4: APURACAO OFICIAL DA CONSULTA ---');
    -- Apurando e encerrando a consulta 2
    PRC_APURAR_CONSULTA(
        p_id_consulta     => 2,
        p_resultado_final => v_veredito,
        p_total_apurado   => v_total
    );
END;
/
