<?php

abstract class Sex
{
    const MALE = 0;
    const FEMALE = 1;


    public static function getAll() {
        return [ 
            "MALE" => self::MALE, 
            "FEMALE" => self::FEMALE 
        ];
    }
}
