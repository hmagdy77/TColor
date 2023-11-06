<?php
include '../connect.php';
$stmt = $con->prepare("SELECT * FROM `substock` WHERE `item_quant` <> '0.0' AND  `item_quant` <> '0'");
$stmt->execute(array());
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc', 'data' =>$data));
}else{
    echo json_encode(array('status' => 'fail', 'data' =>$data));
}
?>