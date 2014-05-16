package observable 
{
	import inf.IObserver;
	/**
	 * ...
	 * @author dengsw
	 */
	public class Beauty 
	{
		private var _currentLocation:String; //当前位置
		private var vSuitors:Vector.<IObserver>;	//追求者列表
		
		/**
		 * 美女
		 */
		public function Beauty() 
		{
			vSuitors = new Vector.<IObserver>();
		}
		
		/**
		 * 订阅
		 * @param	obs
		 */
		public function addObserver(obs:IObserver):void
		{
			if (vSuitors.indexOf(obs) == -1) vSuitors.push(obs);
		}
		
		/**
		 * 退订
		 * @param	obs
		 */
		public function removeObserver(obs:IObserver):void 
		{
			var index:int = vSuitors.indexOf(obs);
			if (index != -1) vSuitors.splice(index, 1);
		}
		
		/**
		 * 通知
		 * @param	location
		 */
		public function notifyObservers(location:String):void
		{
			_currentLocation = location;
			for (var i:* in vSuitors)
			{
				vSuitors[i].update(this);
			}
		}
		
		/**
		 * 当前位置
		 */
		public function get currentLocation():String 
		{
			return _currentLocation;
		}
	}

}