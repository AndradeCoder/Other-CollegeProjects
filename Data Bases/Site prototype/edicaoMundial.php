<?php
class EdicaoMundial extends FifaMundial{

    var $edicaoMundial_DB;

    function __construct(){
        $this->edicaoMundial_DB = new FifaMundial();
    }

    function insertNewEdition($ano, $descricao, $orcamento){
        $sql_code = "INSERT INTO edicao VALUES('$ano', '$descricao', '$orcamento')";
        $this->edicaoMundial_DB->querryToExecute($sql_code);
    }

    function closeEdicao(){
        $this->edicaoMundial_DB->closeConnection();
    }
}
?>