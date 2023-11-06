<?php
include '../connect.php';
    $user_id        = filterRequest('user_id');   
    $stmt = $con->prepare("DELETE FROM `users` WHERE `user_id` = ?");
    $stmt->execute(array($user_id));
    $cont = $stmt->rowCount();
    if($cont > 0){
        echo json_encode(array('status' => 'suc'));
    }else{
        echo json_encode(array('status' => 'fail'));
    }
?>
