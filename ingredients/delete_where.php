<?php
include '../connect.php';
    $ingredients_number  = filterRequest('ingredients_number');   
    $stmt = $con->prepare("DELETE FROM `ingredients` WHERE `ingredients_number` = ?");
    $stmt->execute(array($ingredients_number));
    $cont = $stmt->rowCount();
    if($cont > 0){
        echo json_encode(array('status' => 'suc'));
    }else{
        echo json_encode(array('status' => 'fail'));
    }
?>
