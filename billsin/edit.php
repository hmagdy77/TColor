<?php
include '../connect.php';
$bill_sup       = filterRequest('bill_sup');    //1
$bill_id        = filterRequest('bill_id');     //2
$bill_items     = filterRequest('bill_items');  //3
$bill_total     = filterRequest('bill_total');  //4
$bill_payment   = filterRequest('bill_payment');//5
$bill_notes     = filterRequest('bill_notes');  //6
// $bill_timestamp = filterRequest('bill_timestamp');  
$stmt = $con->prepare("UPDATE `billsin` SET `bill_sup`=?,`bill_total`=? ,`bill_items`=?, `bill_payment`=?, `bill_notes`=?  WHERE `bill_id`=?");
$stmt->execute(array($bill_sup, $bill_total, $bill_items, $bill_payment, $bill_notes, $bill_id));
$cont = $stmt->rowCount();
if($cont > 0){
echo json_encode(array('status' => 'suc'));
}else{
echo json_encode(array('status' => 'fail'));
}
?>