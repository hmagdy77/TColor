<?php
include '../connect.php';
$plan_id         = filterRequest('plan_id');  
$item_num        = filterRequest('item_num');  
$item_exchange   = filterRequest('item_exchange');  
$item_done       = filterRequest('item_done'); 
$item_used       = filterRequest('item_used'); 
$item_quant_wight       = filterRequest('item_quant_wight'); 

$stmt = $con->prepare("UPDATE `planitems` SET `item_exchange` = `item_exchange`+ ?, `item_done` = `item_done`+ ?, `item_used` = `item_used`+ ?, `item_quant_wight` = `item_quant_wight`+ ?   WHERE `item_num`= ? AND `plan_id` = ? ");
$stmt->execute(array( $item_exchange, $item_done, $item_used, $item_quant_wight, $item_num, $plan_id));                                     
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc'));
}else{
    echo json_encode(array('status' => 'fail'));
}
?>

