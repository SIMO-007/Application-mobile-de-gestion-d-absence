<?php
// DONE
include("init.php");

// Absences

// show

if( $_GET["op"] == "absences" )
{
	// http://localhost/projet/absence_user.php?op=absences&matiere=francais&table=mat_es&id=26

    //$id_mat = get_matiere_id($_GET["matiere"], $_GET["table"]);
    
    $result = $conn->query("SELECT * FROM `abs` WHERE id_user = '".$_GET["id_user"]."'");
    $result = $conn->query("SELECT * FROM `abs` WHERE id_user = 26");
    $j_list = array();

    $counter = 0;

    while($row = mysqli_fetch_assoc( $result )) 
    {
        $u = array();

        $u["date"] = $row["date"];
        $u["motif"] = $row["motif"];

        $j_list[$counter] = $u;

        $counter++;
    }

    echo stripslashes(json_encode($j_list));

}
else if( $_GET["op"] == "non_justif_absence" )
{
	// http://localhost/projet/absence_user.php?op=non_justif_absence&matiere=francais&table=mat_es&id=19

    $id_mat = get_matiere_id($_GET["matiere"], $_GET["table"]);
    $id = $_GET["id"];

    $result = $conn->query("SELECT * FROM `abs` WHERE id_mat = '$id_mat' AND id_user = '$id' AND motif = 'Pas de justif'");

    $j_list = new JSON_list();

    $counter = 0;

    while($row = mysqli_fetch_assoc( $result )) 
    {
        $u = new tmp_struct();

        $u->id_abs = $row["id_abs"];
        $u->date = $row["date"];
        $u->motif = $row["motif"];

        $j_list->$counter = $u;

        $counter++;
    }

    echo stripslashes(json_encode($j_list));
}
else if( $_GET["op"] == "retards" )
{
    // http://localhost/projet/absence_user.php?op=retards&matiere=francais&table=mat_es&id=26

    //$id_mat = get_matiere_id($_GET["matiere"], $_GET["table"]);
    
    $result = $conn->query("SELECT * FROM `retard` WHERE id_user = '".$_GET["id_user"]."'");

    $j_list = array();

    $counter = 0;

    while($row = mysqli_fetch_assoc( $result )) 
    {
        $u = array();

        $u["date"] = $row["date"];
        $u["motif"] = $row["motif"];

        $j_list[$counter] = $u;

        $counter++;
    }

    echo stripslashes(json_encode($j_list));

}
else if( $_GET["op"] == "non_justif_retard" )
{
    // http://localhost/projet/absence_user.php?op=non_justif_retard&matiere=francais&table=mat_es&id=19

    $id_mat = get_matiere_id($_GET["matiere"], $_GET["table"]);
    $id = $_GET["id"];

    $result = $conn->query("SELECT * FROM `retard` WHERE id_mat = '$id_mat' AND id_user = '$id' AND motif = 'Pas de justif'");

    $j_list = new JSON_list();

    $counter = 0;

    while($row = mysqli_fetch_assoc( $result )) 
    {
        $u = new tmp_struct();

        $u->id_abs = $row["id_abs"];
        $u->date = $row["date"];
        $u->motif = $row["motif"];

        $j_list->$counter = $u;

        $counter++;
    }

    echo stripslashes(json_encode($j_list));
}
// show
else if($_GET["op"] == "check_dates")
{
    $id_mat = get_matiere_id($_GET["matiere"], $_GET["table"]);
    $id = $_GET["id"];
    
    $result = $conn->query("SELECT * FROM `abs` WHERE id_mat LIKE '".$id_mat."' AND date BETWEEN '" . str_replace("T"," ",$_GET["start"].':00') . "' AND '" . str_replace("T"," ",$_GET["end"].':00') . "' AND id_user = '$id'");

    // localhost/projet/absence_user.php?op=check_dates&matiere=francais&id=26&start=2000-01-01 00:00:00&end=3000-01-01 00:00:00&table=mat_es

    $j_list = new JSON_list();

    $counter = 0;

    while($row = mysqli_fetch_assoc( $result )) 
    {
        $u = new tmp_struct();

        $u->id_abs = $row["id_abs"];
        $u->date = $row["date"];
        $u->motif = $row["motif"];

        $j_list->$counter = $u;

        $counter++;
    }

    echo stripslashes(json_encode($j_list));
}

?>