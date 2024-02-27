<?php
    include("init.php");
    $nom = mysqli_real_escape_string($conn,$_POST['nom']);
    $nom_prof = mysqli_real_escape_string($conn,$_POST['nomprof']);
    $vh = mysqli_real_escape_string($conn,$_POST['vh']);
    $semestre = mysqli_real_escape_string($conn,$_POST['semester']);

    $tmp = explode(' ',$nom_prof);
    $query = "SELECT id_user FROM users WHERE nom = '$tmp[0]' AND prenom = '$tmp[1]'";
    $conn->query($query);

    if ($_POST["dept"] == "ES")
        $table = "mat_es";
    else
        $table = "mat_bs";
    
    $result = mysqli_query($conn, $query);
    $id_user = mysqli_fetch_assoc($result)['id_user'];

    if ($result !== false) 
    {    
        
        $conn->query("INSERT INTO $table(nom,vh,semester,id_prof) VALUES ('$nom','$vh','$semestre','$id_user')");
        echo "Record added successfully!";
    } else {
        echo "Professor not found";
    }
?>