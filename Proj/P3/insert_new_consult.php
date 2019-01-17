<html>
  <body>


<?php
  require("pdo_connection.php");

    $client_VAT = $_REQUEST['client_VAT'];
    $aname = $_REQUEST['animal_name'];
    $owner_VAT =$_REQUEST['owner_VAT'];
    $s = $_REQUEST['s'];
    $o = $_REQUEST['o'];
    $a = $_REQUEST['a'];
    $p = $_REQUEST['p'];
    $vet_VAT = $_REQUEST['vet_VAT'];
    $weight = $_REQUEST['weight'];

    $date = date('Y-m-d H:i:s');

    $stmt=$conn->prepare("INSERT INTO consult VALUES(:aname, :vat_owner, :_date, :s, :o, :a, :p, :vat_client, :vat_vet, CAST(:weight AS DECIMAL(10,2)))");

    $stmt->bindParam(':aname',$aname, PDO::PARAM_STR);
    $stmt->bindParam(':vat_owner',$owner_VAT, PDO::PARAM_STR);
    $stmt->bindParam(':s',$s, PDO::PARAM_STR);
    $stmt->bindParam(':o',$o, PDO::PARAM_STR);
    $stmt->bindParam(':a',$a, PDO::PARAM_STR);
    $stmt->bindParam(':p',$p, PDO::PARAM_STR);
    $stmt->bindParam(':vat_client',$client_VAT, PDO::PARAM_STR);
    $stmt->bindParam(':vat_vet',$vet_VAT, PDO::PARAM_STR);
    $stmt->bindParam(':weight',$weight, PDO::PARAM_STR);
    $stmt->bindParam(':_date',$date,PDO::PARAM_STR);

    $stmt->execute();
    $n=$stmt->rowCount();
    if($n != 0){
      echo("<p>Consult inserted with the following data: </p>");


      if(!empty($_REQUEST['code'])){
         $code = $_REQUEST['code'];

         $stmt=$conn->prepare("INSERT INTO consult_diagnosis VALUES(:code, :aname, :vat_owner, :_date)");
         $stmt->bindParam(':aname',$aname, PDO::PARAM_STR);
         $stmt->bindParam(':vat_owner',$owner_VAT, PDO::PARAM_STR);
         $stmt->bindParam(':_date',$date,PDO::PARAM_STR);
         $stmt->bindParam(':code',$code,PDO::PARAM_STR);
         $stmt->execute();
         $n2= $stmt->rowCount();

         if($n2<1){
           echo("<p> Error inserting the diagnosis code 1.</p>");
         }

      }

      if(!empty($_REQUEST['code2'])){
         $code2 = $_REQUEST['code2'];

         $stmt=$conn->prepare("INSERT INTO consult_diagnosis VALUES(:code, :aname, :vat_owner, :_date)");
         $stmt->bindParam(':aname',$aname, PDO::PARAM_STR);
         $stmt->bindParam(':vat_owner',$owner_VAT, PDO::PARAM_STR);
         $stmt->bindParam(':_date',$date,PDO::PARAM_STR);
         $stmt->bindParam(':code',$code2,PDO::PARAM_STR);
         $stmt->execute();
         $n2= $stmt->rowCount();

         if($n2<1){
           echo("<p> Error inserting the diagnosis code 2.</p>");
         }

      }
    }else{
      echo("<p> No new insertions, check the given data for mistakes: </p>");
    }

    echo("<table border=\"1\">");
    echo("<tr><td>Animal name</td><td>Owner VAT</td><td>Date</td><td>Subjective Obs</td><td>Objective Obs</td><td>Assessment</td><td>Plan</td><td>Client VAT</td><td>Vet VAT</td><td>Weight</td><td>Diagosis Code1</td><td>Diagosis Code2</td></tr>");
    echo("</td><td>");
    echo($aname);
    echo("</td><td>");
    echo($owner_VAT);
    echo("</td><td>");
    echo($date);
    echo("</td><td>");
    echo($s);
    echo("</td><td>");
    echo($o);
    echo("</td><td>");
    echo($a);
    echo("</td><td>");
    echo($p);
    echo("</td><td>");
    echo($client_VAT);
    echo("</td><td>");
    echo($vet_VAT);
    echo("</td><td>");
    echo($weight);
    echo("</td><td>");
    echo($code);
    echo("</td><td>");
    echo($code2);
    echo("</td></tr>");
    echo("</table>\n");

    $conn=null;
?>

<form method="post" action="consult_init_check.php">
     <button type="submit">Return</button>
 </form>

</body>
</html>
