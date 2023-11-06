<?php
include '../connect.php';
$plan_id  = filterRequest('plan_id');  
$stmt = $con->prepare("SELECT * FROM `planitems` WHERE `plan_id` =?");
$stmt->execute(array($plan_id));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc', 'data' =>$data));
}else{
    echo json_encode(array('status' => 'fail', 'data' =>$data));
}
?>