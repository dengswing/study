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

$sql = "select * from topic";
$result = mysql_query($sql);

echo "<root>";
while($row = mysql_fetch_array($result, MYSQL_ASSOC)) {
	echo "<item id=\"".$row["id"]."\" addTime=\"".$row["addTime"]."\" username=\"".$row["username"]."\">".$row["content"]."</item>";
}
echo "</root>";

?>