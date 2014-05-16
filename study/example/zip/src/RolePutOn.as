package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author dengswing
	 */
	public class RolePutOn 
	{
		/**
		 * 人物模型名称
		 */
		private const ROLE_MC_NAME:Array = ["hairup_mc", "bodyup_mc", "hip_mc",
													"leftfoot_mc", "rightfoot_mc",
													"leftarmup_mc",  "rightarmup_mc",  "leftarmdown_mc", "rightarmdown_mc",										  
													"leftlegup_mc", "rightlegup_mc",  "leftlegdown_mc",  "rightlegdown_mc",
													"lefthand_mc", "righthand_mc", "hairdown_mc", "haiir_mc"];	
		//导出的名称											
		private const EXPORT_MC_NAME:Array = ["shangfa", "shangshenyi", "tunku",
													"zuojiaoxie", "youjiaoxie",
													"zuoshangbiyi",  "youshangbiyi",  "zuoxiabiyi", "youxiabiyi",										  
													"zuoshangtuiku", "youshangtuiku",  "zuoxiatuiku",  "youxiatuiku",
													"lefthand_mc", "righthand_mc", "xiafa", "shangfa"];	
			
		//正面
		private const EXPORT_MC_INFO:Array = [new Rectangle(22.8, 36.8, 90, 90), new Rectangle(7.1, 0.9, 30, 35), new Rectangle(9.3, 0.4, 40, 25),		
													new Rectangle(5.8, 1.1, 18, 12), new Rectangle(6.5, 1.4, 18, 12),
													new Rectangle(3.4, 2.3, 15, 20), new Rectangle(4.9, 1.7, 15, 20), new Rectangle(2.9, 2.3, 10, 15), new Rectangle(3.1, 1.8, 10, 15),										  
													new Rectangle(3.5, 2.6, 15, 22), new Rectangle(3.7, 2.5, 15, 22), new Rectangle(3.3, 1.5, 12, 20), new Rectangle(4.1, 2.6, 12, 20),
													new Rectangle(7.1, 0.9, 30, 35), new Rectangle(7.1, 0.9, 30, 35), new Rectangle(45.8, 27.4, 90, 90)];												
		
		
		//背面											
		private const EXPORT_MC_INFO2:Array = [new Rectangle(8, 25.9, 90, 90), new Rectangle(6.3, 1.3, 30, 35), new Rectangle(8.9,0.6, 40, 25),		
												new Rectangle(2.4, 3.6, 18, 12), new Rectangle(2.1, 3.6, 18, 12),
												new Rectangle(5.0, 1.3, 15, 20), new Rectangle(4.2, 2.3, 15, 20), new Rectangle(1.1, 1.1, 10, 15), new Rectangle(3.7, 1.4, 10, 15),										  
												new Rectangle(4.0, 3.0, 15, 22), new Rectangle(4.0, 2.8, 15, 22), new Rectangle(3.0, 2.0, 12, 20), new Rectangle(3.5, 2.1, 12, 20),
												new Rectangle(7.1, 0.9, 30, 35), new Rectangle(7.1, 0.9, 30, 35), new Rectangle(45.8, 27.4, 90, 90), new Rectangle(8, 25.9, 90, 90)];											
		/**
		 * 反面名称
		 */
		private const BACK_MC_NAME:String = "back";
		
		private const EXPROT_MC_NAME:String = "bei";
		
		
		
		
		/**
		 * 人物库
		 */
		public function RolePutOn() 
		{
			
		}
		
		/**
		 * 获取所有绑定的mc
		 * @param	mc
		 * @return
		 */
		public function getAllLink(mc:Sprite):Array
		{
			var aC:Array = findLink(mc,false);
			aC = aC.concat(findLink(mc, true));
			return aC;
		}
		
		/**
		 * 查找绑定的mc
		 * @param	mc
		 * @return
		 */
		private function findLink(mc:Sprite,isFront:Boolean):Array
		{
			var _mFind:Class;
			var _aFind:Array = [];
			var i:int = 0;
			var count:int = ROLE_MC_NAME.length;
			var prefix:String = (isFront) ? BACK_MC_NAME : "";
			var prefix2:String = (isFront) ? EXPROT_MC_NAME : "";
			for (i; i < count; i++)
			{
				if (mc.loaderInfo.applicationDomain.hasDefinition(prefix + ROLE_MC_NAME[i]))				
					_mFind = mc.loaderInfo.applicationDomain.getDefinition(prefix + ROLE_MC_NAME[i]) as Class;
				else 
					_mFind = null;
				if (!_mFind) continue;	
				
				var _mCon:Sprite = new _mFind();
				
				/*if (isFront && ROLE_MC_NAME[i] == ROLE_MC_NAME[0])
					_mCon.name = prefix2 + EXPORT_MC_NAME[EXPORT_MC_NAME.length - 1];
				else*/ 
				
				_mCon.name = prefix2 + EXPORT_MC_NAME[i];
				
				_aFind.push( { "con":_mCon, "info":(isFront) ? EXPORT_MC_INFO2[i] : EXPORT_MC_INFO[i] } );
			}
			
			return _aFind;
		}
	}

}