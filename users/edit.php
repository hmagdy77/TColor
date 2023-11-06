<?php
include '../connect.php';
$user_id        = filterRequest('user_id');  
$user_name      = filterRequest('user_name');  
$user_password  = filterRequest('user_password');  
$name           = filterRequest('name');  
$stmt = $con->prepare("UPDATE `users` SET `user_name`=?,  `name`=?, `user_password`=? WHERE `user_id`=?");
$stmt->execute(array($user_name, $name, $user_password, $user_id));
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc'));
}else{
    echo json_encode(array('status' => 'fail'));
}
?>

