<?php
  $host = "db.tecnico.ulisboa.pt";
  $user = "ist176176";
  $pass = "oalh0726";
  $dsn = "mysql:host=$host;dbname=$user";
  try
  {
    $conn = new PDO($dsn, $user, $pass);
  }
  catch(PDOException $exception)
  {
    echo("<p>Error: ");
    echo($exception->getMessage());
    echo("</p>");
    exit();
  }
?>
