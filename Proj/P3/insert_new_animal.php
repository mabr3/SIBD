<html>
  <body>


<?php
  require("pdo_connection.php");

    $client_vat = $_REQUEST['client_VAT'];
    $aname = $_REQUEST['animalname'];
    $gender = $_REQUEST['gender'];
    $age = $_REQUEST['age'];
    $birth = $_REQUEST['byear'];
    $species = $_REQUEST['species'];
    $colour = $_REQUEST['colour'];

    $stmt=$conn->prepare("INSERT INTO animal VALUES(:aname, :vat, :species, :gender, :colour, :year, :age)");

    $stmt->bindParam(':aname',$aname, PDO::PARAM_STR);
    $stmt->bindParam(':vat',$client_vat, PDO::PARAM_STR);
    $stmt->bindParam(':gender',$gender, PDO::PARAM_STR);
    $stmt->bindParam(':species',$species, PDO::PARAM_STR);
    $stmt->bindParam(':colour',$colour, PDO::PARAM_STR);
    $stmt->bindParam(':age',$age, PDO::PARAM_INT);
    $stmt->bindParam(':year',$birth, PDO::PARAM_INT);

    $stmt->execute();
    $n=$stmt->rowCount();
    if($n != 0){
      echo("<p>Animal inserted with the following data: </p>");
    }else{
      echo("<p> No new insertions, check the given data for mistakes: </p>");

    }
    echo("<table border=\"1\">");
    echo("<tr><td>Animal name</td><td>Owner VAT</td><td>Animal Species</td><td>Animal Colour</td><td>Animal BirthYear</td><td>Animal Gender</td><td>Animal Age</td></tr>");
    echo("</td><td>");
    echo($aname);
    echo("</td><td>");
    echo($client_vat);
    echo("</td><td>");
    echo($species);
    echo("</td><td>");
    echo($colour);
    echo("</td><td>");
    echo($birth);
    echo("</td><td>");
    echo($gender);
    echo("</td><td>");
    echo($age);
    echo("</td></tr>");
    echo("</table>");

    $conn=null;
?>

<?php
  echo "<form method=\"post\" action=\"get_consults.php?animal_name=".$aname."&owner_VAT=".$client_vat."&client_VAT=".$client_vat."\">";
  echo "<button type=\"submit\">Return</button>";
  echo "</form>";
?>




</body>
</html>
