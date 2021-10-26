<?php

namespace test\execute;

class testEx
{

    public $arr = null;
    public $needle = null;
    public $result = null;

    /**
     * @param array $arr    - array as a param
     * @param int $needle   - search value as a param
     */
    public function __construct(array $arr, int $needle)
    {
        $this->arr = $arr;
        $this->needle = $needle;
    }

    /**
     * Choose nearest int from array v1
     * @return int|false
     */
    public function arrayNearestV1(){
        if(!is_array($this->arr) || !$this->needle) return false;
        $arr = self::sortArray($this->arr, 'asc');
        $prevV = -1;
        foreach($arr as $k=>$v){
            if($v-$this->needle == 0){
                return array_search($v, $this->arr);
            }
            elseif( ($v-$this->needle > 0) && ($prevV-$this->needle < 0) ){
                if( abs($v-$this->needle) > abs($prevV-$this->needle) ){
                    if($prevV !== -1) return array_search($prevV, $this->arr);
                    else return array_search($v, $this->arr);
                } 
                else return array_search($v, $this->arr);
            }
            $prevV = $v;
        }
    }
    
    /**
     * Choose nearest int from array v2
     * @return array
     */
    public function arrayNearestV2(){
        $i=0;
        while(true){
            if( false!==($k=array_search($this->needle+$i, $this->arr)) ) return $k;
            if( false!==($k=array_search($this->needle-$i, $this->arr)) ) return $k;
            $i++;
        }
    }

    public function arrayNearestV3(){
        /**
         * As Index works (half delimiter)
         */
    }

    public function arrayNearestV4(){
        /**
         * Using usort
         */
    }



    /**
     * Sort array
     * @param array $arr    - input array
     * @param string $order - order (asc, desc)
     * @return array|false
     */
    public static function sortArray(array $arr, string $order){
        if( is_array($arr) ){
            if( $order === 'asc' ){
                sort($arr);
            }elseif($order === 'desc'){
                sort($arr);
                array_reverse($arr);
            }else{
                $arr = [];
            }
        }else{
            $arr = false;
        }
        return $arr;
    }

}