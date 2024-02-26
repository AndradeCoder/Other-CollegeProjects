#!/bin/bash
export SHOW_DEBUG=1    ## Comment this line to remove @DEBUG statements

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos 2022/2023
##
## Aluno: Nº: 99377      Nome: Leonardo Andrade 
## Nome do Módulo: compra.sh
## Descrição/Explicação do Módulo: 
##
##
###############################################################################


if [[ -f produtos.txt && -f utilizadores.txt ]]; then
    ./success 2.1.1

    # 2.1.2
    produtos_com_Stock=$(awk -F: '$4 > 0 {print NR":", $1":", $3,"EUR"}' produtos.txt)
    awk '{print} END{printf "0: Sair\n\nInsira a sua opção: "}' <<< "$produtos_com_Stock"
    read option
    if [ $option -eq 0 ]; then
        ./success 2.1.2
        exit 0
    elif [ $option -gt $(echo "$produtos_com_Stock" | wc -l) ]; then
        ./error 2.1.2
        exit 2
    else
        produto_selecionado=$(awk -F"[: ]" '$1 == "'"$option"'" {for(i=3;i<=NF-2;i++) printf("%s ", $i)}' <<< "$produtos_com_Stock" | sed 's/ *$//')
        preco=$(awk -F"[: ]" '$1 == "'"$option"'" {print $(NF-1)}' <<< "$produtos_com_Stock")
        categoria=$(awk -F: '$1 == "'"$produto_selecionado"'" {print $2}' produtos.txt)
        ./success 2.1.2 "$produto_selecionado"

        # 2.1.3
        echo -n "Insira o ID do seu utilizador: "
        read id
        nome=$(awk -F: '{if ($1 == "'"$id"'") print $2}' utilizadores.txt)
        if [ -z "$nome" ]; then
            ./error 2.1.3
            exit 3
        else
            ./success 2.1.3 "$nome"

            # 2.1.4
            echo -n "Insira a senha do seu utilizador: "
            read senha
            check_senha=$(awk -F: '{if ($3 == "'"$senha"'" && $1 == "'"$id"'") print $3}' utilizadores.txt);
            if [ -n "$check_senha" ]; then
                ./success 2.1.4

                # 2.2.1
                saldo=$(awk -F: '{if ($3 == "'"$senha"'" && $1 == "'"$id"'") print $NF}' utilizadores.txt);
                if [ "$saldo" -ge "$preco" ]; then
                    ./success 2.2.1 "$preco" "$saldo"

                     # 2.2.2
                    saldo_atualizado=$(awk -F: -v nome="$nome" -v preco="$preco" '{if ($3 == "'"$senha"'" && $1 == "'"$id"'") print $NF-preco}' utilizadores.txt)
                    saldo_old_line=$(awk -F: '{if ($3 == "'"$senha"'" && $1 == "'"$id"'") print $0}' utilizadores.txt)
                    saldo_new_line=$(awk -F: -v saldo_atualizado="$saldo_atualizado" '$3 == "'"$senha"'" && $1 == "'"$id"'" {$NF=saldo_atualizado; printf "%s:%s:%s:%s:%s:%s\n", $1, $2, $3, $4, $5, $NF}' utilizadores.txt)
                    
                    stock_old_line=$(awk -F: '{if ($1 == "'"$produto_selecionado"'") print $0}' produtos.txt)
                    stock_new_line=$(awk -F: '$1 == "'"$produto_selecionado"'" {printf "%s:%s:%s:%s:%s\n", $1, $2, $3, $4-1, $5}' produtos.txt)

                    if [ -n "$saldo_atualizado" ]; then
                        if sed -i "s/^${saldo_old_line}/${saldo_new_line}/" utilizadores.txt; then
                            ./success 2.2.2
                            if sed -i "s/^${stock_old_line}/${stock_new_line}/" produtos.txt; then
                                ./success 2.2.3
                                currdate=$(date +%Y-%m-%d)
                                if echo "$produto_selecionado:$categoria:$id:$currdate" >> relatorio_compras.txt; then
                                    ./success 2.2.4
                                    if printf '**** %s: Compras de %s ****\n%s, %s\n' "$currdate" "$nome" "$produto_selecionado" "$currdate" >> lista-compras-utilizador.txt; then
                                        ./success 2.2.5
                                        exit 0
                                    else
                                        ./error 2.2.5
                                        exit 9
                                    fi
                                else
                                    ./error 2.2.4
                                    exit 8
                                fi
                            else
                                ./error 2.2.3
                                exit 7
                            fi
                        else
                            ./error 2.2.2
                            exit 6
                        fi
                    else
                        ./error 2.2.2
                        exit 6
                    fi
                else
                    ./error 2.2.1 "$preco" "$saldo"
                    exit 5
                fi
            else
                ./error 2.1.4
                exit 4
            fi
        fi
    fi
else
    ./error 2.1.1
    exit 1
fi 