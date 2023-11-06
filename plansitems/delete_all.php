<?php
include '../connect.php';
    $plan_id  = filterRequest('plan_id');   
    $stmt = $con->prepare("DELETE FROM `planitems` WHERE `plan_id` = ?");
    $stmt->execute(array($plan_id));
    $cont = $stmt->rowCount();
    if($cont > 0){
        echo json_encode(array('status' => 'suc'));
    }else{
        echo json_encode(array('status' => 'fail'));
    }
?>
