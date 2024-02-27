<?php
	// DONE

	include("init.php");

	 if($_POST["op"] == "submit_absence_prol")
	{
	    $id_mat = get_matiere_id($_POST["matiere"]);
	    $semester = $_POST["sem"];
	    $id = $_POST["id"];
	    $filiere = $_POST["filiere"];

	    $result = $conn->query("SELECT * FROM calendrier WHERE id_professeur IN (SELECT id_user FROM `users` WHERE role = 'prof' AND semester = '$semester') AND done = '0' AND start BETWEEN '".$_POST["start"]."' AND '".$_POST["end"]."'");


	    while($row = mysqli_fetch_assoc( $result ))
	    {
	        $conn->query("INSERT INTO `abs`(`id_user`, `id_mat`, `dept`, `semester`, `date`) VALUES ('$id','$id_mat','$filiere','$semester','".$row['start']."')");
	    }

	}
	else if($_POST["op"] == "send_justif" )
	{
		$id_abs = $_POST["id_abs"];
		$conn->query("UPDATE `abs` SET `motif`='".$_POST["justif"]."' WHERE id_abs = '$id_abs'");
	}
	else if($_POST["op"] == "send_justif_retard" )
	{
		$id_retard = $_POST["id_retard"];
		$conn->query("UPDATE `abs` SET `motif`='".$_POST["justif"]."' WHERE id_retard = '$id_retard'");
	}

?>