<?php
// $dsn = "mysql:host=sql107.epizy.com	;dbname=epiz_33134058_resturant";
// $user = "epiz_33134058";
// $pass = "3DfpnUQb9Z5t";
include 'functions.php';
$dsn = "mysql:host=localhost;dbname=stock";
$user = "root";
$pass = "";
$option = array(
    PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES UTF8" // FOR Arabic
);
try {
    $con = new PDO($dsn , $user , $pass , $option ); 
    $con->setAttribute(PDO::ATTR_ERRMODE , PDO::ERRMODE_EXCEPTION) ;

}catch(PDOException $e){
  echo $e->getMessage() ;        
}