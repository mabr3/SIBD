<html>
  <body>
<?php
  require("pdo_connection.php");

    $aname = $_REQUEST['animal_name'];
    $owner_VAT =$_REQUEST['owner_VAT'];
    $i1 = $_REQUEST['i1'];
    $i2 = $_REQUEST['i2'];
    $i3 = $_REQUEST['i3'];
    $num = $_REQUEST['num'];
    $assist_VAT = $_REQUEST['assist_VAT'];
    $date = $_REQUEST['date_timestamp'];
    $description = $_REQUEST['description'];

    $count =0;

    $n1='indicator1';
    $n2='indicator2';
    $n3='indicator3';
    $type = 'blood';

    try{

    $conn->beginTransaction();

    $stmt=$conn->prepare("INSERT INTO _procedure VALUES(:aname, :vat_owner, :_date, :num, :description)");

    $stmt->bindParam(':aname',$aname, PDO::PARAM_STR);
    $stmt->bindParam(':vat_owner',$owner_VAT, PDO::PARAM_STR);
    $stmt->bindParam(':num',$num, PDO::PARAM_INT);
    $stmt->bindParam(':description',$description, PDO::PARAM_STR);
    $stmt->bindParam(':_date',$date,PDO::PARAM_STR);
    $stmt->execute();
    $c1 = $stmt->rowCount();


    if(empty($_REQUEST['assist_VAT'])){
      $c2=1;
      echo("<p>This procedure had no assistant.</p>");
    }else{
      $stmt2=$conn->prepare("INSERT INTO performed VALUES(:aname, :vat_owner, :_date, :num, :vat_ass)");
      $stmt2->bindParam(':aname',$aname, PDO::PARAM_STR);
      $stmt2->bindParam(':vat_owner',$owner_VAT, PDO::PARAM_STR);
      $stmt2->bindParam(':num',$num, PDO::PARAM_INT);
      $stmt2->bindParam(':vat_ass',$assist_VAT, PDO::PARAM_STR);
      $stmt2->bindParam(':_date',$date,PDO::PARAM_STR);
      $stmt2->execute();
      $c2 = $stmt2->rowCount();
    }

    $stmt3=$conn->prepare("INSERT INTO test_procedure VALUES(:aname, :vat_owner, :_date, :num, :type)");
    $stmt3->bindParam(':aname',$aname, PDO::PARAM_STR);
    $stmt3->bindParam(':vat_owner',$owner_VAT, PDO::PARAM_STR);
    $stmt3->bindParam(':num',$num, PDO::PARAM_INT);
    $stmt3->bindParam(':type',$type, PDO::PARAM_STR);
    $stmt3->bindParam(':_date',$date,PDO::PARAM_STR);
    $stmt3->execute();
    $c3 = $stmt3->rowCount();

    $stmt4=$conn->prepare("INSERT INTO produced_indicator VALUES(:aname, :vat_owner, :_date, :num, :i_name,  CAST(:value AS DECIMAL(10,3))),(:aname, :vat_owner, :_date, :num, :i_name2, CAST(:value2 AS DECIMAL(10,3))),(:aname, :vat_owner, :_date, :num, :i_name3, CAST(:value3 AS DECIMAL(10,3)))");
    $stmt4->bindParam(':aname',$aname, PDO::PARAM_STR);
    $stmt4->bindParam(':vat_owner',$owner_VAT, PDO::PARAM_STR);
    $stmt4->bindParam(':num',$num, PDO::PARAM_INT);
    $stmt4->bindParam(':_date',$date,PDO::PARAM_STR);
    $stmt4->bindParam(':i_name',$n1,PDO::PARAM_STR);
    $stmt4->bindParam(':value',$i1,PDO::PARAM_STR);
    $stmt4->bindParam(':i_name2',$n2,PDO::PARAM_STR);
    $stmt4->bindParam(':value2',$i2,PDO::PARAM_STR);
    $stmt4->bindParam(':i_name3',$n3,PDO::PARAM_STR);
    $stmt4->bindParam(':value3',$i3,PDO::PARAM_STR);
    $stmt4->execute();
    $c4 = $stmt4->rowCount();


    if($c1 ==0 or $c2==0 or $c3==0 or $c4==0){
      throw new Exception("Error Processing Request", 1);

    }
  $conn->commit();
  echo("<p>Success!<p>");

}catch (Exception $e){
    $conn->rollBack();
    echo("<p>Error inserting the data</p>");
  }

  echo("<h3> Info: </h3>");
  echo("<table border=\"1\">");
  echo("<tr><td>Animal name</td><td>Owner VAT</td><td>Date</td><td>Num</td><td>Description</td></tr>");
  echo("</td><td>");
  echo($aname);
  echo("</td><td>");
  echo($owner_VAT);
  echo("</td><td>");
  echo($date);
  echo("</td><td>");
  echo($num);
  echo("</td><td>");
  echo($description);
  echo("</td></tr>");
  echo("</table>\n\n");

  echo("<table border=\"1\">");
  echo("<tr><td>Animal name</td><td>Owner VAT</td><td>Date</td><td>Num</td><td>Type</td></tr>");
  echo("</td><td>");
  echo($aname);
  echo("</td><td>");
  echo($owner_VAT);
  echo("</td><td>");
  echo($date);
  echo("</td><td>");
  echo($num);
  echo("</td><td>");
  echo($type);
  echo("</td></tr>");
  echo("</table>\n\n");

  if(!empty($_REQUEST['assist_VAT'])){
    echo("<table border=\"1\">");
    echo("<tr><td>Animal name</td><td>Owner VAT</td><td>Date</td><td>Num</td><td>VAT Assistant</td></tr>");
    echo("</td><td>");
    echo($aname);
    echo("</td><td>");
    echo($owner_VAT);
    echo("</td><td>");
    echo($date);
    echo("</td><td>");
    echo($num);
    echo("</td><td>");
    echo($assist_VAT);
    echo("</td></tr>");
    echo("</table>\n\n");
  }

  echo("<table border=\"1\">");
  echo("<tr><td>Num</td><td>Nr of lymphocytes</td><td>Value</td><td>Nr of neutrophils</td><td>Value</td><td>White blood cell count</td><td>Value</td></tr>");
  echo("</td><td>");
  echo($num);
  echo("</td><td>");
  echo($n1);
  echo("</td><td>");
  echo($i1);
  echo("</td><td>");
  echo($n2);
  echo("</td><td>");
  echo($i2);
  echo("</td><td>");
  echo($n3);
  echo("</td><td>");
  echo($i3);
  echo("</td></tr>");
  echo("</table>\n\n");

  $conn=null;
?>

<form method="post" action="consult_init_check.php">
     <button type="submit">Return</button>
 </form>

</body>
</html>
