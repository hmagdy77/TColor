<?php 
include '../connect.php';
$bill_sup       = filterRequest('bill_sup');        //1
$plan_id        = filterRequest('plan_id');         //2
$kind           = filterRequest('kind');            //3
$bill_id        = filterRequest('bill_id');         //4
$bill_items     = filterRequest('bill_items');      //5 
$bill_total     = filterRequest('bill_total');      //6 
$bill_timestamp = filterRequest('bill_timestamp');  //7 
$bill_payment   = filterRequest('bill_payment');    //8
$bill_notes     = filterRequest('bill_notes');      //9
$work_name      = filterRequest('work_name');       //10
$stmt = $con->prepare("UPDATE `billsfactory` SET `bill_sup`=?,`plan_id` = ?, `kind` = ?,`bill_total`=? ,`bill_items`=? ,`bill_timestamp`=?, `bill_payment` =? ,`bill_notes`=?, `work_name`=? WHERE `bill_id`=?");
$stmt->execute(array($bill_sup, $plan_id, $kind, $bill_total, $bill_items, $bill_timestamp, $bill_payment, $bill_notes, $work_name, $bill_id));
$cont = $stmt->rowCount();
if($cont > 0){
echo json_encode(array('status' => 'suc'));
}else{
echo json_encode(array('status' => 'fail'));
}
?>