package {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.*;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class BaseRender extends Sprite
	{
		protected var tileSheet:BitmapData;
		//background
		protected var backgroundBD:BitmapData;
		protected var backgroundRect:Rectangle;
		protected var backgroundPoint:Point;
		protected var canvasBD:BitmapData;
		protected var canvasBitmap:Bitmap;
		protected var tileWidth:int;
		protected var tileHeight:int;
		protected var heliTilesLength:int;
		protected var animationIndex:int;
		protected var animationCount:int;
		protected var animationDelay:int;
		protected var heliRect:Rectangle;
		protected var heliPoint:Point;
		protected var heliX:int;
		protected var heliY:int;
		
		protected var renderTime:uint=0;	
		
		public function BaseRender() {
			
			tileWidth=132;
			tileHeight=132;
			heliTilesLength=4;
			animationIndex=0;
			animationCount=0;
			animationDelay=3;
			heliX=50;
			heliY=50;
			
			var loader:Loader = new Loader();
			loader.name = '1';
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplate);
			loader.load(new URLRequest('background.png'));
		}
		
		
		private function onComplate(e:Event):void
		{
			var loaderinfo:LoaderInfo = e.target as LoaderInfo;
			
			if(loaderinfo.loader.name=='1')
			{
				backgroundBD=(loaderinfo.content as Bitmap).bitmapData.clone();
				backgroundRect=new Rectangle(0,0,400,400);
				backgroundPoint = new Point(0, 0);
				canvasBD=new BitmapData(400,400,false,0x000000);
				canvasBitmap=new Bitmap(canvasBD);
				loaderinfo.loader.unload();
				loaderinfo.loader.name='';
				loaderinfo.loader.load(new URLRequest('heli.png'));
				
				addChild(canvasBitmap);
				
			}else{
				tileSheet=(loaderinfo.content as Bitmap).bitmapData.clone();
				heliRect=new Rectangle(0,0,132,132);
				heliPoint = new Point(heliX, heliY);
				addEventListener(Event.ENTER_FRAME, gameLoop);
			}
		}
		
		public function gameLoop(e:Event):void
		{
			var t:uint = getTimer();
			renderTime++;
			for(var i:uint=0;i<1000;i++)
			{
				drawBackground();
				drawHeli();
			}
			trace("渲染耗时：",getTimer()-t);
			if(renderTime>10) removeEventListener(Event.ENTER_FRAME, gameLoop);
		}
		
		protected function drawBackground():void
		{
			canvasBD.copyPixels(backgroundBD,backgroundRect, backgroundPoint);
		}
		
		protected function drawHeli():void
		{
			
			if (animationCount == animationDelay) {
				animationIndex++;
				animationCount = 0;
				if (animationIndex == heliTilesLength){
					animationIndex = 0;
				}
			}else{
				animationCount++;
			}
			
			heliRect.x = int((animationIndex % heliTilesLength))*tileWidth;
			heliRect.y = int((animationIndex / heliTilesLength))*tileHeight;
			canvasBD.copyPixels(tileSheet,heliRect, heliPoint);
		}
	}	
	
}