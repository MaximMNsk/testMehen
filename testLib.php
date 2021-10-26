<?php

namespace test\lib;

class testLib
{
    public static function generateArray(int $len, int $maxItem){
        $arr = [];
        for($i=1;$i<$len;$i++){
            $arr[$i] = rand(0, $maxItem);
        }
        return $arr;
    }
}