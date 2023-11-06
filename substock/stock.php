<?php
include '../connect.php';
$item_num       = filterRequest('item_num');  
$item_quant     = filterRequest('item_quant');     
$stmt = $con->prepare("UPDATE `substock` SET `item_quant` = `item_quant`+ ?  WHERE `item_num`=?");
$stmt->execute(array($item_quant, $item_num));
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc'));
}else{
    echo json_encode(array('status' => 'fail'));
}
?>

