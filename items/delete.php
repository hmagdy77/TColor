<?php
include '../connect.php';
    $item_id        = filterRequest('item_id');   
    $stmt = $con->prepare("DELETE FROM `items` WHERE `item_id` = ?");
    $stmt->execute(array($item_id));
    $cont = $stmt->rowCount();
    if($cont > 0){
        echo json_encode(array('status' => 'suc'));
    }else{
        echo json_encode(array('status' => 'fail'));
    }
?>
