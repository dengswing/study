package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author dengsw
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{

		[Embed(source = "../bin/vivian.jpg")]
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
			var upuzzle:puzzle2 = new puzzle2();
			addChild(upuzzle);
			
			upuzzle.startPuzzle(bmd, finishFun, 500, 500, 3, 3);
		}
		
		private function finishFun():void 
		{
			
		}

	}

}