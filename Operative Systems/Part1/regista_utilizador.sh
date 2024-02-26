#!/bin/bash
export SHOW_DEBUG=1    ## Comment this line to remove @DEBUG statements

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos 2022/2023
##
## Aluno: Nº: 99377       Nome: Leonardo Andrade
## Nome do Módulo: regista_utilizador.sh
## Descrição/Explicação do Módulo:
##      As várias alíneas do módulo estão bem
##
###############################################################################

# 1.1.1
if [[ $# -lt 3 || $# -gt 4 ]]; then
    ./error 1.1.1
    exit 1
else
    ./success 1.1.1
fi

# 1.1.2
alunos_SO=$(awk -F "[:,]" '{if ($5 == "'"$1"'") print $5}' /etc/passwd)
if [ -n "$alunos_SO" ]; then
    ./success 1.1.2
else
    ./error 1.1.2
    exit 2
fi

# 1.1.3
if [[ "$3" =~ ^[0-9]+$ ]]; then
    ./success 1.1.3
else
    ./error 1.1.3
    exit 3
fi

# 1.1.4
if [[ $# -eq 4 ]]; then
    if [[ "$4" =~ ^[0-9]+{9}$ ]]; then
        ./success 1.1.4
    else
        ./error 1.1.4
        exit 4
    fi
fi


# 1.2.1 e 1.2.2
if [ -f utilizadores.txt ]; then
    ./success 1.2.1
else
    ./error 1.2.1
    if touch utilizadores.txt && [ -f utilizadores.txt ]; then
        ./success 1.2.2
    else
        ./error 1.2.2
        exit 5
    fi
fi

# Verificação da presença do nome inserido no ficheiro e consequentes ações
nome="$1"
check_nome=$(awk -F: '{if ($2 == "'"$nome"'") print $2}' utilizadores.txt | sort -u)
check_senha=$(awk -F: '{if ($3 == "'"$2"'") print $3}' utilizadores.txt | sort -u)

if [ -n "$check_nome" ]; then
    ./success 1.2.3
    if [ -n "$check_senha" ]; then
        ./success 1.3.1

        saldo_atualizado=$(awk -F: -v nome="$nome" -v saldo_a_adicionar="$3" '$2==nome {print $NF+saldo_a_adicionar}' utilizadores.txt)
        old_line=$(awk -F: -v nome="$nome" '$2==nome {print $0}' utilizadores.txt)
        new_line=$(awk -F: -v nome="$nome" -v saldo_atualizado="$saldo_atualizado" '$2==nome {$NF=saldo_atualizado; printf "%s:%s:%s:%s:%s:%s\n", $1, $2, $3, $4, $5, $NF}' utilizadores.txt)

        if [ -n "$saldo_atualizado" ]; then
            if sed -i "s/^${old_line}/${new_line}/" utilizadores.txt; then
                ./success 1.3.2 "$saldo_atualizado"
            else
                ./error 1.3.2
                exit 10
            fi
        else
            ./error 1.3.2
        fi
    else
        ./error 1.3.1
        exit 6
    fi
else
    ./error 1.2.3
    if [ $# -eq 4 ]; then
        ./success 1.2.4
    else
        ./error 1.2.4
        exit 7
    fi

    # 1.2.5
    if [ ! -s utilizadores.txt ]; then
        ./error 1.2.5
        user_id=1
    else
        user_id=$(awk -F: 'END {if ($1+0 == $1 && $1 ~ /^[0-9]+$/) {max=$1; print max+1}}' utilizadores.txt)
        ./success 1.2.5 "$user_id"
    fi

        # 1.2.6
    suffix2="@kiosk-iul.pt"
    if suffix1=$(awk -F "[:,]" '{ n=split($0,a," "); if(n==1) exit 1; else if(n==2) print tolower(a[1])"."tolower(a[2]); else print tolower(a[1])"."tolower(a[n]); }' <<< "$nome");
    then
        email="$suffix1$suffix2"
        ./success 1.2.6 "$email"
    else
        ./error 1.2.6
        exit 8
    fi

    # 1.2.7
    if echo "$user_id:$nome:$2:$email:$4:$3" >> utilizadores.txt; then
        NR=$(awk 'END{print NR}' utilizadores.txt)
        ./success 1.2.7 "$NR"
    else
        ./error 1.2.7
        exit 9
    fi

fi

if (cat utilizadores.txt | sort -t ':' -k 6 -nr) > saldos-ordenados.txt; then
    ./success 1.4.1
else
    ./error 1.4.1
fi

exit 0