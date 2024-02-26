<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>BD Loja - Alterar</title>
<style>
    body {
        background-color: #6699cc;;
    }
    th, td{
        border: 2.8px groove black;
        padding: 10px;
        background-color: #ffcc99;
    }
    table{
        background-color: darkblue;
        border-width: 0px;
        border-spacing: 0px;
        padding: 0px;
    }
    td{
        border-top: 0px;;
    }
    th{
        background: red;
        color: burlywood;
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
<?php
require('fifaMundial.php');
require('jogoMundial.php');

$jogoDB = new JogoMundial();
?>
<body>
<p><h3>Modificar um jogo:</h3></p>
<form method="post" action="Alteracao.php">

  <label for="Numero">Numero:<?php echo $_POST["Numero"]; ?></label>
  <input type=hidden name="Numero" value=<?php echo $_POST["Numero"]; ?>>
  <br/>
  <br/>
  
  <label for="Estadio_Nome">Estadio_Nome: </label><br/>
  <input type="text" name="Estadio_Nome" size="50" maxlength="50" value="<?php echo $jogoDB->ReceberEstadio($_POST["Numero"]); ?>">
  <br/>
  <br/>
  
  <label for="Fase">Fase: </label><br/>
  <textarea name="Fase" cols="50" rows="3"><?php echo $jogoDB->ReceberFase($_POST["codigo"]); ?></textarea>
  <br/>
  <br/>
  
  <label for="Data">Data: </label><br/>
  <input type="text" name="Data" size="30" maxlength="30" value="<?php echo $jogoDB->ReceberData($_POST["codigo"]); ?>">
  <br/>
  <br/>
  <?php $jogoDB->closeJogo(); ?>
  <p><input type="submit" value="Alterar" style="border: 6px groove #d47260; color: white; background: #d04437;">
  <input type="reset" value="Limpas Dados" style="border: 6px groove #d0b33c; color: white; background: #fbb03b;"></p>
</form>
</body>
</html>