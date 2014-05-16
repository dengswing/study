package  
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Howard.Ren
	 */
	public class Main extends Sprite
	{
		private var list:Array;
		public function Main() 
		{
			list = new Array();
			
			var source:BitmapData = new map(0,0);
			for (var i:uint = 0; i < 100; i++ )
			{
				var obj:ShowObjectCP= new ShowObjectCP(source);
				obj.x = int(Math.random() * stage.stageWidth);
				obj.y = int(Math.random() * stage.stageHeight);
				addChild(obj);
				list.push(obj);
			}
			
			addEventListener(Event.ENTER_FRAME, doit );
		}
		
		private function doit(e:Event):void
		{
			for each(var obj:Render in list)
			{
				obj.render();
			}
		}
		
	}

}