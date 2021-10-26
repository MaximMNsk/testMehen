<?php

function loader(){
    include "./testEx.php";
    include "./testLib.php";
}

spl_autoload_register('loader');

use test\execute\testEx;
use test\lib\testLib;

$lib = new testLib;
$arr = $lib->generateArray(10, 100);
$needle = 8;
$ex = new testEx($arr, $needle);


print "Array: \n";
print_r($arr);

print "Search {$needle} v1: \n";
$res = $ex->arrayNearestV1();
print "Result: {$res} \n\n";

print "Search {$needle} v2: \n";
$res = $ex->arrayNearestV2();
print "Result: {$res} \n";
print_r($res);
