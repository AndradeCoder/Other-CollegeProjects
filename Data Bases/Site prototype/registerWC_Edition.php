<html>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<head><title>Tentativa de Registo de uma edição do Mundial</title>
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
if (!empty($_POST["Ano"])) {

  echo "<h2>Registou uma nova Edição com sucesso!</h2><br><br>";
  echo '<echo>';
  print_r($_POST);
  echo '</echo>';
}
else{
  echo "<h2>ERRO: Para registar uma edição é obrigatório escrever no mínimo o ano!</h2><br><br>";
}

require('fifaMundial.php');
require('edicaoMundial.php');

$edition = new EdicaoMundial();
$edition->insertNewEdition($_POST["Ano"], $_POST["Designacao"], $_POST["Orcamento"]);
$edition->closeEdicao();
?>

<p><br></p>
  <a href="MenuInicial.htm">Voltar ao Inicio </a>
  <p><hr size="3.5" color="blue"></p>
</body>
</html>