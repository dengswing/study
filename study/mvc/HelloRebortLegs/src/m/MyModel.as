package m
{
	import c.event.ChangeModelEvent;
	
	import org.robotlegs.mvcs.Actor;

	public class MyModel extends Actor
	{
		private var _count:int = 0;
		
		public function MyModel()
		{
		}

		public function get count():int
		{
			return _count;
		}

		public function set count(value:int):void
		{
			_count = value;
			dispatch(new ChangeModelEvent(ChangeModelEvent.CHANGE_VALUE,_count));
		}

	}
}