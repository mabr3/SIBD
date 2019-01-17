<html>
  <body>

<?php
//
  require("pdo_connection.php");
  $a_name =$_REQUEST['animal_name'];
  $client_vat = $_REQUEST['client_VAT'];
  $owner_vat =$_REQUEST['owner_VAT'];

  $stmt=$conn->prepare("SELECT name,VAT_owner, date_timestamp FROM consult WHERE VAT_owner= :o_VAT AND name = :a_name");
  $stmt->bindParam(':a_name',$a_name, PDO::PARAM_STR);
  $stmt->bindParam(':o_VAT',$owner_vat, PDO::PARAM_STR);
  $stmt->execute();
  $nrows=$stmt->rowCount();

  echo("<h3>$a_name's (owned by $owner_vat) consults:</h3>");

  if($stmt->rowCount() <1){
    	echo("<p> There are no previous consults for that animal .</p>");
  }else{
  	echo("<table border=\"1\">\n");
    echo("<tr><td>Animal Name</td><td>Owner VAT</td><td>Date Timestamp</td><td>Consult Details</td><td>Results</td></tr>");
  	foreach($stmt as $row)
 	 {
  	echo("<tr>\n");
  	echo("<td>{$row['name']}</td>\n");
  	echo("<td>{$row['VAT_owner']}</td>\n");
  	echo("<td>{$row['date_timestamp']}</td>\n");
  	echo("<td><a href=\"consult_details.php?animal_name=".$row['name']."&owner_VAT=".$row['VAT_owner']."&date_timestamp=".$row['date_timestamp']."&client_VAT=".$client_vat);
  	echo("\">Consult Details</a></td>\n");
    echo("<td><a href=\"test_form.php?animal_name=".$row['name']."&owner_VAT=".$row['VAT_owner']."&date_timestamp=".$row['date_timestamp']."&client_VAT=".$client_vat);
  	echo("\">Enter new blood test</a></td>\n");
  	echo("</tr>\n");
  	}
  	echo("</table>\n");
  }

  $conn=null;

  echo "<br>";
  echo ("<form method=\"post\" action=\"new_consult.php?animal_name=".$a_name."&owner_VAT=".$owner_vat."&client_VAT=".$client_vat."\">");
  echo ("<button type=\"submit\">Create New Consult</button>");
  echo "</form>";
  echo "<form method=\"post\" action=\"consult_init_check.php\">";
  echo "<button type=\"submit\">Return</button>";
  echo "</form>";
  ?>
  </body>
  </html>
