<?php
include '../connect.php';
$id     = filterRequest('id');   
$done   = filterRequest('done'); 
$stmt = $con->prepare("UPDATE `plans` SET  `done`=?,  WHERE `id`=?");
$stmt->execute(array($bill_sup, $bill_total, $bill_items, $done, $bill_notes, $id));
$cont = $stmt->rowCount();
if($cont > 0){
echo json_encode(array('status' => 'suc'));
}else{
echo json_encode(array('status' => 'fail'));
}
?>