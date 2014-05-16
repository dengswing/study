package util{
	public class RandomNumber {
		public function RandomNumber() {
		}
		
		/**
		 * 随机一组不重复的数据
		 * @param	n
		 * @return
		 */
		public static function getShuffleArray(n:int):Array {
			var arr:Array=new Array;
			var temp1:int;
			var temp2:int;
			for (var i:int=0; i < n; i++) {
				arr[i]=i;

			}
			
			for (var j:int=0; j < n; j++) {
				temp1 = RandomNumber.gen(j, n - 1);
				if (j != temp1) {
					temp2=arr[j];
					arr[j]=arr[temp1];
					arr[temp1] = temp2;
				}
			}
			
			return arr;
		}
		
		/**
		 * 随机期间数
		 * @param	min
		 * @param	max
		 * @return
		 */
		public static function gen(min:int,max:int):int {
			return (min + Math.floor((max - min + 1) * Math.random()));
		}
		
		/**
		 * 从长度为n的数组中随机获取成对数字
		 * @ paramnum：几对
		 * @ paramn  : 数组长度
		 * @ returnArray
		 */
		public static function getPair(num:int,n:int):Array 
		{
			var rand	:int;
			var tempArr	:Array;
			var arr		:Array = new Array;
			
			tempArr = RandomNumber.getShuffleArray(n);			
			for (var i = 0; i<n; i++) {
				rand = RandomNumber.gen(1, num);
				arr[tempArr[i]] = rand;
				arr[tempArr[n-1-i]] = rand;
			}
			return arr;
		}
		
	}
}