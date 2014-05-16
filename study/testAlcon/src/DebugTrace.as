package cn.dengSwing.utils 
{	
	import com.hexagonstar.util.debug.Debug;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class DebugTrace
	{
		/**
		 * debug Trace
		 */
		public function DebugTrace() 
		{
			
		}
		
		/**
		 * trace输出,使用Alcon组件查看
		 * @param	className	类名
		 * @param	funcName	方法名
		 * @param	obj	输出值
		 * @param	color	
		 * @param	functions
		 * @param	depth
		 */
		public static function traceFunc(className:*, funcName:*, obj:*= null, color:uint = 0x111111, functions:Boolean = false, depth:int = 4):void {	
			//trace("class " + className + ": func " + funcName + " params=" + paramsFunc(params));	
			
			if (obj == null || obj == "")			
				obj = "值为空从值!";
			
			/*var tmpObj:Object = { "<font color='#07B8E4' >class</font>":"<b><font color='#07B8E4' >" + className + "</font></b>" ,
								  "<font color='#BE9414' >func </font>":"<b><font color='#BE9414' >" + funcName + "</font></b>" ,
								  "<font color='#01B025' >param</font>": obj };*/
						
			var tmpObj:Array = ["<b><font color='#07B8E4'>class : " + className + "</font></b>" ,
								"<b><font color='#BE9414'>func : " + funcName + "</font></b>" ,
								{"<b><font color='#01B025' >param : </font></b>":obj } ];
			
								  
			Debug.inspect(tmpObj);
			Debug.delimiter();	//分隔符
			Debug.time();	//输出时间
			Debug.delimiter();	//分隔符
			Debug.traceObj(tmpObj, 64, Debug.LEVEL_DEBUG);
		}	
		
		private static function paramsFunc(... args) : String{
			var str:String = "";
			
			for (var i:uint = 0; i < args.length; i++) {
				if(i==0)
					str = args[i];
				else
					str += "," + args[i];			
			}			
			
			return str;
		}

	}

}