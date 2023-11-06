<?php
include '../connect.php';
// $bill_sup = filterRequest('bill_sup');  
$bill_id              = filterRequest('bill_id');         //1
$plan_id             = filterRequest('plan_id');        //2
$work_name             = filterRequest('work_name');        //2
$kind                 = filterRequest('kind');            //3
$bill_items           = filterRequest('bill_items');      //4
$bill_total           = filterRequest('bill_total');      //5
$bill_sup             = filterRequest('bill_sup');        //6
$bill_payment         = filterRequest('bill_payment');    //7
$agent_name           = filterRequest('agent_name');      //8
$agent_phone          = filterRequest('agent_phone');     //9
$bill_notes           = filterRequest('bill_notes');      //10
$bill_timestamp       = filterRequest('bill_timestamp');  //11
$stmt = $con->prepare("UPDATE `billsout` SET `plan_id`=?, `kind`=?, `work_name`=?, `bill_total`=?, `bill_sup`=?, `bill_payment`=?, `bill_items`=?, `bill_timestamp`=?, `agent_name`=?, `agent_phone`=?, `bill_notes`=? WHERE `bill_id`=?");
$stmt->execute(array($plan_id, $kind, $work_name, $bill_total, $bill_sup, $bill_payment, $bill_items, $bill_timestamp, $agent_name, $agent_phone, $bill_notes, $bill_id));
$cont = $stmt->rowCount();
if($cont > 0){
echo json_encode(array('status' => 'suc'));
}else{
echo json_encode(array('status' => 'fail'));
}
?>