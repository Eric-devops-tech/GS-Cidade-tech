DECLARE
    -- Declaração de variáveis para receber os dados via SELECT INTO
    v_id_consulta           TB_CT_CONSULTA.id_consulta%TYPE := 1;
    v_titulo                TB_CT_CONSULTA.titulo%TYPE;
    v_bairro                TB_CT_CONSULTA.bairro_alvo%TYPE;
    v_status                TB_CT_CONSULTA.status%TYPE;
    v_nome_tema             TB_CT_TEMA.nome_tema%TYPE;
    v_nome_gestor           TB_CT_USUARIO.nome%TYPE;
    
    -- Variáveis de apuração de votos
    v_total_votos           NUMBER := 0;
    v_votos_favor           NUMBER := 0;
    v_votos_contra          NUMBER := 0;
    v_votos_abstencao       NUMBER := 0;
    v_perc_favor            NUMBER(5,2) := 0;
    
    -- Variáveis para a regra de negócio
    v_classificacao_parecer VARCHAR2(100);
    v_acao_recomendada      VARCHAR2(150);

BEGIN
    -- 1. Busca os dados da consulta, tema e gestor responsável via SELECT INTO
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

    -- 2. Totalização dos votos registrados na consulta
    SELECT COUNT(*),
           NVL(SUM(CASE WHEN opcao_voto = 'FAVOR' THEN 1 ELSE 0 END), 0),
           NVL(SUM(CASE WHEN opcao_voto = 'CONTRA' THEN 1 ELSE 0 END), 0),
           NVL(SUM(CASE WHEN opcao_voto = 'ABSTENCAO' THEN 1 ELSE 0 END), 0)
      INTO v_total_votos,
           v_votos_favor,
           v_votos_contra,
           v_votos_abstencao
      FROM TB_CT_VOTO
     WHERE id_consulta = v_id_consulta;

    IF v_total_votos > 0 THEN
        v_perc_favor := ROUND((v_votos_favor / v_total_votos) * 100, 2);
    ELSE
        v_perc_favor := 0;
    END IF;

    -- 3. Regra de Negócio com IF / ELSIF / ELSE: Classificação de aprovação popular
    IF v_total_votos = 0 THEN
        v_classificacao_parecer := 'SEM PARTICIPACAO POPULAR SUFICIENTE';
        v_acao_recomendada      := 'Ampliar divulgacao no bairro antes de prosseguir.';
    ELSIF v_perc_favor >= 70.00 THEN
        v_classificacao_parecer := 'APROVADA COM AMPLA ADESAO POPULAR';
        v_acao_recomendada      := 'Encaminhar com prioridade para inclusao no orcamento do bairro.';
    ELSIF v_perc_favor >= 50.00 THEN
        v_classificacao_parecer := 'APROVADA POR MAIORIA SIMPLES';
        v_acao_recomendada      := 'Apto para planejamento e analise de viabilidade tecnica.';
    ELSIF v_votos_contra > v_votos_favor THEN
        v_classificacao_parecer := 'REJEITADA PELA COMUNIDADE';
        v_acao_recomendada      := 'Arquivar proposta ou remodelar ouvindo os moradores.';
    ELSE
        v_classificacao_parecer := 'DIVISAO DE OPINIOES / EMPATE TECNICO';
        v_acao_recomendada      := 'Convocar audiencia publica presencial para alinhamento.';
    END IF;

    -- 4. Exibição dos resultados formatados via DBMS_OUTPUT
    DBMS_OUTPUT.PUT_LINE('================================================================');
    DBMS_OUTPUT.PUT_LINE('PAINEL DE ANALISE DE CONSULTA - CIDADE TECH');
    DBMS_OUTPUT.PUT_LINE('Consulta: #' || v_id_consulta || ' - ' || v_titulo);
    DBMS_OUTPUT.PUT_LINE('Tema: ' || v_nome_tema || ' | Bairro: ' || v_bairro || ' | Status: ' || v_status);
    DBMS_OUTPUT.PUT_LINE('Gestor Responsavel: ' || v_nome_gestor);
    DBMS_OUTPUT.PUT_LINE('Votos: Total=' || v_total_votos || ' | Favor=' || v_votos_favor || ' (' || v_perc_favor || '%) | Contra=' || v_votos_contra || ' | Abstencao=' || v_votos_abstencao);
    DBMS_OUTPUT.PUT_LINE('Classificacao: ' || v_classificacao_parecer);
    DBMS_OUTPUT.PUT_LINE('Proximo Passo: ' || v_acao_recomendada);
    DBMS_OUTPUT.PUT_LINE('================================================================');

-- 5. Tratamento de exceções
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: Nenhuma consulta foi encontrada para o ID ' || v_id_consulta);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO INESPERADO (' || SQLCODE || '): ' || SQLERRM);
END;
