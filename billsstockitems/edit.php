<?php
include '../connect.php';
$item_id        = filterRequest('item_id');  
$item_name      = filterRequest('item_name');  
$item_num       = filterRequest('item_num');  
$item_sup       = filterRequest('item_sup');  
$item_price_in  = filterRequest('item_price_in');  
$item_price_out = filterRequest('item_price_out');  
$item_count     = filterRequest('item_count');  
$bill_id        = filterRequest('bill_id');  
$stmt = $con->prepare("UPDATE `billstockitems` SET `item_name` = ?,`item_num` = ?,`item_sup` = ?,`item_price_in` = ?,`item_price_out` = ?,`item_count` = ?,`bill_id` = ? WHERE `item_id` = ?");
$stmt->execute(array($item_name, $item_num, $item_sup, $item_price_in ,$item_price_out , $item_count, $bill_id ,$item_id));
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc'));
}else{
    echo json_encode(array('status' => 'fail'));
}
?>

