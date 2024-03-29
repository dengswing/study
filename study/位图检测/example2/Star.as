﻿package {
	import flash.display.Sprite;
	public class Star extends Sprite
	{
		/**
		 * 画五角星
		 * @param	radius
		 * @param	color
		 */
		public function Star(radius:Number,color:uint=0xFFFF00):void
		{
			graphics.lineStyle(0);
			graphics.moveTo(radius,0);
			graphics.beginFill(color);
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
				graphics.lineTo(Math.cos(angle) * radius2,Math.sin(angle) * radius2);
			}
		}
	}
}