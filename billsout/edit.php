<?php
include '../connect.php';
$bill_sup             = filterRequest('bill_sup');            //1
$bill_id              = filterRequest('bill_id');             //2
// $bill_items           = filterRequest('bill_items');          //3
$bill_total           = filterRequest('bill_total');          //4
$bill_discount        = filterRequest('bill_discount');       //5
$bill_after_discount  = filterRequest('bill_after_discount'); //6
$bill_paid            = filterRequest('bill_paid');           //7
$bill_unpaid          = filterRequest('bill_unpaid');         //8
$agent_name           = filterRequest('agent_name');          //9
$agent_phone          = filterRequest('agent_phone');         //10
$bill_notes           = filterRequest('bill_notes');          //11
$stmt = $con->prepare("UPDATE `billsout` SET `bill_sup`=?,`bill_total`=?, `bill_discount`=?, `bill_after_discount`=?, `bill_paid`=?, `bill_unpaid`=?, `agent_name`=?, `agent_phone`=? ,`bill_notes`=? WHERE `bill_id`=?");
$stmt->execute(array($bill_sup, $bill_total, $bill_discount, $bill_after_discount, $bill_paid, $bill_unpaid, $agent_name, $agent_phone, $bill_notes, $bill_id));
$cont = $stmt->rowCount();
if($cont > 0){
echo json_encode(array('status' => 'suc'));
}else{
echo json_encode(array('status' => 'fail'));
}
?>