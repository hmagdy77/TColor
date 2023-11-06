<?php
include '../connect.php';
$name = filterRequest('name'); 
$des  = filterRequest('des');  
$stmt = $con->prepare("INSERT INTO `plans`(`name`, `des`) VALUES (?,?)");
$stmt->execute(array($name, $des));
$cont = $stmt->rowCount();
if($cont > 0){
echo json_encode(array('status' => 'suc'));
}else{
echo json_encode(array('status' => 'fail'));
}
?>