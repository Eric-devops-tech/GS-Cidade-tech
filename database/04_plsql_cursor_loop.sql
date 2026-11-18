DECLARE
    -- 1. Declaração do Cursor Explícito com junção de tabelas
    CURSOR cur_consultas IS
        SELECT c.id_consulta,
               c.titulo,
               c.bairro_alvo,
               c.status,
               t.nome_tema,
               u.nome AS nome_gestor,
               NVL(COUNT(v.id_voto), 0) AS total_votos_reais,
               NVL(SUM(CASE WHEN v.opcao_voto = 'FAVOR' THEN 1 ELSE 0 END), 0) AS qtd_favor,
               NVL(SUM(CASE WHEN v.opcao_voto = 'CONTRA' THEN 1 ELSE 0 END), 0) AS qtd_contra
          FROM TB_CT_CONSULTA c
          JOIN TB_CT_TEMA t    ON c.id_tema = t.id_tema
          JOIN TB_CT_USUARIO u ON c.id_gestor = u.id_usuario
          LEFT JOIN TB_CT_VOTO v ON c.id_consulta = v.id_consulta
         GROUP BY c.id_consulta, c.titulo, c.bairro_alvo, c.status, t.nome_tema, u.nome
         ORDER BY c.id_consulta;

    -- Registro para receber o retorno do cursor
    r_consulta cur_consultas%ROWTYPE;

    -- Variáveis acumuladoras para totalizadores
    v_total_consultas  NUMBER := 0;
    v_soma_geral_votos NUMBER := 0;
    v_qtd_abertas      NUMBER := 0;
    v_qtd_encerradas   NUMBER := 0;
    v_qtd_rascunho     NUMBER := 0;
    v_perc_aprovacao   NUMBER(5,1);

BEGIN
    -- 2. Abertura do cursor
    OPEN cur_consultas;

    -- 3. Estrutura de repetição LOOP com FETCH e verificação %NOTFOUND
    LOOP
        FETCH cur_consultas INTO r_consulta;
        EXIT WHEN cur_consultas%NOTFOUND;

        v_total_consultas  := v_total_consultas + 1;
        v_soma_geral_votos := v_soma_geral_votos + r_consulta.total_votos_reais;

        IF r_consulta.status = 'ABERTA' THEN
            v_qtd_abertas := v_qtd_abertas + 1;
        ELSIF r_consulta.status = 'ENCERRADA' THEN
            v_qtd_encerradas := v_qtd_encerradas + 1;
        ELSE
            v_qtd_rascunho := v_qtd_rascunho + 1;
        END IF;

        IF r_consulta.total_votos_reais > 0 THEN
            v_perc_aprovacao := ROUND((r_consulta.qtd_favor / r_consulta.total_votos_reais) * 100, 1);
        ELSE
            v_perc_aprovacao := 0;
        END IF;

        DBMS_OUTPUT.PUT_LINE(
            '[' || LPAD(r_consulta.id_consulta, 2, '0') || '] ' ||
            RPAD(SUBSTR(r_consulta.titulo, 1, 35), 35, ' ') || ' | ' ||
            RPAD(r_consulta.bairro_alvo, 12, ' ') || ' | ' ||
            RPAD(r_consulta.status, 9, ' ') || ' | Votos: ' ||
            LPAD(r_consulta.total_votos_reais, 2, ' ') || ' (Favor: ' || v_perc_aprovacao || '%)'
        );
    END LOOP;

    -- 4. Fechamento do cursor
    CLOSE cur_consultas;

    -- 5. Exibição do sumário final consolidado
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total de Consultas: ' || v_total_consultas || 
                         ' (Abertas: ' || v_qtd_abertas || 
                         ', Encerradas: ' || v_qtd_encerradas || 
                         ', Rascunho: ' || v_qtd_rascunho || ')');
    DBMS_OUTPUT.PUT_LINE('Total Geral de Votos Coletados: ' || v_soma_geral_votos);

-- 6. Tratamento de exceções com garantia de fechamento do cursor
EXCEPTION
    WHEN OTHERS THEN
        IF cur_consultas%ISOPEN THEN
            CLOSE cur_consultas;
        END IF;
        DBMS_OUTPUT.PUT_LINE('ERRO NO CURSOR: ' || SQLERRM);
END;
/
