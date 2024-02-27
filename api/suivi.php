<?php
// DONE

include("init.php");

class AbsenceRecord {
  public $id_abs;
  public $date;
  public $motif;
}

if ($_GET["op"] == "abs") {
  $result = $conn->query("SELECT * FROM `users` WHERE prenom = '" . $_GET["last"] . "' AND nom = '" . $_GET["first"] . "'");
  $row = mysqli_fetch_assoc($result);

  
    $id_search = $row["id_user"];

    $result = $conn->query("SELECT * FROM `abs` WHERE id_user = '$id_search'");

    $abs_list = array();

    while ($row = mysqli_fetch_assoc($result)) {
      $absence = new AbsenceRecord();

      $absence->id_abs = $row["id_abs"];
      $absence->date = $row["date"];
      $absence->motif = $row["motif"];

      $abs_list[] = $absence;
      echo stripslashes(json_encode($abs_list));
    }}

else if ($_GET["op"] == "ret") {
    $result = $conn->query("SELECT * FROM `users` WHERE prenom = '" . $_GET["last"] . "' AND nom = '" . $_GET["first"] . "'");
    $row = mysqli_fetch_assoc($result);
  
    
      $id_search = $row["id_user"];
  
  $result = $conn->query("SELECT * FROM `retard` WHERE id_user = '$id_search'");

  $retard_list = array();

  while ($row = mysqli_fetch_assoc($result)) {
    $retard = new AbsenceRecord();

    $retard->id_abs = $row["id_retard"];
    $retard->date = $row["date"];
    $retard->motif = $row["motif"];

    $retard_list[] = $retard;
  }

  echo stripslashes(json_encode($retard_list));
}


else if ($_GET["op"] == "class" )
{
    // http://localhost/projet/suivi.php?op=class&class=1

    $class = $_GET["class"];
    $result = $conn->query("SELECT * FROM `abs` WHERE id_user IN ( SELECT id_user FROM users WHERE class = '$class' )");
    $row = mysqli_fetch_array($result);

    $j_list = array();

    $counter = 0;

    while($row = mysqli_fetch_assoc( $result )) 
    {
        $u = new tmp_struct();

        $u->id_abs = $row["id_abs"];
        $u->nom = $row["nom"];
        $u->prenom = $row["prenom"];
        $u->date = $row["date"];
        $u->motif = $row["motif"];

        $j_list[$counter] = $u;

        $counter++;
    }

    echo stripslashes(json_encode($j_list));

    $result = $conn->query("SELECT * FROM `retard` WHERE id_user IN ( SELECT id_user FROM users WHERE class = '$class' )");
    
    $j_list = array();

    $counter = 0;

    while($row = mysqli_fetch_assoc( $result )) 
    {
        $u = new tmp_struct();

        $u->id_abs = $row["id_retard"];
        $u->nom = $row["nom"];
        $u->prenom = $row["prenom"];
        $u->date = $row["date"];
        $u->motif = $row["motif"];

        $j_list[$counter] = $u;

        $counter++;
    }

    echo stripslashes(json_encode($j_list));
}

?>