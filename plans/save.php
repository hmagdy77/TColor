<?php 
include '../connect.php';
$id         = filterRequest('id');    //1
$name       = filterRequest('name'); //2
$des        = filterRequest('des');   //3
$done       = filterRequest('done');   //4 
$date       = filterRequest('date');   //5 
$components = filterRequest('components'); 
$proudcts   = filterRequest('proudcts'); 
$work_name      = filterRequest('work_name');       //10

$stmt = $con->prepare("UPDATE `plans` SET `name`= ?, `des` = ?, `date`= ?, `done`= ?, `components`=?, `proudcts`=?, `work_name`=?  WHERE `id`=?");
$stmt->execute(array($name, $des, $date, $done, $components, $proudcts, $work_name, $id));
$cont = $stmt->rowCount();
if($cont > 0){
echo json_encode(array('status' => 'suc'));
}else{
echo json_encode(array('status' => 'fail'));
}
?>