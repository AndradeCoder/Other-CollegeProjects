#!/bin/bash
export SHOW_DEBUG=1    ## Comment this line to remove @DEBUG statements

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos 2022/2023
##
## Aluno: Nº: 99377      Nome: Leonardo Andrade
## Nome do Módulo: refill.sh
## Descrição/Explicação do Módulo: 
##
##
###############################################################################

if [[ -f produtos.txt && -f reposicao.txt ]]; then
    ./success 3.1.1

    # 3.1.2
    Itens_nome=$(awk -F: '{print $1, $NF}' reposicao.txt);
    Nr_itens_a_adicionar=$(awk '{print $NF}' <<< "$Itens_nome")
    for f in $Nr_itens_a_adicionar; do
        if [[ $f =~ ^[0-9]+$ ]]; then
            ./success 3.1.2
            maximo_menos_atual=$(awk -F: '$1 == "'"$Itens_nome"'" {print $NF-$(NF-1)}' produtos.txt)
            if printf '**** Produtos em falta em %s ****\n%s: %s unidades\n' "$currdate" "$Itens_nome" "$f" >> produtos-em-falta.txt; then
                ./success 3.2.1
            else
                ./error 3.2.1
                exit 2
            fi
        else
            ./error 3.1.2 "$f"
        fi
    done
else
    ./error 3.1.1
    exit 1
fi