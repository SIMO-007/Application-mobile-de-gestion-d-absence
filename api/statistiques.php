<?php
include("init.php");

class tmp_struct2 {
    public $nom;
    public $prenom;
    public $count;
    
}
class tmp_struct3{

    public $semester;
    public $count;
}

class tmp_struct4{
    public $nom;
    public $prenom;
    public $moyenne;
}




function list1()
{
    global $conn;

    $result = $conn->query("SELECT id_user, COUNT(*) as count FROM `abs` GROUP BY id_user");

    $j_list = array();

    $counter = 0;

    while($row = mysqli_fetch_assoc($result)) 
    {
        $u = new tmp_struct2
    ();
        $res2 = $conn->query("SELECT nom, prenom from users where id_user = ".$row["id_user"]."");
        $r = mysqli_fetch_assoc($res2);
        $u->nom = $r["nom"];
        $u->prenom = $r["prenom"];
        $u->count = $row["count"];

        $j_list[$counter] = $u;

        $counter++;
    }

    return json_encode($j_list);

}

function list2()
{
    global $conn;

    $result = $conn->query("SELECT id_user, COUNT(*) as count FROM `retard` GROUP BY id_user");
    
    $j_list = array();

    $counter = 0;

    while($row = mysqli_fetch_assoc($result)) 
    {
        $res2 = $conn->query("SELECT nom, prenom from users where id_user = ".$row["id_user"]."");
        $r = mysqli_fetch_assoc($res2);
        $u = new tmp_struct2
    ();

        $u->nom = $r["nom"];
        $u->prenom = $r["prenom"];
        $u->count = $row["count"];

        $j_list[$counter] = $u;

        $counter++;
    }

    return json_encode($j_list);

}

function list3()
{
    global $conn;

    $result = $conn->query("SELECT semester, COUNT(*) as count FROM `abs` GROUP BY semester;");

    $j_list = array();

    $counter = 0;

    while($row = mysqli_fetch_assoc($result)) 
    {
        $u = new tmp_struct3
    ();

        $u->semester = $row["semester"];
        $u->count = $row["count"];

        $j_list[$counter] = $u;

        $counter++;
    }

    return json_encode($j_list);

}

function list4()
{
    global $conn;

    $result = $conn->query("SELECT semester, COUNT(*) as count FROM `retard` GROUP BY semester;");

    $j_list = array();

    $counter = 0;

    while($row = mysqli_fetch_assoc($result)) 
    {
        $u = new tmp_struct3
    ();

        $u->semester = $row["semester"];
        $u->count = $row["count"];

        $j_list[$counter] = $u;

        $counter++;
    }

    return json_encode($j_list);

}

function list5()
{
    global $conn;

    $result = $conn->query("SELECT * FROM `notes_bs`");

    $j_list = array();

    $c = 0;

    while($row = mysqli_fetch_assoc($result)) 
    {
        $res2 = $conn->query("SELECT nom, prenom from users where id_user = ".$row["id_user"]."");
        $full = mysqli_fetch_assoc($res2);

        $u = new tmp_struct4
    ();
        //$full = get_student($conn, $row["id_user"]);

        $u->nom = $full["nom"];
        $u->prenom = $full["prenom"];

        $counter = 0;
        $total = 0;

        foreach ($row as $value) 
        {
            if ($counter > 1)
                $total = $total + intval($value);

            $counter++;
        }

        $u->moyenne = number_format((float)($total / ($counter - 2)), 2, '.', '');

        $j_list[$c] = $u;

        $c++;
    }

    return json_encode($j_list);

}

function list6()
{
    global $conn;

    $result = $conn->query("SELECT * FROM `notes_es`");

    $j_list = array();

    $c = 0;

    while($row = mysqli_fetch_assoc($result)) 
    {
        $res2 = $conn->query("SELECT nom, prenom from users where id_user = ".$row["id_user"]."");
        $full = mysqli_fetch_assoc($res2);
        $u = new tmp_struct4
    ();
        //$full = get_student($conn, $row["id_user"]);

        $u->nom = $full["nom"];
        $u->prenom = $full["prenom"];

        $counter = 0;
        $total = 0;

        foreach ($row as $value) 
        {
            if ($counter > 1)
                $total = $total + intval($value);

            $counter++;
        }

        $u->moyenne = number_format((float)($total / ($counter - 2)), 2, '.', '');

        $j_list[$c] = $u;

        $c++;
    }

    return json_encode($j_list);

}

$j_list = array();

$j_list["Nb d'absences totale par étudiant"] = list1();
$j_list["Nb de retards totals par étudiant"] = list2();
$j_list["Nombres d'absences total par semestre"] = list3();
$j_list["Nombres de retards total par semestre"] = list4();
$j_list["Moyenne par etudiant BS"] = list5();
$j_list["Moyenne par etudiant ES"] = list6();

echo json_encode($j_list);
?>
