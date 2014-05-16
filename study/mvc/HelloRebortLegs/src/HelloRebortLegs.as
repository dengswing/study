package
{
	import context.HelloFlashContext;
	
	import flash.display.Sprite;
	
	import v.Ball;
	
	public class HelloRebortLegs extends Sprite
	{
		private var context:HelloFlashContext;
		
		public function HelloRebortLegs()
		{
			context = new HelloFlashContext(this);	
		}
	}
}