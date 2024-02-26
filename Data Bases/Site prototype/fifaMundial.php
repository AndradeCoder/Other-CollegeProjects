<?php

class FifaMundial{
    var $connect;

    function __construct(){
        $this->connect = mysqli_connect("localhost","root","", "mundial_futebol");

        if(!$this->connect){
        return -1;
        };   
    }

    function querryToExecute($querry){
        $sql_Code = mysqli_query($this->connect, $querry);
        return $sql_Code;
    }

    function closeConnection(){
        mysqli_close($this->connect);
    }
}


?>