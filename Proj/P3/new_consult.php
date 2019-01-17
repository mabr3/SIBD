<html>
  <body>

<?php
  require("pdo_connection.php");
  $a_name =$_REQUEST['animal_name'];
  $client_vat = $_REQUEST['client_VAT'];
  $owner_vat =$_REQUEST['owner_VAT'];

  $stmt=$conn->prepare("SELECT code FROM diagnosis_code");
  $stmt->execute();
  $results = $stmt->fetchALL();
  $n=$stmt->rowCount();
  if($n==0){
    echo("<p> There are no diagnosis codes yet.</p>");
  }

  $stmt2=$conn->prepare("SELECT VAT FROM veterinary");
  $stmt2->execute();
  $results2 = $stmt2->fetchALL();
  $n2=$stmt2->rowCount();
  if($n2==0){
    echo("<p> There are no vets yet.</p>");
  }

  ?> <form method="post" action="insert_new_consult.php">
     <h3> New consult insertion for <?php echo $a_name?>: </h3>
     <p>Subjective Obs: <input type="text" name="s"/></p>
     <p>Objective Obs: <input type="text" name="o"/></p>
     <p>Assessment: <input type="text" name="a"/></p>
     <p>Plan: <input type="text" name="p"/></p>
     <p>Weight: <input type="number" step="0.01" name="weight" min="0.01"/></p>
     <p>Veterinary Vat: <select name="vet_VAT"> <?php foreach($results2 as $row){
         $VAT = $row['VAT'];
         echo("<option value=\"$VAT\">$VAT</option>");
       }?></select></p></p>
     <input type="hidden" name="client_VAT" value = "<?php echo $client_vat ?>"/>
     <input type="hidden" name="animal_name" value = "<?php echo $a_name ?>"/>
     <input type="hidden" name="owner_VAT" value = "<?php echo $owner_vat ?>"/>
     <p>Diagnosis Code: <select name="code"> <?php echo '<option value=""></option>'; foreach($results as $row){
       $code = $row['code'];
       echo("<option value=\"$code\">$code</option>");
     }?></select></p>
     <p>Diagnosis Code2: <select name="code2"> <?php echo '<option value=""></option>'; foreach($results as $row){
       $code = $row['code'];
       echo("<option value=\"$code\">$code</option>");
     }?></select></p>
      <button type="submit">Insert new consult</button>
    </form>

<?php
  echo "<form method=\"post\" action=\"consult_list.php?animal_name=".$a_name."&owner_VAT=".$owner_vat."&client_VAT=".$client_vat."\">";
  echo "<button type=\"submit\">Return</button>";
  echo "</form>";
?>
  </body>
  </html>
