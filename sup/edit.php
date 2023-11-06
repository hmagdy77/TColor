<?php
include '../connect.php';
$sup_id    = filterRequest('sup_id');  
$sup_name  = filterRequest('sup_name');  
$sup_tel   = filterRequest('sup_tel');  
$stmt = $con->prepare("UPDATE `suppliers` SET `sup_name`=? , `sup_tel`=? WHERE `sup_id`=?");
$stmt->execute(array($sup_name, $sup_tel, $sup_id));
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc'));
}else{
    echo json_encode(array('status' => 'fail'));
}
?>