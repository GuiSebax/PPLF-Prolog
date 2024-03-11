% vim: set ft=prolog:

% Guilherme Frare Clemente RA: 124349

:- use_module(library(plunit)).

% Um jogo é representado por uma estrutura jogo com 3 argumentos. O primeiro é
% o número de linhas (L), o segundo o número de colunas (C) e o terceiro uma
% lista (Blocos - de tamanho linhas x colunas) com os blocos do jogo. Nessa
% representação os primeiros L elementos da lista Blocos correspondem aos
% blocos da primeira linha do jogo, os próximos L blocos correspondem aos
% blocos da segunda linha do jogo e assim por diante.
%
% Dessa forma, em jogo com 3 linhas e 5 colunas (total de 15 blocos), os
% blocos são indexados da seguinte forma:
%
%  0  1  2  3  4
%  5  6  7  8  9
% 10 11 12 13 14
%
% Cada bloco é representado por uma estrutura bloco com 4 argumentos. Os
% argumentos representam os valores da borda superior, direita, inferior e
% esquerda (sentido horário começando do topo). Por exemplo o bloco
%
% |  3  |
% |4   6|  é representado por bloco(3, 6, 7, 4).
% |  7  |
%
% Dizemos que um bloco está em posição adequada se os valores das bordas
% correspondem aos valores dos blocos adjacentes. Por exemplo, o bloco
% bloco(3, 6, 7, 4) está em posição adequada no jogo acima.

% Caso não seja adequado, o bloco pode ser rotacionado para que fique adequado
% em relação aos blocos adjacentes. Por exemplo, o bloco acima
% 
% pode ser rotacionado para
%
% |  4  |
% |7   3|  que é representado por bloco(4, 3, 7, 6).
% |  6  |
%
% e estará em posição adequada no jogo acima.




%% jogo_solucao(+JogoInicial, ?JogoFinal) is semidet
%
%  Verdadeiro se JogoInicial é uma estrutura jogo(L, C, Blocos) e JogoFinal é
%  uma estrutura jogo(L, C, Solucao), onde Solucao é uma solução válida para o
%  JogoInicial, isto é, os blocos que aparecem em Solucao são os mesmos de
%  Blocos e estão em posições adequadas.

jogo_solucao(JogoInicial, JogoFinal) :-
    jogo(L, C, Blocos) = JogoInicial,
    jogo(L, C, Solucao) = JogoFinal,
    blocos_adequados(jogo(L, C, Solucao)),
    permutation(Blocos, Solucao).

:- begin_tests(pequeno).

test(j1x1, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(3, 6, 7, 5)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(1, 1, Inicial), jogo(1, 1, Final)).


test(j2x2, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(3, 4, 7, 9),
        bloco(6, 9, 5, 4),
        bloco(7, 6, 5, 2),
        bloco(5, 3, 1, 6)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(2, 2, Inicial), jogo(2, 2, Final)).

test(j3x3, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(7, 3, 4, 9),
        bloco(3, 4, 8, 3),
        bloco(7, 4, 2, 4),
        bloco(4, 4, 8, 5),
        bloco(8, 3, 6, 4),
        bloco(2, 2, 7, 3),
        bloco(8, 9, 1, 3),
        bloco(6, 6, 6, 9),
        bloco(7, 8, 5, 6)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(3, 3, Inicial), jogo(3, 3, Final)).

:- end_tests(pequeno).


:- begin_tests(medio).

test(j4x4, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(7, 7, 4, 8),
        bloco(3, 0, 2, 7),
        bloco(7, 9, 1, 0),
        bloco(1, 6, 3, 9),
        bloco(4, 2, 5, 5),
        bloco(2, 4, 5, 2),
        bloco(1, 5, 7, 4),
        bloco(3, 8, 0, 5),
        bloco(5, 5, 8, 0),
        bloco(5, 5, 9, 5),
        bloco(7, 6, 7, 5),
        bloco(0, 2, 1, 6),
        bloco(8, 7, 9, 5),
        bloco(9, 2, 8, 7),
        bloco(7, 3, 3, 2),
        bloco(1, 0, 4, 3)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(4, 4, Inicial), jogo(4, 4, Final)).

test(j5x5, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(1, 6, 7, 5),
        bloco(4, 0, 0, 6),
        bloco(9, 2, 0, 0),
        bloco(8, 3, 5, 2),
        bloco(0, 4, 5, 3),
        bloco(7, 1, 2, 6),
        bloco(0, 4, 5, 1),
        bloco(0, 0, 3, 4),
        bloco(5, 1, 1, 0),
        bloco(5, 3, 2, 1),
        bloco(2, 9, 1, 0),
        bloco(5, 5, 5, 9),
        bloco(3, 2, 2, 5),
        bloco(1, 0, 6, 2),
        bloco(2, 9, 0, 0),
        bloco(1, 0, 7, 0),
        bloco(5, 0, 7, 0),
        bloco(2, 4, 8, 0),
        bloco(6, 9, 4, 4),
        bloco(0, 0, 6, 9),
        bloco(7, 0, 2, 5),
        bloco(7, 2, 0, 0),
        bloco(8, 6, 1, 2),
        bloco(4, 4, 6, 6),
        bloco(6, 5, 8, 4)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(5, 5, Inicial), jogo(5, 5, Final)).

test(j6x6, [nondet, Final = Blocos]) :-
    Blocos = [
        bloco(3, 0, 2, 4),
        bloco(9, 5, 5, 0),
        bloco(1, 1, 8, 5),
        bloco(4, 2, 0, 1),
        bloco(4, 3, 2, 2),
        bloco(8, 0, 0, 3),
        bloco(2, 2, 3, 9),
        bloco(5, 9, 1, 2),
        bloco(8, 2, 3, 9),
        bloco(0, 2, 3, 2),
        bloco(2, 9, 8, 2),
        bloco(0, 6, 9, 9),
        bloco(3, 1, 6, 9),
        bloco(1, 2, 2, 1),
        bloco(3, 0, 8, 2),
        bloco(3, 5, 8, 0),
        bloco(8, 7, 8, 5),
        bloco(9, 4, 8, 7),
        bloco(6, 0, 6, 9),
        bloco(2, 4, 5, 0),
        bloco(8, 7, 6, 4),
        bloco(8, 3, 7, 7),
        bloco(8, 7, 2, 3),
        bloco(8, 7, 1, 7),
        bloco(6, 3, 9, 0),
        bloco(5, 1, 9, 3),
        bloco(6, 9, 8, 1),
        bloco(7, 7, 0, 9),
        bloco(2, 0, 6, 7),
        bloco(1, 3, 7, 0),
        bloco(9, 9, 8, 7),
        bloco(9, 0, 6, 9),
        bloco(8, 1, 6, 0),
        bloco(0, 9, 7, 1),
        bloco(6, 1, 7, 9),
        bloco(7, 8, 1, 1)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(6, 6, Inicial), jogo(6, 6, Final)).

:- end_tests(medio).


:- begin_tests(grande).

test(j7x7, [nondet, Blocos = Final]) :-
    Blocos = [
        bloco(4, 1, 0, 8),
        bloco(7, 8, 1, 1),
        bloco(0, 3, 5, 8),
        bloco(4, 0, 9, 3),
        bloco(9, 7, 1, 0),
        bloco(6, 8, 3, 7),
        bloco(3, 5, 2, 8),
        bloco(0, 9, 5, 8),
        bloco(1, 4, 9, 9),
        bloco(5, 1, 6, 4),
        bloco(9, 3, 1, 1),
        bloco(1, 5, 6, 3),
        bloco(3, 3, 2, 5),
        bloco(2, 0, 4, 3),
        bloco(5, 1, 8, 8),
        bloco(9, 6, 8, 1),
        bloco(6, 5, 2, 6),
        bloco(1, 8, 6, 5),
        bloco(6, 4, 9, 8),
        bloco(2, 8, 2, 4),
        bloco(4, 1, 8, 8),
        bloco(8, 1, 5, 4),
        bloco(8, 2, 0, 1),
        bloco(2, 0, 2, 2),
        bloco(6, 4, 8, 0),
        bloco(9, 7, 7, 4),
        bloco(2, 8, 5, 7),
        bloco(8, 0, 7, 8),
        bloco(5, 6, 0, 8),
        bloco(0, 9, 4, 6),
        bloco(2, 2, 2, 9),
        bloco(8, 9, 5, 2),
        bloco(7, 1, 5, 9),
        bloco(5, 2, 0, 1),
        bloco(7, 9, 6, 2),
        bloco(0, 7, 5, 8),
        bloco(4, 7, 5, 7),
        bloco(2, 9, 1, 7),
        bloco(5, 7, 5, 9),
        bloco(5, 5, 4, 7),
        bloco(0, 8, 5, 5),
        bloco(6, 8, 7, 8),
        bloco(5, 7, 9, 6),
        bloco(5, 0, 2, 7),
        bloco(1, 4, 6, 0),
        bloco(5, 3, 2, 4),
        bloco(4, 9, 6, 3),
        bloco(5, 8, 1, 9),
        bloco(7, 8, 0, 8)
    ],
    reverse(Blocos, Inicial),
    jogo_solucao(jogo(7, 7, Inicial), jogo(7, 7, Final)).

:- end_tests(grande).


%% blocos_adequados(jogo(+L, +C, ?Blocos)) is semidet
%
%  Verdadeiro se Jogo é uma estrutura jogo(L, C, Blocos), e todos os blocos de
%  Blocos estão em posições adequadas. Ou seja, verdadeiro caso todos os blocos
%  da lista Blocos de um jogo LxC estejam na posicao correta
%
%Exemplos blocos adequados
:- begin_tests(blocos_adequados).
test(blocos_adequados) :-
    blocos_adequados(jogo(3,3,[bloco(7, 3, 4, 9),
                               bloco(3, 4, 8, 3),
                               bloco(7, 4, 2, 4),
                               bloco(4, 4, 8, 5),
                               bloco(8, 3, 6, 4),
                               bloco(2, 2, 7, 3),
                               bloco(8, 9, 1, 3),
                               bloco(6, 6, 6, 9),
                               bloco(7, 8, 5, 6)])).

test(blocos_adequados_fail, [fail]) :-
    blocos_adequados(jogo(3,3,[bloco(2,0,2,2),
                               bloco(2,2,2,2),
                               bloco(2,2,2,2),
                               bloco(2,2,2,2),
                               bloco(1,2,3,4),
                               bloco(1,1,1,1),
                               bloco(2,2,2,2),
                               bloco(2,2,2,2),
                               bloco(2,211,2,2)])).
:-end_tests(blocos_adequados).

blocos_adequados(jogo(L, C, Blocos)) :-
    bloco_adequado(jogo(L, C, Blocos), 1).




%% bloco_adequado(jogo(+L, +C, ?Blocos), +P) is semidet
% 
% Verdadeiro caso os blocos da posicao P em diante estejam em uma 
% posicao adequda para um jogo com L linhas, C colunas e sendo Blocos
% a lista de blocos, ou seja, se as bordas dos blocos vizinhos forem correspondentes
% com as bordas de P
%
%
%          __3__
%         I  3  I
%       1 I1   2I 2
%         I  4  I
%         -------
%            4

%Exemplos bloco adequado
:- begin_tests(bloco_adequado).

test(bloco_adequado_meio) :-
    bloco_adequado(jogo(3,3,[bloco(0,0,0,0),bloco(0,0,1,0),bloco(0,0,0,0),
                             bloco(0,4,0,0),bloco(1,2,3,4),bloco(0,0,0,2),
                             bloco(0,0,0,0),bloco(3,0,0,0),bloco(0,0,0,0)]),5).

test(bloco_adequado_canto_esquerdo_superior) :-
    bloco_adequado(jogo(3,3,[bloco(1,2,3,4),bloco(0,0,0,2),bloco(0,0,0,0),
                             bloco(3,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0)]),1).

test(bloco_adequado_canto_direito_superior) :-
    bloco_adequado(jogo(3,3,[bloco(0,0,0,0),bloco(0,4,0,0),bloco(1,2,3,4),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(3,0,0,0),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0)]),3).

test(bloco_adequado_canto_direito_inferior) :-
    bloco_adequado(jogo(3,3,[bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,1,0),
                             bloco(0,0,0,0),bloco(0,4,0,0),bloco(1,2,3,4)]),9).

test(bloco_adequado_canto_esquerdo_inferior) :-
    bloco_adequado(jogo(3,3,[bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(0,0,1,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(1,2,3,4),bloco(0,0,0,2),bloco(0,0,0,0)]),7).

test(bloco_adequado_meio_primeira_linha) :-
    bloco_adequado(jogo(3,3,[bloco(0,4,0,0),bloco(1,2,3,4),bloco(0,0,0,2),
                             bloco(0,0,0,0),bloco(3,0,0,0),bloco(0,0,0,0),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0)]),2).

test(bloco_adequado_meio_ultima_linha) :-
    bloco_adequado(jogo(3,3,[bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(0,0,0,0),bloco(0,0,1,0),bloco(0,0,0,0),
                             bloco(0,4,0,0),bloco(1,2,3,4),bloco(0,0,0,2)]),8).

test(bloco_adequado_meio_primeira_coluna) :-
    bloco_adequado(jogo(3,3,[bloco(0,0,1,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(1,2,3,4),bloco(0,0,0,2),bloco(0,0,0,0),
                             bloco(3,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0)]),4).

test(bloco_adequado_meio_ultima_coluna) :-
    bloco_adequado(jogo(3,3,[bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,1,0),
                             bloco(0,0,0,0),bloco(0,4,0,0),bloco(1,2,3,4),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(3,0,0,0)]),6).

test(bloco_adequado_meio, [fail]) :-
    bloco_adequado(jogo(3,3,[bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(0,0,0,0),bloco(1,2,3,4),bloco(0,0,0,0),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0)]),5).

test(bloco_inadequado_canto_esquerdo_superior, [fail]) :-
    bloco_adequado(jogo(3,3,[bloco(1,2,3,4),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(3,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0)]),1).

test(bloco_inadequado_canto_direito_superior, [fail]) :-
    bloco_adequado(jogo(3,3,[bloco(0,0,0,0),bloco(0,0,0,0),bloco(1,2,3,4),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0)]),3).

test(bloco_inadequado_canto_direito_inferior, [fail]) :-
    bloco_adequado(jogo(3,3,[bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(1,2,3,4)]),9).

test(bloco_inadequado_canto_esquerdo_inferior, [fail]) :-
    bloco_adequado(jogo(3,3,[bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(1,2,3,4),bloco(0,0,0,0),bloco(0,0,0,0)]),7).

test(bloco_adequado_meio_primeira_linha, [fail]) :-
    bloco_adequado(jogo(3,3,[bloco(0,0,0,0),bloco(1,2,3,4),bloco(0,0,0,0),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0)]),2).

test(bloco_inadequado_meio_ultima_linha, [fail]) :-
    bloco_adequado(jogo(3,3,[bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0),
                             bloco(0,4,0,0),bloco(1,2,3,4),bloco(0,0,0,2)]),8).

test(bloco_inadequado_meio_primeira_coluna, [fail]) :-
    bloco_adequado(jogo(3,3,[bloco(0,0,0,0),bloco(1,2,3,4),bloco(0,0,0,0),
                             bloco(1,2,3,4),bloco(0,0,0,2),bloco(0,0,0,0),
                             bloco(3,0,0,0),bloco(0,0,0,0),bloco(0,0,0,0)]),2).

test(bloco_inadequado_meio_ultima_coluna, [fail]) :-
    bloco_adequado(jogo(3,3,[bloco(0,0,0,0),bloco(0,0,0,0),bloco(0,0,1,0),
                             bloco(0,0,0,0),bloco(0,0,0,0),bloco(1,2,3,4),
                             bloco(0,0,0,0),bloco(0,1,2,3),bloco(3,0,0,0)]),8).

:- end_tests(bloco_adequado).

bloco_adequado(jogo(L, C, Blocos), P) :-
    P =< L * C,
    Li is (P - 1) // C + 1,
    Ci is (P - 1) mod C + 1,
    PosicaoCima is P - C,
    PosicaoBaixo is P + C,
    PosicaoDireita is P + 1,
    PosicaoEsquerda is P - 1,
    nth1(P, Blocos, bloco(Cima, Direita, Baixo, Esquerda)),
    (Ci = 1; nth1(PosicaoEsquerda, Blocos, bloco(_, Esquerda, _, _))),
    (Ci = C; nth1(PosicaoDireita, Blocos, bloco(_, _, _, Direita))),
    (Li = 1; nth1(PosicaoCima, Blocos, bloco(_, _, Cima, _))),
    (Li = L; nth1(PosicaoBaixo, Blocos, bloco(Baixo, _, _, _))),
    ( length(Blocos, P);
      bloco_adequado(jogo(L, C, Blocos), PosicaoDireita)), !.