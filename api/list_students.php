<?php
include("init.php");

class Student {
    public $id_user;
    public $nom;
    public $prenom;
}

$result = $conn->query("SELECT * FROM users WHERE role = 'student' AND campus = '".$_GET["campus"]."' AND dept = '".$_GET["dept"]."' AND semester = '".$_GET["semester"]."' AND class = '".$_GET["class"]."'");

$j_list = array();
$counter = 0;

while($row = mysqli_fetch_assoc($result)) {
    $student = new Student();
    $student->id_user = $row["id_user"];
    $student->nom = $row["nom"];
    $student->prenom = $row["prenom"];

    $j_list[$counter] = $student;
    $counter++;
}

echo stripslashes(json_encode($j_list));
?>







