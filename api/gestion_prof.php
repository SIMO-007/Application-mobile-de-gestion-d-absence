
<?php
    include("init.php");

    $nom= mysqli_real_escape_string($conn, $_POST['nom']);
    $prenom= mysqli_real_escape_string($conn, $_POST['prenom']);
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);
    $confirm_password = mysqli_real_escape_string($conn, $_POST['confirm_mdp']);
    $campus =mysqli_real_escape_string($conn, $_POST['campus']);
    $dept = mysqli_real_escape_string($conn,$_POST['dept']);
    $role = 'prof';
    $semestre = mysqli_real_escape_string($conn,$_POST['semestre']);

    $query = "SELECT * FROM users WHERE email='$email'";
    $result = mysqli_query($conn, $query);
    $user = mysqli_fetch_assoc($result);

    if ($user) {
        $error_msg = "L'adresse mail existe déjà";
    } else {
        if ($password !== $confirm_password) {
            $error_msg = 'Veuillez vérifier votre mot de passe';
        } else {
            $hashed_password = $password;

            if ($stmt = mysqli_prepare($conn, "INSERT INTO users (nom, prenom, email, password,campus,dept,role) VALUES ($nom, $prenom, $email, $hashed_password $campus,$dept,$role)")) {
                mysqli_stmt_execute($stmt);
                mysqli_stmt_close($stmt);
                $success_msg = 'Inscription réussie. Veuillez vous connecter pour continuer.';
            } else {
                $error_msg = 'Erreur lors de l\'insertion des données utilisateur';
            }
        }
    }

?>