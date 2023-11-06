<?php
include '../connect.php';
$item_name      = filterRequest('item_name');      //1
$item_num       = filterRequest('item_num');       //2
$item_sup       = filterRequest('item_sup');       //3
$item_price_in  = filterRequest('item_price_in');  //4
$item_price_out = filterRequest('item_price_out'); //5
$item_count     = filterRequest('item_count');     //6
$kind           = filterRequest('kind');           //7
$plan_id        = filterRequest('plan_id');        //8
$item_quant     = filterRequest('item_quant');        //8
$item_quant     = filterRequest('item_quant');        //8
$item_sub_quant     = filterRequest('item_sub_quant');        //8


$stmt = $con->prepare("INSERT INTO `planitems`(`item_name`, `item_num`, `item_sup`, `item_price_in`, `item_price_out`, `item_count`, `kind`, `plan_id`, `item_quant`, `item_sub_quant`)  VALUES (?,?,?,?,?,?,?,?,?,?)");
$stmt->execute(array($item_name, $item_num, $item_sup, $item_price_in,  $item_price_out, $item_count, $kind, $plan_id, $item_quant, $item_sub_quant));
$cont = $stmt->rowCount();
if($cont > 0){
echo json_encode(array('status' => 'suc'));
}else{
echo json_encode(array('status' => 'fail'));
}
?>