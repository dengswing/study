package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author dengsw
	 */
	[SWF(width="760",height="650" , backgroundColor="#000000")]
	public class Main extends Sprite 
	{

		[Embed(source = "vivian.jpg")]
		private var puzzleImag:Class;
		private var bmd:Bitmap;
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			bmd = new puzzleImag();
			//var upuzzle:puzzle = new puzzle();
			//var upuzzle:puzzle2 = new puzzle2();
			//var upuzzle:puzzle3 = new puzzle3();
			var upuzzle:puzzle4 = new puzzle4();
			addChild(upuzzle);
			
			upuzzle.startPuzzle(bmd, finishFun, 500, 500,4, 4);
		}
		
		private function finishFun():void 
		{
			
		}

	}

}