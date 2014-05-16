package net.eidiot.appDomainDemo
{
	import flash.display.Sprite;
	
	import net.eidiot.appDomainDemo.ui.EResult;

	/**
	 * 库
	 * 
	 * @author	eidiot (http://eidiot.net)
	 * @date	070601
	 * @version	1.0.070601
	 */	
	public class Libaray extends Sprite
	{
		/** 按钮类全名 */		
		public static var BTN_NAME : String = "net.eidiot.appDomainDemo.ui.EBtn";
		/** 文本框类全名 */		
		public static var TXT_NAME : String = "net.eidiot.appDomainDemo.ui.ETxt";
		/** 背景类全名 */		
		public static var BG_NAME : String = "net.eidiot.appDomainDemo.ui.EBG";
		/**
		 * 构造函数
		 */		
		public function Libaray()
		{
			super();
		}
		/**
		 * 获取结果显示
		 * 
		 * @param p_name	用户名
		 * @return 			结果显示
		 */		
		public static function getResult(p_name : String) : Sprite
		{
			return new EResult(p_name);
		}
	}
}