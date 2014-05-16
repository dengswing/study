package 
{
	import flash.display.Sprite;
	
	[SWF (backgroundColor='#000000')]
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Test extends Sprite 
	{
		private var radius:uint = 50;
		private var color:uint = 0xFFFFFF;
		
		public function Test():void {
			
			var tmpContainer:Sprite = new Sprite();
			tmpContainer.x = tmpContainer.y = radius;
			addChild(tmpContainer);
			
			tmpContainer.graphics.lineStyle(0);
			tmpContainer.graphics.moveTo(radius,0);
			tmpContainer.graphics.beginFill(color);
			
			// draw 10 lines
			for (var i:int=1; i < 11; i++)
			{
				var radius2:Number=radius;
				if (i % 2 > 0)
				{
					// alternate the radius to make spikes every other line
					radius2=radius / 2;
				}
				var angle:Number=Math.PI * 2 / 10 * i;
				tmpContainer.graphics.lineTo(Math.cos(angle) * radius2,Math.sin(angle) * radius2);
			}			
		}		
	}
	
}