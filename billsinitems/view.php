<?php
include '../connect.php';
$bill_id  = filterRequest('bill_id');  
$stmt = $con->prepare("SELECT * FROM `billinitems` WHERE `bill_id` =?");
$stmt->execute(array($bill_id));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc', 'data' =>$data));
}else{
    echo json_encode(array('status' => 'fail', 'data' =>$data));
}
?>