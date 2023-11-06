<?php
include '../connect.php';
$start_date  = filterRequest('start_date');   
$end_date    = filterRequest('end_date');   
$item_num    = filterRequest('item_num');  
$stmt = $con->prepare("SELECT * from billsfactoryitems where `item_num`=? AND `item_time` BETWEEN ? AND ? ");
$stmt->execute(array($item_num, $start_date, $end_date));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc', 'data' =>$data));
}else{
    echo json_encode(array('status' => 'fail', 'data' =>$data));
}
?>