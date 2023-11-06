<?php
include '../connect.php';
    $bill_id  = filterRequest('bill_id');   
    $stmt = $con->prepare("DELETE FROM `billsin` WHERE `bill_id` = ?");
    $stmt->execute(array($bill_id));
    $cont = $stmt->rowCount();
    if($cont > 0){
        echo json_encode(array('status' => 'suc'));
    }else{
        echo json_encode(array('status' => 'fail'));
    }
?>
