<html>
	<body>
	<h3>Balances</h3>
<?php
	$host = "db.tecnico.ulisboa.pt";
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
	$sql = "SELECT * FROM account";
	$result = $connection->query($sql);
	if ($result == FALSE)
	{
		$info = $connection->errorInfo();
		echo("<p>Error: {$info[2]}</p>");
		exit();
	}

	echo("<table border=\"0\" cellspacing=\"5\">\n");
	foreach($result as $row)
	{
		echo("<tr>\n");
		echo("<td>{$row['account_number']}</td>\n");
		echo("<td>{$row['balance']}</td>\n");
		echo("<td><a href=\"delete.php?account_number=");
		echo($row['account_number']);
		echo("\">Delete account</a></td>\n");
		echo("</tr>\n");
	}
	echo("</table>\n");
	$connection = null;
?>
	</body>
</html>
