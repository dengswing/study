package
{
	import flash.events.Event;
	import flash.utils.getTimer;

	public class AdvRender extends BaseRender
	{
		public function AdvRender()
		{
			super();
		}
		
		override public function gameLoop(e:Event):void
		{
			if(renderTime==0)
			{
				canvasBD.copyPixels(backgroundBD,backgroundRect, backgroundPoint);
			}
			renderTime++;
			var t:uint = getTimer();
			for(var i:uint=0;i<1000;i++)
			{
				drawBackground();
				drawHeli();
			}
			trace("渲染耗时：",getTimer()-t);
			if(renderTime>10) removeEventListener(Event.ENTER_FRAME, gameLoop);
		}
		
		override protected function drawBackground():void
		{
			backgroundRect.x = heliPoint.x;
			backgroundRect.y = heliPoint.y;
			backgroundRect.width = heliRect.width;
			backgroundRect.height = heliRect.height;
			canvasBD.copyPixels(backgroundBD,backgroundRect, heliPoint);
		}
		
		override protected function drawHeli():void
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