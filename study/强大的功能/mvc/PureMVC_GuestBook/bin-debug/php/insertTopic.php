<?php
/**************************
@Filename: filename.php
@Version : 0.0.1
@Author  : leo
@Update  : 2007-11-01
@Content : PHP by Editplus
**************************/

mysql_connect("localhost", "root", "uauovfgo");
mysql_select_db("guestbook");
mysql_query("set names utf8");

$username = $_GET['username'];
$content = $_GET['content'];

$sql = "insert into topic(addTime, username, content) values(now(), '{$username}', '{$content}')";
$result = mysql_query($sql);

if($result) {
	echo "true";
}else {
	echo mysql_error();
}

?>