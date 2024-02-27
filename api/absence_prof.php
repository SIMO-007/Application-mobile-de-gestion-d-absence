<?php
    // DONE
    include("init.php");

    function condition_absences($id)
    {
        global $conn;

        $sql = "SELECT `id_mat`, count(*) as nb FROM `abs` group by `id_mat`,`id_user` having `id_user` = '$id'";
        
        $res = mysqli_query($conn,$sql);
        $tot = 0;
    
        $sql1= "SELECT dept FROM `users` WHERE id_user = '$id'";
        $res1 = mysqli_query($conn,$sql1);
    
        $r =  mysqli_fetch_assoc($res1);
        $dept = $r['dept'];
        
        $d = "";
    
        if ($dept == "ES"){
            $d = "es";
        }
        else {
            $d = "bs";
        }
    
        while ($row = mysqli_fetch_assoc($res)){
            $tot = $tot + $row['nb'];
            
            if ($row['nb'] == 3 ){
                $id_mat = $row['id_mat'];
               
                $sql2 = "SELECT `nom` FROM mat_" . $d . " WHERE id_mat = '$id_mat'";
                $res2 = mysqli_query($conn,$sql2);
                
                $r =  mysqli_fetch_assoc($res2);
                $mat = $r['nom'];
                
                $sql3 = "update notes_" . $d ." set note_" . $mat ." =  note_" . $mat ." - 1 where id_user = '$id'" ;
                mysqli_query($conn,$sql3);    
            }
            else if ($row['nb'] == 6 ){
                $id_mat = $row['id_mat'];
               
                $sql2 = "SELECT `nom` FROM mat_" . $d . " WHERE id_mat = '$id_mat'";
                $res2 = mysqli_query($conn,$sql2);
                
                $r =  mysqli_fetch_assoc($res2);
                $mat = $r['nom'];
                
                $sql3 = "update notes_" . $d ." set note_" . $mat ." = 0 where id_user = '$id'" ;
                mysqli_query($conn,$sql3);    
            }
    
        }
        if ( $tot == 20 ){
            $sql4 = "UPDATE `users` SET `rachat` = `rachat` - 1 WHERE `id_user` = '$id'";
            mysqli_query($conn,$sql4);
        }
    
        else if ( $tot == 40 ){
            $sql4 = "UPDATE `users` SET `rachat` = `rachat` - 2 WHERE `id_user` = '$id'";
            mysqli_query($conn,$sql4);
        }
    
        else if ( $tot == 72 ){
            $sql4 = "UPDATE `users` SET `redoublant` = 1 WHERE `id_user` = '$id'";
            mysqli_query($conn,$sql4);
        }
        
    }

    $op = $_GET["op"];
    $id_user = $_GET["id_user"];
    
    //echo "***BODY : ".$_GET["id_user"];
    if( $op == "absent" )
    {
        $res = $conn->query("SELECT * from mat_".$_GET["dept"]." WHERE id_prof =".$id_user."");
        $row = mysqli_fetch_assoc( $res );
        $id_mat = get_matiere_id($row["nom"], "mat_".$_GET["dept"]);
        //$rows = get_student($conn, $id);
        $conn->query("INSERT INTO `abs`(`id_user`, `id_mat`, `dept`, `semester`, `date`) VALUES ('".$id_user."','".$id_mat."','".$_GET["dept"]."','".$_GET["semester"]."','".$_GET["date"]."')");
        
    }
    else if( $op == "retard" )
    {
        $res = $conn->query("SELECT * from mat_".$_GET["dept"]." WHERE id_prof =".$id_user."");
        $row = mysqli_fetch_assoc( $res );
        $id_mat = get_matiere_id($row["nom"], "mat_".$_GET["dept"]);
        $row = get_student($conn, $id);
        $conn->query("INSERT INTO `retard`(`id_user`, `id_mat`, `dept`, `temps`, `semester`, `date`) VALUES ('".$id_user."','".$id_mat."','".$_GET["dept"]."','".$_GET["nums"]."','".$_GET["semester"]."','".$_GET["date"]."')");
    }
    else if( $op == "getdate" )
    {
        
        $result = $conn->query("SELECT start FROM calendrier WHERE done = 0 and id_professeur = '".$id_user."'");
        
        $l = array();

        $counter = 0;

        while($row = mysqli_fetch_assoc( $result )) 
        {
    
            $l[$counter] = $row["start"];
    
            $counter++;
            
        }
        echo stripslashes(json_encode($l));
    }


    condition_absences($id_user);
    if (isset($_GET["date"])){
    $conn->query("UPDATE `calendrier` SET `done`='1' WHERE `start`='".$_GET["date"]."'");
    }
?> 