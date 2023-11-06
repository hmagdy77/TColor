<?php
include '../connect.php';
$plan_id         = filterRequest('plan_id');  
$item_num        = filterRequest('item_num');  
$item_done       = filterRequest('item_done'); 
$item_used       = filterRequest('item_used'); 

$stmt = $con->prepare("UPDATE `planitems` SET `item_done` = `item_done`+ ? ,  `item_used` = `item_used`+ ?  WHERE `item_num`= ? AND `plan_id` = ? ");
$stmt->execute(array( $item_done, $item_used, $item_num, $plan_id));
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'suc'));
}else{
    echo json_encode(array('status' => 'fail'));
}
?>

