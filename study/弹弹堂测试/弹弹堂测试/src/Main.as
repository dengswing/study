package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author rider
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private var bg_bmp:Bitmap;
		private var bg_bmpData:BitmapData;
		
		private var player:Player;
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			bg_bmpData	=	new BitmapData(1000, 600, true, 0x0);
			bg_bmpData.draw(new MC_Map());
			
			bg_bmp	=	new Bitmap(bg_bmpData);
			addChild(bg_bmp);
			
			player	=	new Player(bg_bmpData,stage);
			player.x	=	150;
			addChild(player);
			
		}

		
	}
	
}