package 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.ycccc.PuzzleGame.Puzzle;

	/**
	 * ...
	 * @author dengsw
	 */
	[Frame(factoryClass="Preloader")]
	public class Main1 extends Sprite 
	{

		[Embed(source = "../bin/vivian.jpg")]
		private var puzzleImag:Class;
		private var bmd:Bitmap;
		
		
		public function Main1():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var s:MovieClip = new MovieClip();
			addChild(s)
			
			bmd = new puzzleImag();
			s.addChild(bmd);
			
			var puzzle:Puzzle = new Puzzle();
			puzzle.setPosition(1, 2);
			puzzle.mcToBitmap(s,s.width,s.height)
			
		}
		
		private function finishFun():void 
		{
			
		}

	}

}