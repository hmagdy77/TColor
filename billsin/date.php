<?php
include '../connect.php';
$start_date  = filterRequest('start_date');   
$end_date    = filterRequest('end_date');   
$is_back     = filterRequest('is_back');  
$stmt = $con->prepare("SELECT SUM(bill_total) from billsin where `is_back`=? AND `bill_timestamp` BETWEEN ? AND ? ");
$stmt->execute(array($is_back, $start_date, $end_date));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc', 'data' =>$data));
}else{
    echo json_encode(array('status' => 'fail', 'data' =>$data));
}
?>