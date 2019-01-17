<html>
  <body>

<?php
//
  require("pdo_connection.php");
  $a_name =$_REQUEST['animal_name'];
  $owner_vat =$_REQUEST['owner_VAT'];
  $date_timestamp=$_REQUEST['date_timestamp'];
  $client_vat = $_REQUEST['client_VAT'];

  $stmt=$conn->prepare("SELECT age,gender,colour,species_name FROM animal WHERE VAT= :o_VAT AND name = :a_name");
  $stmt->bindParam(':a_name',$a_name, PDO::PARAM_STR);
  $stmt->bindParam(':o_VAT',$owner_vat, PDO::PARAM_STR);
  $stmt->execute();
  echo("<h3> Animal info:</h3>");
  if($stmt->rowCount() <1){
    	echo("<p> There are no previous consults for that animal .</p>");
  }else{
  	echo("<table border=\"1\">\n");
    echo("<tr><td>Animal Age</td><td>Animal Gender</td><td>Animal Colour</td><td>Animal Species</td></tr>");
    foreach($stmt as $row)
 	 {
  	echo("<tr>\n");
  	echo("<td>{$row['age']}</td>\n");
  	echo("<td>{$row['gender']}</td>\n");
  	echo("<td>{$row['colour']}</td>\n");
	  echo("<td>{$row['species_name']}</td>\n");
  	echo("</tr>\n");
  	}
  	echo("</table>\n");

    $stmt=$conn->prepare("SELECT s,o,a,p,weight FROM consult WHERE VAT_owner= :o_VAT AND name = :a_name AND date_timestamp=:d_date");
    $stmt->bindParam(':a_name',$a_name, PDO::PARAM_STR);
    $stmt->bindParam(':o_VAT',$owner_vat, PDO::PARAM_STR);
    $stmt->bindParam(':d_date',$date_timestamp, PDO::PARAM_STR);
    $stmt->execute();

    if($stmt->rowCount() <1){
      	echo("<p> There are no previous consults for that animal .</p>");
    }else{
      echo("<h3> Consult obervations:</h3>");
    	echo("<table border=\"1\">\n");
      echo("<tr><td>Subjective Obs</td><td>Objective Obs</td><td>Assessment</td><td>Plan</td><td>Weight</td></tr>\n");
      foreach($stmt as $row)
   	 {
    	echo("<tr>\n");
    	echo("<td>{$row['s']}</td>\n");
    	echo("<td>{$row['o']}</td>\n");
    	echo("<td>{$row['a']}</td>\n");
  	  echo("<td>{$row['p']}</td>\n");
  	  echo("<td>{$row['weight']}</td>\n");
    	echo("</tr>\n");
    	}
    	echo("</table>\n");
    }

    $stmt=$conn->prepare("SELECT cd.code as code, dc.name as name FROM consult_diagnosis cd, diagnosis_code dc WHERE VAT_owner= :o_VAT AND cd.name = :a_name AND dc.code = cd.code AND date_timestamp=:d_date");
    $stmt->bindParam(':a_name',$a_name, PDO::PARAM_STR);
    $stmt->bindParam(':o_VAT',$owner_vat, PDO::PARAM_STR);
    $stmt->bindParam(':d_date',$date_timestamp, PDO::PARAM_STR);
    $stmt->execute();

    if($stmt->rowCount() <1){
      	echo("<p> No diagnosis made in this consult.</p>");
    }else{
      echo("<h3> Diagnosis made:</h3>");
    	echo("<table border=\"1\">\n");
      echo("<tr><td>Diagnosis Code</td><td>Disease Name</td></tr>\n");
    	foreach($stmt as $row)
   	 {
    	echo("<tr>\n");

      echo("<td>{$row['code']}</td>\n");
      echo("<td>{$row['name']}</td>\n");
      echo("</tr>\n");
    	}
    	echo("</table>\n");

      $stmt=$conn->prepare("SELECT code,name_med, lab,dosage, regime FROM prescription WHERE VAT_owner= :o_VAT AND name = :a_name AND date_timestamp=:d_date");
      $stmt->bindParam(':a_name',$a_name, PDO::PARAM_STR);
      $stmt->bindParam(':o_VAT',$owner_vat, PDO::PARAM_STR);
      $stmt->bindParam(':d_date',$date_timestamp, PDO::PARAM_STR);
      $stmt->execute();

      if($stmt->rowCount() <1){
        	echo("<p> No prescription made for the diagnosis from this consult.</p>");
      }else{
        echo("<h3> Prescriptions:</h3>");
      	echo("<table border=\"1\">\n");
        echo("<tr><td>Code</td><td>Medication Name</td><td>Laboratory</td><td>Dosage</td><td>Regime</td></tr>\n");
      	foreach($stmt as $row)
     	 {
      	echo("<tr>\n");
      	echo("<td>{$row['code']}</td>\n");
        echo("<td>{$row['name_med']}</td>\n");
        echo("<td>{$row['lab']}</td>\n");
        echo("<td>{$row['dosage']}</td>\n");
        echo("<td>{$row['regime']}</td>\n");
        echo("</tr>\n");
      	}
      	echo("</table>\n");
      }
    }
  }

  $conn=null;

  echo ("<form method=\"post\" action=\"consult_list.php?animal_name=".$a_name."&owner_VAT=".$owner_vat."&client_VAT=".$client_vat."\">");
  echo "<button type=\"submit\">Return</button>";
  echo "</form>";
  ?>
  </body>
  </html>
