<?php
/*
echo "stop go program...".PHP_EOL;
$p = realpath(dirname(__FILE__).'/..');
echo "starting go program...".$p.'/glab';
exec($p.'/glab');
*/
/**
 * взять файл md_merge.xml, если нет - выход
 * какие узлы соединять:
 *	- enums/enum
 *	- models/model
 *	- constants/constant
 *	- controllers/controller
 *	- permissions/permission
 *	- views/view
 *	- serverTemplates/serverTemplate
 *	- sqlScripts/sqlScript
 *	- jsScripts/jsScript
 *	- cssScripts/cssScript
 */

$mg_file = "md_merge.xml" ;
if(!file_exists($mg_file)){
	exit;
}


?>
