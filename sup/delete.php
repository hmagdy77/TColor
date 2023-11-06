<?php
include '../connect.php';
    $sup_id  = filterRequest('sup_id');   
    $stmt = $con->prepare("DELETE FROM `suppliers`  WHERE `sup_id` = ?");
    $stmt->execute(array($sup_id));
    $cont = $stmt->rowCount();
    if($cont > 0){
        echo json_encode(array('status' => 'suc'));
    }else{
        echo json_encode(array('status' => 'fail'));
    }
?>
