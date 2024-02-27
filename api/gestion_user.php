<?php

    include("init.php");

    $nom= mysqli_real_escape_string($conn, $_POST['nom']);
    $prenom= mysqli_real_escape_string($conn, $_POST['prenom']);
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);
    $confirm_password = mysqli_real_escape_string($conn, $_POST['confirm_mdp']);
    $campus =mysqli_real_escape_string($conn, $_POST['campus']);
    $dept = mysqli_real_escape_string($conn,$_POST['dept']);
    $role = 'student';
    $semestre = mysqli_real_escape_string($conn,$_POST['semestre']);

    $query = "SELECT * FROM users WHERE email='$email'";
    $result = mysqli_query($conn, $query);
    $user = mysqli_fetch_assoc($result);
    echo 'SSSSSuccess';
    if ($user) {
        $error_msg = "L'adresse mail existe déjà";
        echo $error_msg;
    } else {
        if ($password !== $confirm_password) {
            $error_msg = 'Veuillez vérifier votre mot de passe';
            echo $error_msg;
        } else {
            $hashed_password = $password;
            echo 'SSSSSuccess';
            mysqli_query($conn, "INSERT INTO users (nom, prenom, email, password,campus,dept,role) VALUES ('$nom', '$prenom', '$email', '$hashed_password', '$campus','$dept','$role')");
        }
    }

?>