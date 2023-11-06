<?php
include '../connect.php';
$agent_name  = filterRequest('agent_name');  
$agent_phone = filterRequest('agent_phone');  
$stmt = $con->prepare("INSERT INTO `billsout`(`agent_name`, `agent_phone`) VALUES (?,?)");
$stmt->execute(array($agent_name, $agent_phone));
$cont = $stmt->rowCount();
if($cont > 0){
echo json_encode(array('status' => 'suc'));
}else{
echo json_encode(array('status' => 'fail'));
}
?>