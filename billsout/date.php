<?php
include '../connect.php';
$start_date  = filterRequest('start_date');   
$end_date    = filterRequest('end_date');   
$kind     = filterRequest('kind');  
$stmt = $con->prepare("SELECT SUM(bill_after_discount) from billsout where `kind`=? AND `bill_timestamp` BETWEEN ? AND ? ");
$stmt->execute(array($kind, $start_date, $end_date));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc', 'data' =>$data));
}else{
    echo json_encode(array('status' => 'fail', 'data' =>$data));
}
?>