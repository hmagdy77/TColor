<?php
include '../connect.php';
$user_name =   filterRequest('user_name');
$stmt = $con->prepare("SELECT * FROM `users` WHERE `user_name` = ? ");
$stmt->execute(array($user_name));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc', 'data' =>$data));
}else{
    echo json_encode(array('status' => 'fail', 'data' =>$data));
}
?>