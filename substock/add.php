 <?php
include '../connect.php';
$item_name      = filterRequest('item_name');       //1
$item_num       = filterRequest('item_num');        //2
$item_sup       = filterRequest('item_sup');        //3
$item_price_in  = filterRequest('item_price_in');   //4
$item_price_out = filterRequest('item_price_out');  //5
$item_count     = filterRequest('item_count');      //6
$bill_id        = filterRequest('bill_id');         //7
$item_quant     = filterRequest('item_quant');      //8
$item_min       = filterRequest('item_min');        //9
$item_max       = filterRequest('item_max');        //10
$item_pakage    = filterRequest('item_pakage');     //11
$item_piec      = filterRequest('item_piec');       //12
$kind           = filterRequest('kind');            //13
$ingredients_number  = filterRequest('ingredients_number');            //14
$stmt = $con->prepare("SELECT * FROM `substock` WHERE `item_num` =?");
$stmt->execute(array($item_num));
$cont = $stmt->rowCount();
if($cont > 0){
    echo json_encode(array('status' => 'found'));
}else{
    $stmt = $con->prepare("INSERT INTO `substock`(`item_name`, `item_num`, `item_sup`, `item_price_in`, `item_price_out`, `item_count`, `bill_id`,`item_quant`, `item_min` , `item_max`, `item_pakage`,`item_piec`, `ingredients_number`, `kind`)  VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
    $stmt->execute(array($item_name, $item_num, $item_sup, $item_price_in,  $item_price_out, $item_count, $bill_id, $item_quant, $item_min, $item_max, $item_pakage, $item_piec, $ingredients_number, $kind));
    $cont = $stmt->rowCount();
    if($cont > 0){
    echo json_encode(array('status' => 'suc'));
    }else{
    echo json_encode(array('status' => 'fail'));
    }
}
?> 