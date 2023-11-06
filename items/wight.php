<?php
include '../connect.php';
$item_num       = filterRequest('item_num');  
$item_quant_wight     = filterRequest('item_quant_wight');     
$stmt = $con->prepare("UPDATE `items` SET `item_quant_wight` = `item_quant_wight`+ ?  WHERE `item_num`=?");
$stmt->execute(array($item_quant_wight, $item_num));
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc'));
}else{
    echo json_encode(array('status' => 'fail'));
}
?>

