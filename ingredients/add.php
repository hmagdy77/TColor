 <?php
include '../connect.php';
$item_name      = filterRequest('item_name');       //1
$item_num       = filterRequest('item_num');        //2
$item_sup       = filterRequest('item_sup');        //3
$item_price_in  = filterRequest('item_price_in');   //4
$item_price_out = filterRequest('item_price_out');  //5
$item_count     = filterRequest('item_count');      //6
$ingredients_number = filterRequest('ingredients_number');//7
$item_quant     = filterRequest('item_quant');      //8
$stock_id       = filterRequest('stock_id');        //9
$item_pakage    = filterRequest('item_pakage');     //10
$item_piec      = filterRequest('item_piec');       //11
$kind           = filterRequest('kind');            //12

$stmt = $con->prepare("INSERT INTO `ingredients`(`item_name`, `item_num`, `item_sup`, `item_price_in`, `item_price_out`, `item_count`, `ingredients_number`, `stock_id`, `item_quant`, `item_pakage`, `item_piec`, `kind`) VALUES  (?,?,?,?,?,?,?,?,?,?,?,?)");
$stmt->execute(array($item_name, $item_num, $item_sup, $item_price_in,  $item_price_out, $item_count, $ingredients_number, $stock_id,  $item_quant,  $item_pakage, $item_piec, $kind));
$cont = $stmt->rowCount();
    if($cont > 0){
      echo json_encode(array('status' => 'suc'));
    }else{
      echo json_encode(array('status' => 'fail'));
    }
?> 