<?php
include '../connect.php';
$item_id        = filterRequest('item_id');  
$item_quant     = filterRequest('item_quant');     
$stmt = $con->prepare("UPDATE `ingredients` SET `item_quant`= `item_quant`+ ?  WHERE `item_id`=?");
$stmt->execute(array($item_quant,$item_id));
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc'));
}else{
    echo json_encode(array('status' => 'fail'));
}
?>

