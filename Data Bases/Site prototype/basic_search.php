<html>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<head><title>Resultados da Pesquisa Básica</title>
  <style>
    body {
          background-color: #6699cc;
    }
    a:link, a:visited, a:hover {
          border: 6px groove black;
          display: inline-block;
          padding: 2px 6px;
          font-style: italic;
          text-decoration: none;
    }
    a:visited {
          background: purple;
          color: white; 
          border-color: magenta;
    }
    a:link{
          background: darkblue;
          color: whitesmoke;
          border-color: cyan;
    }
    a:hover {
          background: red;
          color: whitesmoke;
          text-decoration: underline;
          border-color: lightsalmon;
    }
</style>
</head>
<body>
<?php
require('fifaMundial.php');
require('jogoMundial.php');

$edition = new JogoMundial();
$edition->pesquisarBasico($_POST["ID"]);
$edition->closeJogo();
?>

<p><br></p>
  <a href="MenuInicial.htm">Voltar ao Inicio </a>
  <p><hr size="3.5" color="blue"></p>
</body>
</html>