-- ============================================================================
-- PROJETO: Cidade Tech - Consultas e Acompanhamento de Decisões Comunitárias
-- DISCIPLINA: Mastering Relational and Non-Relational Database
-- ENTREGA: 03_plsql_anonymous_block.sql
-- DESCRIÇÃO: Bloco Anônimo PL/SQL com variáveis, SELECT INTO, DBMS_OUTPUT 
--            e estrutura de decisão IF/ELSIF/ELSE para regra de negócio.
-- AUTORES: Kayque Duarte (RM 567980), Eric Maciel (RM 567398), Gabriel Correa Souza (RM 567903)
-- TURMA: 2TDSPB
-- ============================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED;

DECLARE
    -- Identificador da consulta a ser avaliada
    v_id_consulta           TB_CT_CONSULTA.id_consulta%TYPE := 1;
    
    -- Variáveis para SELECT INTO dos dados da consulta
    v_titulo                TB_CT_CONSULTA.titulo%TYPE;
    v_bairro                TB_CT_CONSULTA.bairro_alvo%TYPE;
    v_status                TB_CT_CONSULTA.status%TYPE;
    v_nome_tema             TB_CT_TEMA.nome_tema%TYPE;
    v_nome_gestor           TB_CT_USUARIO.nome%TYPE;
    
    -- Variáveis de apuração e contagem
    v_total_votos           NUMBER := 0;
    v_votos_favor           NUMBER := 0;
    v_votos_contra          NUMBER := 0;
    v_votos_abstencao       NUMBER := 0;
    v_perc_favor            NUMBER(5,2) := 0;
    
    -- Classificação pela regra de negócio
    v_classificacao_parecer VARCHAR2(100);
    v_acao_recomendada      VARCHAR2(150);

BEGIN
    -- 1. Recuperação das informações descritivas da consulta via SELECT INTO
    SELECT c.titulo,
           c.bairro_alvo,
           c.status,
           t.nome_tema,
           u.nome
      INTO v_titulo,
           v_bairro,
           v_status,
           v_nome_tema,
           v_nome_gestor
      FROM TB_CT_CONSULTA c
      JOIN TB_CT_TEMA t    ON c.id_tema = t.id_tema
      JOIN TB_CT_USUARIO u ON c.id_gestor = u.id_usuario
     WHERE c.id_consulta = v_id_consulta;

    -- 2. Totalização detalhada das opções de voto
    SELECT COUNT(*)                                                 AS total,
           NVL(SUM(CASE WHEN opcao_voto = 'FAVOR' THEN 1 ELSE 0 END), 0) AS favor,
           NVL(SUM(CASE WHEN opcao_voto = 'CONTRA' THEN 1 ELSE 0 END), 0) AS contra,
           NVL(SUM(CASE WHEN opcao_voto = 'ABSTENCAO' THEN 1 ELSE 0 END), 0) AS abstencao
      INTO v_total_votos,
           v_votos_favor,
           v_votos_contra,
           v_votos_abstencao
      FROM TB_CT_VOTO
     WHERE id_consulta = v_id_consulta;

    -- Cálculo do percentual favorável (quando há votos)
    IF v_total_votos > 0 THEN
        v_perc_favor := ROUND((v_votos_favor / v_total_votos) * 100, 2);
    ELSE
        v_perc_favor := 0;
    END IF;

    -- 3. Regra de Negócio: Decisão com IF / ELSIF / ELSE
    -- Classificação da adesão comunitária e direcionamento para a prefeitura/associação
    IF v_total_votos = 0 THEN
        v_classificacao_parecer := 'SEM PARTICIPAÇÃO POPULAR SUFICIENTE';
        v_acao_recomendada      := 'Ampliar canais de divulgação no bairro antes de prosseguir.';
    ELSIF v_perc_favor >= 70.00 THEN
        v_classificacao_parecer := 'APROVADA COM AMPLA ADESÃO POPULAR';
        v_acao_recomendada      := 'Encaminhar com prioridade máxima para inclusão no orçamento do bairro.';
    ELSIF v_perc_favor >= 50.00 THEN
        v_classificacao_parecer := 'APROVADA POR MAIORIA SIMPLES';
        v_acao_recomendada      := 'Apto para planejamento e análise de viabilidade técnica municipal.';
    ELSIF v_votos_contra > v_votos_favor THEN
        v_classificacao_parecer := 'REJEITADA PELA COMUNIDADE';
        v_acao_recomendada      := 'Arquivar proposta ou remodelar o escopo ouvindo os moradores.';
    ELSE
        v_classificacao_parecer := 'DIVISÃO DE OPINIÕES / EMPATE TÉCNICO';
        v_acao_recomendada      := 'Convocar audiência pública presencial para alinhamento.';
    END IF;

    -- 4. Exibição dos resultados formatados via DBMS_OUTPUT
    DBMS_OUTPUT.PUT_LINE('================================================================');
    DBMS_OUTPUT.PUT_LINE('           PAINEL DE ANÁLISE DE CONSULTA - CIDADE TECH           ');
    DBMS_OUTPUT.PUT_LINE('================================================================');
    DBMS_OUTPUT.PUT_LINE('ID da Consulta      : ' || v_id_consulta);
    DBMS_OUTPUT.PUT_LINE('Título da Proposta  : ' || v_titulo);
    DBMS_OUTPUT.PUT_LINE('Tema Vinculado      : ' || v_nome_tema);
    DBMS_OUTPUT.PUT_LINE('Bairro de Aplicação : ' || v_bairro);
    DBMS_OUTPUT.PUT_LINE('Gestor Responsável  : ' || v_nome_gestor);
    DBMS_OUTPUT.PUT_LINE('Status da Consulta  : ' || v_status);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('APURAÇÃO DOS VOTOS:');
    DBMS_OUTPUT.PUT_LINE('  * Total de Votos Registrados : ' || v_total_votos);
    DBMS_OUTPUT.PUT_LINE('  * Votos a Favor              : ' || v_votos_favor || ' (' || v_perc_favor || '%)');
    DBMS_OUTPUT.PUT_LINE('  * Votos Contra               : ' || v_votos_contra);
    DBMS_OUTPUT.PUT_LINE('  * Abstenções                 : ' || v_votos_abstencao);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('PARECER DA REGRA DE NEGÓCIO:');
    DBMS_OUTPUT.PUT_LINE('  * Classificação Oficial : ' || v_classificacao_parecer);
    DBMS_OUTPUT.PUT_LINE('  * Próximo Passo Sugerido: ' || v_acao_recomendada);
    DBMS_OUTPUT.PUT_LINE('================================================================');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: Nenhuma consulta foi encontrada para o ID ' || v_id_consulta);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO INESPERADO (' || SQLCODE || '): ' || SQLERRM);
END;
/
