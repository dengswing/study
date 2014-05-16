package classes{
	// 关卡设定的类
	public class MissionSet
	{
		// 静态方法，获得每关的设置数组
		public static function GetMission(str:String):Array {
			var arrMission:Array = new Array();
			switch(str)	{
				case "M1":
					arrMission = M1.slice();
					break;
			}
			return arrMission;		
		}

		// 对象设定值
		// 0: 空白格子
		// 1: 实心墙
		
		// 第一关设置数组 13*13大小 敌人类型 9(1) 7(3) 21(3) 22(1)
		private static var M1 = new Array(0, 0, 0, 0, 0, 0, 0,0,
										  0, 1, 1, 1, 1, 1, 1,0,
						  				  0, 1, 1, 1, 1, 1, 1,0,
						  				  0, 1, 1, 1, 1, 1, 1,0,
						   				  0, 1, 1, 1, 1, 1, 1,0, 
						   				  0, 1, 1, 1, 1, 1, 1,0,
										  0, 1, 1, 1, 1, 1, 1,0,
										  0, 0, 0, 0, 0, 0, 0,0); //01 8*8
	}
}