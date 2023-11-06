<?php
include '../connect.php';
$sup_name      = filterRequest('sup_name');  
$sup_tel       = filterRequest('sup_tel');  
$stmt = $con->prepare("SELECT * FROM `suppliers` WHERE `sup_tel` =?");
$stmt->execute(array($sup_tel));
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'found'));
}else{
$stmt = $con->prepare("INSERT INTO `suppliers`(`sup_name`, `sup_tel`) VALUES (?,?)");
$stmt->execute(array($sup_name, $sup_tel));
$cont = $stmt->rowCount();
if($cont > 0){
echo json_encode(array('status' => 'suc'));
}else{
echo json_encode(array('status' => 'fail'));
}
}



?>