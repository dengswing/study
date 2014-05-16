package context 
{
	import state.AbstractState;
	import state.MorningState;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class Person 
	{
		
		private var _hours:int; //小时
		private var _uState:AbstractState;
		
		public function Person() 
		{
			init();
		}
		
		private function init():void 
		{
			_uState = new MorningState(); //默认早餐
		}
		
		public function doSomething():void 
		{
			_uState.doSomething(this);
			init();	//复位
		}
		
		public function get hours():int 
		{
			return _hours;
		}
		
		public function set hours(value:int):void 
		{
			_hours = value;
		}
		
		public function set uState(value:AbstractState):void 
		{
			_uState = value;
		}
	}

}