<?php
include '../connect.php';
$item_name      = filterRequest('item_name');      //1
$item_num       = filterRequest('item_num');       //2
$item_sup       = filterRequest('item_sup');       //3
$item_price_in  = filterRequest('item_price_in');  //4
$item_price_out = filterRequest('item_price_out'); //5
$item_count     = filterRequest('item_count');     //6
$bill_id        = filterRequest('bill_id');        //7
$stock_id       = filterRequest('stock_id');       //8
$kind           = filterRequest('kind');           //9
$item_time      = filterRequest('item_time');      //10

$stmt = $con->prepare("INSERT INTO `billshortageitems`(`item_name`, `item_num`, `item_sup`, `item_price_in`, `item_price_out`, `item_count`, `bill_id`,`stock_id`, `kind`, `item_time`)  VALUES (?,?,?,?,?,?,?,?,?,?)");
$stmt->execute(array($item_name, $item_num, $item_sup, $item_price_in,  $item_price_out, $item_count, $bill_id, $stock_id, $kind, $item_time));
$cont = $stmt->rowCount();
if($cont > 0){
echo json_encode(array('status' => 'suc'));
}else{
echo json_encode(array('status' => 'fail'));
}
?>