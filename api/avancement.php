<?php
include("init.php");

// Check the operation parameter

    $operation = $_GET["op"];

    switch ($operation) {
        case "matiere":
            if (isset($_POST['matiere'])) {
                $matiere = $_POST['matiere'];
                $idMat = get_matiere($matiere);
                echo json_encode(['id_mat' => $idMat]);
            }
            break;
        case "user":
            if (isset($_POST['id'])) {
                $id = $_POST['id'];
                $user = get_user($id);
                echo json_encode($user);
            }
            break;
        case "prof":
            if (isset($_POST['name'])) {
                $name = $_POST['name'];
                $prof = get_prof_by_name($name);
                echo json_encode($prof);
            }
            break;
        case "list1":
            list1();

            break;
        case "list5":
            list5();
            break;
        case "list6":
            list6();
            break;
        case "list3":
            list3();
            break;
        default:
            echo "Invalid operation";
            break;
    }

function get_matiere($mat)
{
    global $conn, $table;

    $result = $conn->query("SELECT id_mat FROM `$table` WHERE nom = '$mat'");

    return mysqli_fetch_assoc($result)['id_mat'];
}

function get_user($id)
{
    global $conn;

    $result = $conn->query("SELECT * FROM `users` WHERE id_user = '$id'");

    while ($row = mysqli_fetch_assoc($result)) {
        return $row;
    }

    return null;
}

function get_prof_by_name($name)
{
    global $conn;

    $first = explode(" ", $name)[0];
    $last = explode(" ", $name)[1];
    //echo "first:".$first;
    //echo "last : ".$last;
    $result = $conn->query("SELECT * FROM users WHERE role = 'prof' AND nom = '$first' AND prenom = '$last'");
    //$result = $conn->query("SELECT * FROM users ");
    if ($row = mysqli_fetch_assoc($result)) {
        return $row['id_user'];
    }

    return null;
}

function list1()
{
    global $conn;

    $id = get_prof_by_name($_GET["name"]);
    //echo "the issss:::".$id;
    $result = $conn->query("SELECT * FROM calendrier WHERE id_professeur = ".$id);
    $counter = 0;
    $completed = 0;
    $data = array();

    while ($row = mysqli_fetch_assoc($result)) {
        if ($row["done"] == "0") {
            $data[$completed] = $row['start'];
            $completed++;
        }
        $counter++;
    }
    $data["score"] = (($completed/$counter)*100);
    echo json_encode($data);
}

function list5()
{
    global $conn;

    $result = $conn->query("SELECT * FROM `notes_bs`");

    $data = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $full = get_user($row["id_user"]);

        if ($full["semester"] == $_POST["id_check"]) {
            $entry = [
                'Nom' => $full["nom"],
                'Prenom' => $full["prenom"],
                'Semester' => $full["semester"]
            ];

            $counter = 0;
            $total = 0;

            foreach ($row as $key => $value) {
                if ($counter > 1) {
                    $entry[$key] = $value;
                    $total = $total + intval($value);
                }
                $counter++;
            }

            $entry['Moyenne'] = number_format((float)$total / ($counter - 2), 2, '.', '');

            $data[] = $entry;
        }
    }

    echo json_encode($data);
}

function list6()
{
    global $conn;

    $result = $conn->query("SELECT * FROM `notes_es`");

    $data = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $full = get_user($row["id_user"]);

        if ($full["semester"] == $_POST["id_check"]) {
            $entry = [
                'Nom' => $full["nom"],
                'Prenom' => $full["prenom"],
                'Semester' => $full["semester"]
            ];

            $counter = 0;
            $total = 0;

            foreach ($row as $key => $value) {
                if ($counter > 1) {
                    $entry[$key] = $value;
                    $total = $total + intval($value);
                }
                $counter++;
            }

            $entry['Moyenne'] = number_format((float)$total / ($counter - 2), 2, '.', '');

            $data[] = $entry;
        }
    }

    echo json_encode($data);
}

function list3()
{
    global $conn;

    $result = $conn->query("SELECT * FROM mat_bs UNION SELECT * FROM mat_es");

    $data = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $entry = [
            'Nom' => $row["nom"],
            'VH' => $row["VH"],
            'Semester' => $row["semester"]
        ];

        $data[] = $entry;
    }

    echo json_encode($data);
}
