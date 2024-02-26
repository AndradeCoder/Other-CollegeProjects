<?php
class JogoMundial extends fifaMundial{

var $jogoMundial_DB;

function __construct(){
    $this->jogoMundial_DB = new FifaMundial();
}

function listagem_jogos($nr_jogo, $selecoes, $nr_penalizacoes, $nr_golos){
    print "<form action='detalhesExtra.php' method='post'>";
    print "<td><input type='submit' value='$nr_jogo'></td><td>$selecoes</td><td>$nr_penalizacoes</td><td>$nr_golos</td>";
    print "<input type='hidden' name='game_number' value='$nr_jogo'>";
    print "</form>";
  }
  

function pesquisarBasico($filtro){

        $sql_code = "SELECT j.Numero, GROUP_CONCAT(ej.Selecao_Pais SEPARATOR ' - ') AS Selecoes_no_Jogo, 
    (SELECT COUNT(*) FROM penalizacao p WHERE p.Jogo_Numero=j.Numero) AS Nr_Penalizacoes, golos_noJogo(j.Numero) AS Golos_no_Jogo 
    FROM jogo j, equipajogo ej WHERE j.Numero LIKE '%$filtro%' AND ej.Jogo_numero=j.Numero GROUP BY j.Numero
    UNION
    SELECT j1.Numero, 'N.A.', (SELECT COUNT(*) FROM penalizacao p WHERE p.Jogo_Numero=j1.Numero) AS Nr_Penalizacoes, 
    golos_noJogo(j1.Numero) AS Golos_no_Jogo FROM jogo j1, equipajogo ej1 WHERE j1.Numero LIKE '%$filtro%' 
    AND j1.Numero NOT IN (SELECT Jogo_numero FROM equipajogo) GROUP BY j1.Numero ORDER BY Numero";

    print "<p><h2> Jogos cujo número de identificação contem uma sequência com este(s) número(s): $filtro</h2><p/><br>";
    print "<table border=4px groove; cellpadding=10px cellspacing=0px><br>";
    print "<style> th{
                     background: red;
                     }
                    td{
                      background: #ffcc99;  
                    }
             </style>";
    print "<th>Jogo_Nr</th><th>Seleções_no_Jogo</th><th>Nr_Penalizações</th><th>Nr_Golos</th>";

    $result_set = $this->jogoMundial_DB->querryToExecute($sql_code);
    $numb = 0;
    while ($row = mysqli_fetch_assoc($result_set)) {
      $numb++;
      print "<tr>";
       $this->listagem_jogos($row["Numero"], $row["Selecoes_no_Jogo"], $row["Nr_Penalizacoes"], $row["Golos_no_Jogo"]);
      print "</tr>";
    }
    print "</table><br>";

    if($numb < 2)
        print "<strong><u>$numb resultado";
    else
        print "<strong><u>$numb resultados";
}

function pesquisarAvancado($filtro1, $filtro2, $filtro3){
    echo "<table border=1 cellpadding=0 cellspacing=0>\n";

    $table_filtro2 = "";
    $query_filtro2 = "";
    $query_filtro3 = "";

    if (!empty($filtro2)) {
      $table_filtro2 .= ", jogadoremcampo";
      $query_filtro2 .= " AND jogadoremcampo.JogadorSelecao_NumCamisola LIKE '%$filtro2%'";
    }


    if (!empty($filtro3)) {
        if(empty($filtro2)){
            $query_filtro3 .= " AND golos_noJogo(j.Numero) LIKE '$filtro3'";
        }
        else{
            $query_filtro3 .= " OR golos_noJogo(j.Numero) LIKE '$filtro3'";
        }
    }


    $sql_code = "SELECT j.Numero, GROUP_CONCAT(ej.Selecao_Pais SEPARATOR ' - ') AS Selecoes_no_Jogo, 
    (SELECT COUNT(*) FROM penalizacao p WHERE p.Jogo_Numero=j.Numero) AS Nr_Penalizacoes, golos_noJogo(j.Numero) AS Golos_no_Jogo 
    FROM jogo j, equipajogo ej, (SELECT JogoID, group_concat(Selecao) as Selecoes FROM selecao_num_jogo GROUP BY JogoID) as jogos_selecoes  
    $table_filtro2 WHERE ej.Jogo_Numero=jogos_selecoes.JogoID AND jogos_selecoes.Selecao LIKE '%$filtro1%' COLLATE utf8mb4_general_ci $query_filtro2 $query_filtro3 GROUP BY j.Numero
    ";

    // $sql_code = "SELECT j.Numero, GROUP_CONCAT(ej.Selecao_Pais SEPARATOR ' - ') AS Selecoes_no_Jogo, 
    // (SELECT COUNT(*) FROM penalizacao p WHERE p.Jogo_Numero=j.Numero) AS Nr_Penalizacoes, golos_noJogo(j.Numero) AS Golos_no_Jogo 
    // FROM jogo j, equipajogo ej WHERE  LIKE '%$filtro1%' AND ej.Jogo_numero=j.Numero GROUP BY j.Numero
    // UNION
    // SELECT j1.Numero, 'N.A.', (SELECT COUNT(*) FROM penalizacao p WHERE p.Jogo_Numero=j1.Numero) AS Nr_Penalizacoes, 
    // golos_noJogo(j1.Numero) AS Golos_no_Jogo FROM jogo j1, equipajogo ej1 WHERE j1.Numero LIKE '%$filtro1%' 
    // AND j1.Numero NOT IN (SELECT Jogo_numero FROM equipajogo) GROUP BY j1.Numero ORDER BY Numero";

    //  SELECT DISTINCT selecao_num_jogo.* 
    //  FROM Selecao_num_Jogo, equipajogo ej
    //  WHERE Selecao LIKE 'Marrocos'

    print "<table border=4px groove; cellpadding=10px cellspacing=0px><br>";
    print "<style> th{
                     background: red;
                     }
                    td{
                      background: #ffcc99;  
                    }
             </style>";
    print "<th>Jogo_Nr</th><th>Seleções_no_Jogo</th><th>Nr_Penalizações</th><th>Nr_Golos</th>";

    $result_set = $this->jogoMundial_DB->querryToExecute($sql_code);
    $numb = 0;
    while ($row = mysqli_fetch_assoc($result_set)) {
      $numb++;
      print "<tr>";
       $this->listagem_jogos($row["Numero"], $row["Selecoes_no_Jogo"], $row["Nr_Penalizacoes"], $row["Golos_no_Jogo"]);
      print "</tr>";
    }
    print "</table><br>";

    if($numb < 2)
        print "<strong><u>$numb resultado";
    else
        print "<strong><u>$numb resultados";
}

function LimparJogo($querry) {
    $sql = "DELETE FROM jogo WHERE Numero = $querry";
    $this->jogoMundial_DB->querryToExecute($sql);
}

function AlterarJogo($Estadio_Nome, $Fase, $Data){
    $sql_code = "UPDATE jogo SET Estadio_Nome = '$Estadio_Nome', Fase = '$Fase', Data = '$Data'";
    $this->jogoMundial_DB->querryToExecute($sql_code);
}


function ReceberEstadio($querry) {
    $sql_code="SELECT Estadio_Nome FROM jogo WHERE Numero=$querry";
    $result_set = $this->jogoMundial_DB->querryToExecute($sql_code);
    $row = mysqli_fetch_assoc($result_set);
    return $row["Estadio_Nome"];
}

function ReceberFase($querry) {
    $sql_code="SELECT Fase FROM jogo WHERE Numero=$querry";
    $result_set = $this->jogoMundial_DB->querryToExecute($sql_code);
    $row = mysqli_fetch_assoc($result_set);
    return $row["Fase"];
}
    function ReceberData($querry) {
    $sql_code="SELECT Data FROM jogo WHERE Numero=$querry";
    $result_set = $this->jogoMundial_DB->querryToExecute($sql_code);
    $row = mysqli_fetch_assoc($result_set);
    return $row["Data"];
}

function closeJogo(){
    $this->jogoMundial_DB-> closeConnection();;
}

}
?>