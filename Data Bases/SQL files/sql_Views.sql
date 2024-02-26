--Otimizações por fazer:
    "tabela jogadorselecao" => trigger que garante que PessoaID corresponde ao mesmo ID de pessoa que está associada ao nº de ElementoComitiva_Numero;
    "tabela jogadorselecao" => trigger que garante o pais_Seleção é igual ao pais de está associado ao nº de ElementoComitiva_Numero;
    "tabela jogadorjogo" => garantir que apenas 2 seleções diferentes é que podem estar associados a um jogo.
    "tabela equipajogo" => trigger que garante que apenas podem haver até 2 registos com o mesmo numero de jogo;
    "tabela jogo" => saber como indicar o ano do jogo sem recorrer à tabela "grupos";
    "tabela golo" => mudar a forma como se identifica o ano e edição do pais;

-- Otimizações implementadas:
   "tabela jogadorselecao" => A FKs que aponta para a coluna ElementoComitiva_Numero foi alterada para Unique, de forma a impedir repetições de nºs de séries;
   "tabela golo" => As FK composta, FK_Golo___Assitencia_JogadorEmCampo, pode ser NULL agora. Isto foi implementado pq não é obrigatório um golo ter tido assistência 

--  1. Qual a edição do mundial que teve um maior número de participantes, i.e. número de elementos de comitiva. Se 
-- houver várias edições com o mesmo número de participantes máximo, deverão ser todas listadas.

CREATE VIEW numero_participantes_edicao (Edicao, Numero_participantes) AS SELECT ec.Comitiva_Ano, count(*)
FROM elementocomitiva ec
GROUP BY ec.Comitiva_Ano;

SELECT *
FROM numero_participantes_edicao 
WHERE Numero_participantes >= ALL(SELECT Numero_participantes FROM numero_participantes_edicao);

-- 2 Numa única consulta indique qual a seleção que teve o maior patrocínio alguma vez registado e quem era o 
-- patrocinador oficial?

CREATE VIEW Lista_de_patrocinios(Pais, Ano, Patrocinador, Montante) AS select sel.*, patro.Nome, Max(pat.Montante) as montante
from Selecao sel, Comitiva com, Patrocinio pat, Patrocinador patro
where sel.Pais = com.Pais AND sel.Ano = com.Ano AND com.Pais = pat.Comitiva_Pais_ AND com.Ano = pat.Comitiva_Ano_
AND pat.Patrocinador_Sigla_ = patro.Sigla
group by sel.Pais, sel.Ano, patro.Sigla
order by montante DESC;

SELECT *
FROM Lista_de_patrocinios
WHERE Montante >= ALL (SELECT Montante FROM Lista_de_patrocinios);

-- 3. Para cada comitiva indique qual o valor % de contributo de cada um dos patrocinadores.
SELECT p.Comitiva_Pais_, p.Comitiva_Ano_, p.Patrocinador_Sigla_, p.Montante, p.Montante / (
  SELECT SUM(p2.Montante)
  FROM patrocinio p2
  WHERE p2.Comitiva_Pais_ = p.Comitiva_Pais_ AND p2.Comitiva_Ano_ = p.Comitiva_Ano_
) as percentagem
FROM patrocinio p;

-- 4. Quais os jogadores por seleção que não participaram em nenhum jogo. Apresente os resultados ordenados pela 
-- edição do mundial, nome do país da seleção e número da camisola do jogador.

SELECT js.Selecao_Ano, js.Selecao_Pais, js.NumCamisola
FROM jogadorselecao js
WHERE (js.NumCamisola, js.Selecao_Ano) NOT IN( SELECT JogadorSelecao_NumCamisola, JogadorSelecao_Ano FROM jogadoremcampo)
ORDER BY js.Selecao_Ano, js.Selecao_Pais, js.NumCamisola;


-- 5. Qual o jogador que foi mais vezes substituído em todas as edições do mundial.
CREATE VIEW Jogadores_ComSubstituicoes (Edicao, Pais, Camisa_Jogador, Num_Substituicoes) AS SELECT Edicao, Pais, Camisa_Jogador, 
COUNT(*) as Num_Substituicoes
FROM (
  SELECT s.Substituido_JogadorSelecao_Ano as Edicao, s.Substituido_JogadorSelecao_NumCamisola as Camisa_Jogador, 
  s.Substituido_JogadorSelecao_Pais as Pais
  FROM substituicao s
) t
GROUP BY Edicao, Camisa_Jogador, Pais
ORDER BY Num_Substituicoes DESC;

SELECT *
FROM Jogadores_ComSubstituicoes
WHERE Num_Substituicoes >= ALL (SELECT Num_Substituicoes FROM jogadores_comsubstituicoes);

-- 6. Qual o jogo com mais penalizações (cartões vermelhos e amarelos).
SELECT Jogo_nr, Max(Penalizacoes) as PenalizacoesCometidas
FROM (SELECT p.Jogo_Numero as Jogo_nr, COUNT(*) as Penalizacoes
		FROM penalizacao p	GROUP BY p.Jogo_Numero) t;

-- 7. Qual o jogador com mais cartões vermelhos na última edição do campeonato, a edição representa o ano em que o 
-- Mundial se realizou.

CREATE VIEW JogadoresComVermelhos_UltimaEdicao (Ultima_Edicao, Pais, Nr_Camisola, Nr_Vermelhos) as SELECT cv.JogadorEmCampo_Ano, cv.JogadorEmCampo_Pais, cv.JogadorEmCampo_NumCamisola, COUNT(*)
FROM cartaovermelho cv
WHERE cv.JogadorEmCampo_Ano = (SELECT MAX(Ano) FROM edicao)
GROUP BY cv.JogadorEmCampo_NumCamisola;

SELECT *
FROM JogadoresComVermelhos_UltimaEdicao
WHERE Nr_Vermelhos >= ALL (SELECT Nr_Vermelhos FROM JogadoresComVermelhos_UltimaEdicao);


-- 8. Faça uma listagem das seleções por grupo. Deve exibir a edição e a seleção (respetivo país) por ordem alfabética 
-- dentro de cada grupo.

SELECT DISTINCT j.Grupo_Edicao_Ano, j.Grupo_Letra, ej.Selecao_Pais 
FROM grupo g, jogo j, equipajogo ej
WHERE j.Grupo_Edicao_Ano = g.Edicao_Ano AND j.Grupo_Letra = g.Letra AND ej.Jogo_numero = j.Numero
ORDER BY j.Grupo_Edicao_Ano, j.Grupo_Letra, ej.Selecao_Pais;


-----------------------------------------------------------------------------------------------------------------------

-- Automatismos auxiliares

"Numero de golos num jogo": golos_numJogo(jg_ID)

BEGIN
DECLARE golos numeric;
SELECT COUNT(*) INTO golos
FROM golo g, jogo j
WHERE g.Jogo_Numero=jg_ID AND g.Jogo_Numero=j.Numero
GROUP BY g.Jogo_Numero;

IF(golos IS NULL) THEN
 RETURN 0;
ELSE RETURN golos;
END IF;
END 