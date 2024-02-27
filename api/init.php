<?php
// DONE
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "flutter";
//session_start();
$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

class tmp_struct{};
class JSON_list{};

error_reporting(E_ALL);

function get_student($conn, $id)
{
    global $conn, $id;

    $result = $conn->query("SELECT * FROM `users` WHERE role = 'student' AND id_user = '$id'");

    while($row = mysqli_fetch_assoc( $result ))
    {
        return $row;
    }

    return null;
}

function get_matiere_id($mat, $table)
{
    global $conn;

    if($mat == "all")
        return '%';

    $result = $conn->query("SELECT id_mat FROM `$table` WHERE nom = '$mat'");
    
    return mysqli_fetch_assoc( $result )["id_mat"];
}

?>