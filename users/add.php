 <?php
include '../connect.php';
$name            = filterRequest('name');  
$user_name       = filterRequest('user_name');  
$user_password   = filterRequest('user_password');  
$user_kind       = filterRequest('user_kind');  
$stmt = $con->prepare("SELECT * FROM `users` WHERE `user_name` =?");
$stmt->execute(array($user_name));
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'found'));
}else{
    $stmt = $con->prepare("INSERT INTO `users`(`name`, `user_name`, `user_password`, `user_kind`)  VALUES (?,?,?,?)");
    $stmt->execute(array($name, $user_name, $user_password, $user_kind));
    $cont = $stmt->rowCount();
    if($cont > 0){
    echo json_encode(array('status' => 'suc'));
    }else{
    echo json_encode(array('status' => 'fail'));
    }
}
?> 