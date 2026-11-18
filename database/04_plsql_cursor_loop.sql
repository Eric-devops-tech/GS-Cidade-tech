-- ============================================================================
-- PROJETO: Cidade Tech - Consultas e Acompanhamento de Decisões Comunitárias
-- DISCIPLINA: Mastering Relational and Non-Relational Database
-- ENTREGA: 04_plsql_cursor_loop.sql
-- DESCRIÇÃO: Cursor explícito para percorrer e apresentar dados do projeto 
--            com estrutura de repetição (OPEN, FETCH, LOOP, EXIT WHEN %NOTFOUND, CLOSE).
-- AUTORES: Kayque Duarte (RM 567980), Eric Maciel (RM 567398), Gabriel Correa Souza (RM 567903)
-- TURMA: 2TDSPB
-- ============================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED;

DECLARE
    -- 1. Declaração do Cursor Explícito com junção das tabelas centrais
    CURSOR cur_consultas IS
        SELECT c.id_consulta,
               c.titulo,
               c.bairro_alvo,
               c.status,
               c.data_abertura,
               c.data_fechamento,
               t.nome_tema,
               u.nome AS nome_gestor,
               NVL(COUNT(v.id_voto), 0) AS total_votos_reais,
               NVL(SUM(CASE WHEN v.opcao_voto = 'FAVOR' THEN 1 ELSE 0 END), 0) AS qtd_favor,
               NVL(SUM(CASE WHEN v.opcao_voto = 'CONTRA' THEN 1 ELSE 0 END), 0) AS qtd_contra
          FROM TB_CT_CONSULTA c
          JOIN TB_CT_TEMA t    ON c.id_tema = t.id_tema
          JOIN TB_CT_USUARIO u ON c.id_gestor = u.id_usuario
          LEFT JOIN TB_CT_VOTO v ON c.id_consulta = v.id_consulta
         GROUP BY c.id_consulta,
                  c.titulo,
                  c.bairro_alvo,
                  c.status,
                  c.data_abertura,
                  c.data_fechamento,
                  t.nome_tema,
                  u.nome
         ORDER BY c.id_consulta;

    -- Variável do tipo registro para receber o FETCH do cursor
    r_consulta cur_consultas%ROWTYPE;

    -- Variáveis acumuladoras para o sumário executivo
    v_total_consultas       NUMBER := 0;
    v_soma_geral_votos      NUMBER := 0;
    v_qtd_abertas           NUMBER := 0;
    v_qtd_encerradas        NUMBER := 0;
    v_qtd_rascunho          NUMBER := 0;
    v_perc_aprovacao        NUMBER(5,2);

BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================================================================');
    DBMS_OUTPUT.PUT_LINE('              RELATÓRIO GERAL DE CONSULTAS COMUNITÁRIAS - CIDADE TECH                   ');
    DBMS_OUTPUT.PUT_LINE('========================================================================================');
    
    -- 2. Abertura explícita do cursor
    OPEN cur_consultas;

    -- 3. Estrutura de repetição clássica LOOP com FETCH e EXIT WHEN %NOTFOUND
    LOOP
        FETCH cur_consultas INTO r_consulta;
        EXIT WHEN cur_consultas%NOTFOUND;

        -- Contabilizadores
        v_total_consultas  := v_total_consultas + 1;
        v_soma_geral_votos := v_soma_geral_votos + r_consulta.total_votos_reais;

        IF r_consulta.status = 'ABERTA' THEN
            v_qtd_abertas := v_qtd_abertas + 1;
        ELSIF r_consulta.status = 'ENCERRADA' THEN
            v_qtd_encerradas := v_qtd_encerradas + 1;
        ELSE
            v_qtd_rascunho := v_qtd_rascunho + 1;
        END IF;

        -- Cálculo percentual
        IF r_consulta.total_votos_reais > 0 THEN
            v_perc_aprovacao := ROUND((r_consulta.qtd_favor / r_consulta.total_votos_reais) * 100, 1);
        ELSE
            v_perc_aprovacao := 0;
        END IF;

        -- Impressão de cada registro percorrido
        DBMS_OUTPUT.PUT_LINE(
            '[' || LPAD(r_consulta.id_consulta, 2, '0') || '] ' ||
            RPAD(SUBSTR(r_consulta.titulo, 1, 40), 40, ' ') || ' | ' ||
            RPAD(r_consulta.bairro_alvo, 12, ' ') || ' | ' ||
            RPAD(r_consulta.status, 9, ' ') || ' | Votos: ' ||
            LPAD(r_consulta.total_votos_reais, 3, ' ') || ' (Favor: ' ||
            LPAD(v_perc_aprovacao, 5, ' ') || '%)'
        );
    END LOOP;

    -- 4. Fechamento explícito do cursor
    CLOSE cur_consultas;

    -- 5. Exibição do resumo final consolidado
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('SUMÁRIO GERAL DE AUDITORIA DO PROJETO:');
    DBMS_OUTPUT.PUT_LINE('  * Total de Consultas Cadastradas : ' || v_total_consultas);
    DBMS_OUTPUT.PUT_LINE('  * Consultas Abertas (em votação) : ' || v_qtd_abertas);
    DBMS_OUTPUT.PUT_LINE('  * Consultas Encerradas (apuradas): ' || v_qtd_encerradas);
    DBMS_OUTPUT.PUT_LINE('  * Consultas em Rascunho          : ' || v_qtd_rascunho);
    DBMS_OUTPUT.PUT_LINE('  * Total Geral de Votos Coletados : ' || v_soma_geral_votos);
    IF v_total_consultas > 0 THEN
        DBMS_OUTPUT.PUT_LINE('  * Média de Participação/Consulta : ' || ROUND(v_soma_geral_votos / v_total_consultas, 2) || ' votos');
    END IF;
    DBMS_OUTPUT.PUT_LINE('========================================================================================');

EXCEPTION
    WHEN OTHERS THEN
        IF cur_consultas%ISOPEN THEN
            CLOSE cur_consultas;
        END IF;
        DBMS_OUTPUT.PUT_LINE('ERRO NO PROCESSAMENTO DO CURSOR: ' || SQLERRM);
END;
/
