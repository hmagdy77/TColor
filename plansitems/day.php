<?php
include '../connect.php';
$item_time    = filterRequest('item_time');  
$stmt = $con->prepare("SELECT * from planitems where `item_time`=? ");
$stmt->execute(array($item_time ));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc', 'data' =>$data));
}else{
    echo json_encode(array('status' => 'fail', 'data' =>$data));
}
?>