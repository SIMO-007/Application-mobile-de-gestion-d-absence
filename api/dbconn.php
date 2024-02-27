<?php
// Configuration de la connexion à la base de données
$host = "localhost";
$username = "root";
$password = "";
$dbname = "flutter";

// Connexion à la base de données
$conn = mysqli_connect($host, $username, $password, $dbname);

// Vérification de la connexion
if (!$conn) {
  echo "Connected unsuccessfully";
  die("Connection failed: " . mysqli_connect_error());
}


?>