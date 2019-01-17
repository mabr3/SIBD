<html>
<body>
<?php
$host = "db.ist.utl.pt";
$user = "ist176176";
$pass = "oalh0726";
$dsn = "mysql:host=$host;dbname=$user";
try
{
$connection = new PDO($dsn, $user, $pass);
}
catch(PDOException $exception)
{
echo("<p>Error: ");
echo($exception->getMessage());
echo("</p>");
exit();
}
$account_number = $_REQUEST['account_number'];
$sql = "DELETE FROM account WHERE account_number = '$account_number'";
echo("<p>$sql</p>");
$nrows = $connection->exec($sql);
echo("<p>Rows updated: $nrows</p>");
$connection = null;
?>
</body>
</html>
