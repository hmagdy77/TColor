 
<?php
include '../connect.php';
$item_id        = filterRequest('item_id');  
$item_count     = filterRequest('item_count');       
$stmt = $con->prepare("UPDATE `ingredients` SET  `item_count`= ?  WHERE  `item_id`= ? ");
$stmt->execute(array($item_count, $item_id));
$cont = $stmt->rowCount();
    if($cont > 0){
      echo json_encode(array('status' => 'suc'));
    }else{
      echo json_encode(array('status' => 'fail'));
    }
?> 