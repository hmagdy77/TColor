<?php
include '../connect.php';
$item_num       = filterRequest('item_num');  
$item_sub_quant     = filterRequest('item_sub_quant');     
$stmt = $con->prepare("UPDATE `items` SET `item_sub_quant` = `item_sub_quant`+ ?  WHERE `item_num`=?");
$stmt->execute(array($item_sub_quant, $item_num));
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc'));
}else{
    echo json_encode(array('status' => 'fail'));
}
?>

