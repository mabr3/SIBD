<html>
  <body>

<?php
//
  require("pdo_connection.php");
  $a_name =$_REQUEST['animal_name'];
  $client_vat = $_REQUEST['client_VAT'];
  $owner_name =$_REQUEST['owner_name'];

  $stmt=$conn->prepare("SELECT * FROM client WHERE VAT = :c_VAT");
  $stmt->bindParam(':c_VAT',$client_vat, PDO::PARAM_STR);
  $stmt->execute();

  if($stmt->rowCount() <1){
    echo("<p> There is no client with that VAT.</p>");
    $i=0;
  }else{
    $i=1;
    $stmt=$conn->prepare("SELECT * FROM animal WHERE name = :a_name");
    $stmt->bindParam(':a_name',$a_name, PDO::PARAM_STR);
    $stmt->execute();
    if($stmt->rowCount()<1){
      echo("<p> There is no animal with that name.</p>");
    }else{
      $stmt=$conn->prepare("SELECT name, VAT, species_name as species, colour FROM animal WHERE name = :a_name AND VAT in (SELECT VAT FROM client NATURAL JOIN person WHERE name LIKE :o_name) group by VAT");
      $stmt->bindValue(':o_name', '%' . $owner_name . '%');
      $stmt->bindParam(':a_name',$a_name, PDO::PARAM_STR);
      $stmt->execute();

      if($stmt->rowcount()<1){
        echo("<p> No results found.</p>");
      }else{
        echo("<h3> Animals that correspond to the search</h3>");
        echo("<table border=\"1\" cellspacing=\"5\">");
        echo("<tr><td>Animal name</td><td>Owner VAT</td><td>Animal Species</td><td>Animal Colour</td></tr>");

        while($row = $stmt->fetch()) {
          echo("<td><a href=\"consult_list.php?animal_name=".$row['name']."&client_VAT=".$client_vat."&owner_VAT=".$row['VAT']);
          echo("\">{$row['name']}</a>");
          echo("</td><td>");
          echo($row['VAT']);
          echo("</td><td>");
          echo($row['species']);
          echo("</td><td>");
          echo($row['colour']);
          echo("</td></tr>");
        }
        echo("</table>");

        $stmt=$conn->prepare("SELECT a.name, a.VAT, a.species_name AS species, a.colour FROM animal AS a LEFT OUTER JOIN consult AS c ON (a.name=c.name AND a.VAT=c.VAT_owner) WHERE a.name = :a_name AND VAT in (SELECT VAT FROM client NATURAL JOIN person WHERE name LIKE :o_name) AND c.VAT_client=:vat GROUP BY a.VAT");
        $stmt->bindValue(':o_name', '%' . $owner_name . '%');
        $stmt->bindParam(':a_name', $a_name, PDO::PARAM_STR);
        $stmt->bindParam(':vat', $client_vat, PDO::PARAM_STR);
        $stmt->execute();

        if($stmt->rowCount()<1){
          echo("<p>No animals matching the search have been to a consult with this client.");
        }else{
          echo("<h3> Animals that correspond to the search and have previously been to a consult with this client:</h3>");
          echo("<table border=\"1\" cellspacing=\"5\">");
          echo("<tr><td>Animal name</td><td>Owner VAT</td><td>Animal Species</td><td>Animal Colour</td></tr>");
          while($row = $stmt->fetch()) {
            echo("<td><a href=\"consult_list.php?animal_name=".$row['name']."&client_VAT=".$client_vat."&owner_VAT=".$row['VAT']);
            echo("\">{$row['name']}</a>");
            echo("</td><td>");
            echo($row['VAT']);
            echo("</td><td>");
            echo($row['species']);
            echo("</td><td>");
            echo($row['colour']);
            echo("</td></tr>");
          }
          echo("</table>");
        }
      }
    }
  }
  if($i==1){
    ?> <form method="post" action="insert_new_animal.php">
       <h3> New animal insertion: </h3>
       <p>Animal name: <input type="text" name="animalname"/></p>
       <p>Animal gender: <input type="text" name="gender"/></p>
       <p>Animal colour: <input type="text" name="colour"/></p>
       <p>Animal birth year: <input type="number" name="byear" max=<?php echo date("Y");?> min="0" /></p>
       <p>Species: <input type="text" name="species"/></p>
       <p>Age: <input type="number" name="age" min ="0"/></p>
       <input type="hidden" name="client_VAT" value = "<?php echo $client_vat ?>"/>
        <button type="submit">Insert new animal for VAT <?php echo $client_vat ?></button>
      </form> <?php;
  }

  $conn=null;
 ?>

 <form method="post" action="consult_init_check.php">
      <button type="submit">Return</button>
  </form>
  </body>
</html>
