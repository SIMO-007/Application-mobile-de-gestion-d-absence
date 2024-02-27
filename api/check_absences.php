<?php
	// DONE
	include("init.php");

	global $conn;
	$id = $_GET['id'];
	$l = array();

	/*
	http://localhost/projet/check_absences.php?id=1
	*/

    $result = $conn->query("SELECT * FROM `calendrier` WHERE id_professeur = '$id' AND done = 'false'");

    $j_list = new JSON_list();

    $counter = 0;

    while($row = mysqli_fetch_assoc( $result )) 
    {

        $l[$counter] = $row["start"];

        $counter++;
    }

    echo stripslashes(json_encode($l));

?>