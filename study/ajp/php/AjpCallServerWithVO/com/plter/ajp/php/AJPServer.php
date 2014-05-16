<?php
require_once 'com/plter/ajp/php/ValueObject.php';

/**
 * 
 * 此类为ajp服务器，用于处理ajp连接
 *
 */
class AJPServer{
	
	private $functions=array();
	private $classes=array();
	private $vos=array();
	
	/**
	 * 添加一个函数
	 * @param string $functionName
	 */
	public function addFunction($functionName){
		$this->functions[$functionName]=$functionName;
	}
	
	/**
	 * 添加一个类
	 * @param string $className
	 */
	public function addClass($className){
		$this->classes[$className]=$className;
	}
	
	/**
	 * 注册一个值对象类
	 * @param string $className
	 */
	public function registerValueObject($className){
		$vo=new $className();
		if($vo instanceof ValueObject){
			$this->vos[$vo->alias]=$className;
		}
	}
	
	

	/**
	 * 处理客户端请求
	 * @return string
	 */
	public function handle(){
		$jsonObj=json_decode(file_get_contents("php://input"));
		if(empty($jsonObj)){
			return 'Ajp server running...<br/>Powerd by <a href="http://plter.com">http://plter.com</a>';
		}
		
		$op=explode('.',$jsonObj->name);
		$args=$jsonObj->args;
		$newArgs=array();
		
		foreach ($args as $key => $value) {
			if(!empty($value->alias)){
				array_push($newArgs, $this->convertValueObject($value));
			}else {
				array_push($newArgs, $value);
			}
		}
		
		switch (count($op)){
			case 1:
				$functionName=$op[0];
				return json_encode(call_user_func_array($this->functions[$functionName], $newArgs));
				break;
			case 2:
				$className=$op[0];
				$functionName=$op[1];
				
				return json_encode(call_user_func_array(array($this->classes[$className],$functionName), $newArgs));
				break;
		}
	}
	
	private function convertValueObject(&$vo){
			$voClass=$this->vos[$vo->alias];
			$returnVo=empty($voClass)?new ValueObject:new $voClass;
			$returnVo->alias=$vo->alias;
			
			foreach ($vo as $key => $value) {
				if (!empty($value->alias)){
					$value=$this->convertValueObject($value);
				}
				$returnVo->$key=$value;
			}
			return $returnVo;
	}
}