<?php
// Source: http://stackoverflow.com/questions/3770513/detect-browser-language-in-php
// Modified for Wordpress by Ertuğrul Harman @ ertugrulharman.com
// 20.03.2016
define('WP_USE_THEMES', true);
$lang = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 2);
switch ($lang){
    case "tr":
        //echo "PAGE TR";
//        include("/tr/index.php");//include check session TR
    require( dirname( __FILE__ ) . '/tr/wp-blog-header.php' );
        break;
    case "en":
        //echo "PAGE EN";
//        include("en/index.php");
    require( dirname( __FILE__ ) . '/en/wp-blog-header.php' );
        break;        
    default:
        //echo "PAGE EN - Setting Default";
    require( dirname( __FILE__ ) . '/en/wp-blog-header.php' );
        //include("en/index.php");//include EN in all other cases of different lang detection
        break;
}
?>