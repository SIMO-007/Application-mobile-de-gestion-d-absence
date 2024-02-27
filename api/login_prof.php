<?php

include("dbconn.php");

$email = $_POST['email'];
$password = $_POST['password'];


$stmt = $conn->prepare("SELECT * FROM users WHERE email = ? AND password = ? and role = 'prof'");
$stmt->bind_param("ss",$email, $password);
$stmt->execute();

// Check if user exists
$result = $stmt->get_result();
$row = mysqli_fetch_assoc( $result );

$id = $row['id_user'];
//echo "********************".$_SESSION['id'];
$l = array();

if ($result->num_rows > 0) {
    $l["id_user"] = $id;
    echo stripslashes(json_encode($l));
} else {
    echo "failure";
}




?>