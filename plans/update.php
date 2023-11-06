<?php
include '../connect.php';
$id               = filterRequest('id');   
$exghange         = filterRequest('exghange'); 
$components_done  = filterRequest('components_done'); 
$proudcts_done    = filterRequest('proudcts_done'); 
$stmt = $con->prepare("UPDATE `plans` SET  `exghange` = `exghange`+ ?, `components_done` = `components_done`+ ?, `proudcts_done` = `proudcts_done`+ ?   WHERE `id`= ?");
$stmt->execute(array($exghange, $components_done, $proudcts_done, $id));
$cont = $stmt->rowCount();
if($cont > 0){
echo json_encode(array('status' => 'suc'));
}else{
echo json_encode(array('status' => 'fail'));
}
?>
