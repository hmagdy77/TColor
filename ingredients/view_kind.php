<?php
include '../connect.php';
$is_back   = filterRequest('is_back');  
$stmt = $con->prepare("SELECT * FROM items WHERE `is_back` = ?");
$stmt->execute(array($is_back));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc', 'data' =>$data));
}else{
    echo json_encode(array('status' => 'fail', 'data' =>$data));
}
?>