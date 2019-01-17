<html>
  <body>

<?php
  require("pdo_connection.php");
  $a_name =$_REQUEST['animal_name'];
  $client_vat = $_REQUEST['client_VAT'];
  $owner_vat =$_REQUEST['owner_VAT'];
  $date = $_REQUEST['date_timestamp'];

  $stmt=$conn->prepare("SELECT VAT FROM assistant");
  $stmt->execute();
  $results = $stmt->fetchALL();
  $n=$stmt->rowCount();

  ?> <form method="post" action="insert_new_test.php">
     <h3> New blood test for <?php echo "$client_vat 's $a_name"?> : </h3>
     <p>Nr of lymphocytes (indicator1): <input type="number" step="0.01" name="i1" min = "0"/></p>
     <p>Nr of neutrophils (indicator2): <input type="number" step="0.01" name="i2" min = "0"/></p>
     <p>White blood cell count (indicator3): <input type="number" step="0.01" name="i3" min="0"/></p>
     <p>Assistant Vat: <select  name="assist_VAT"> <?php echo '<option value=""></option>';foreach($results as $row){
      $assist_vat = $row['VAT'];
      echo("<option value =\"$assist_vat\">$assist_vat</option>");
    }?></select></p>
     <p>Num: <input type="number" name="num" min="0"/></p>
     <p>Description: <input type="text" name="description"/></p>
     <input type="hidden" name="date_timestamp" value ="<?php echo $date ?>"/>
     <input type="hidden" name="client_VAT" value = "<?php echo $client_vat ?>"/>
     <input type="hidden" name="animal_name" value = "<?php echo $a_name ?>"/>
     <input type="hidden" name="owner_VAT" value = "<?php echo $owner_vat ?>"/>
      <button type="submit">Insert new blood test</button>
    </form>

<?php
  echo "<form method=\"post\" action=\"consult_list.php?animal_name=".$a_name."&owner_VAT=".$owner_vat."&client_VAT=".$client_vat."\">";
  echo "<button type=\"submit\">Return</button>";
  echo "</form>";
?>
  </body>
  </html>
