<?php
require_once 'com/plter/ajp/php/AJPServer.php';
require_once 'com/plter/ajp/php/ValueObject.php';


class MyVO extends ValueObject{
	public function MyVO(){
		$this->alias='MyVO';
	}
	
	public $data;
	
	public $myVO1;
}

class MyVO1 extends ValueObject{
	
	public function MyVO1(){
		$this->alias='MyVO1';
	}
	
	public $data;
}


//Create server
$server=new AJPServer();
$server->registerValueObject('MyVO');
$server->registerValueObject('MyVO1');
$server->addFunction('sendVO');
echo $server->handle();


function sendVO(MyVO $vo){
	$vo->data='Hello client';
	return $vo;
}