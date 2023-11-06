<?php
include '../connect.php';
$item_name      = filterRequest('item_name');       //1
$item_num       = filterRequest('item_num');        //2
$item_sup       = filterRequest('item_sup');        //3
$item_price_in  = filterRequest('item_price_in');   //4
$item_price_out = filterRequest('item_price_out');  //5
$item_count     = filterRequest('item_count');      //6
$bill_id        = filterRequest('bill_id');         //7
$stock_id       = filterRequest('stock_id');        //8
$plan_id        = filterRequest('plan_id');         //9
$kind           = filterRequest('kind');           //10
$item_time      = filterRequest('item_time');  
$stmt = $con->prepare("INSERT INTO `billoutitems`(`item_time`, `item_name`, `item_num`, `item_sup`, `item_price_in`, `item_price_out`, `item_count`, `bill_id`,`stock_id`, `plan_id`,`kind`)  VALUES (?,?,?,?,?,?,?,?,?,?,?)");
$stmt->execute(array($item_time, $item_name, $item_num, $item_sup, $item_price_in,  $item_price_out, $item_count, $bill_id, $stock_id, $plan_id, $kind));
$cont = $stmt->rowCount();
if($cont > 0){
echo json_encode(array('status' => 'suc'));
}else{
echo json_encode(array('status' => 'fail'));
}
?>