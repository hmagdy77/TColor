<?php
include '../connect.php';
$item_id        = filterRequest('item_id');  
$item_name      = filterRequest('item_name');  
$item_sup       = filterRequest('item_sup');  
$item_price_in  = filterRequest('item_price_in');  
$item_price_out = filterRequest('item_price_out');  
$item_min       = filterRequest('item_min');  
$item_max       = filterRequest('item_max');  
$stmt = $con->prepare("UPDATE `substock` SET `item_name`=?, `item_sup`=?,`item_price_in`=?,`item_price_out`=?, `item_min`=?, `item_max`=? WHERE `item_id`=?");
$stmt->execute(array($item_name, $item_sup, $item_price_in ,$item_price_out , $item_min , $item_max ,$item_id));
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc'));
}else{
    echo json_encode(array('status' => 'fail'));
}
?>

