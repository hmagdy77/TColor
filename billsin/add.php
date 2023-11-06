<?php
include '../connect.php';
$bill_sup = filterRequest('bill_sup');  
$stmt = $con->prepare("INSERT INTO `billsin`(`bill_sup`) VALUES (?)");
$stmt->execute(array($bill_sup));
$cont = $stmt->rowCount();
if($cont > 0){
echo json_encode(array('status' => 'suc'));
}else{
echo json_encode(array('status' => 'fail'));
}
?>