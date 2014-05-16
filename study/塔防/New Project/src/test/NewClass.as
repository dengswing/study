package test
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * @author dengswing
	 * @date 2012-2-3 14:25
	 */
	public class NewClass extends Sprite 
	{
		private var sCon:Sprite;
		private var mag:int = 50;
		private var ang_rad:int = 0;
		private var sCon2:Sprite;
		
		public function NewClass() 
		{
			init();
			
			draw()
		}
		
		public function draw():void 
		{
			sCon2 = new Sprite();
			var g:Graphics = sCon2.graphics;
			var _w:int = 20;
			var _h:int = 10;
			g.clear();
			g.beginFill(0xFF9933);
			g.lineStyle(2,0,.5);
			g.moveTo(0, _h * 0.5);
			g.lineTo(_w, 0);
			g.lineTo(0, _h * -0.5);
			g.lineTo(0, _h * 0.5);
			g.endFill();
			
			sCon2.x = 300;
			sCon2.y = 100;
			
			addChild(sCon2)
		}
		
		private function init():void
		{
			drawCire();
			drawCire2();
			sCon.addEventListener(Event.ENTER_FRAME,circleHandler);
			
			
			var a:Vector.<int> = new <int>[3, 3, 3, 4];
		}
		
		private function circleHandler(e:Event):void 
		{
			sCon.x = mag * Math.cos(ang_rad * Math.PI / 180) + 200;
			sCon.y = mag * Math.sin(ang_rad * Math.PI / 180) + 200;	
			ang_rad += 2;
			if (ang_rad > 360) ang_rad = 0;
			
			sCon2.rotation = Math.atan2(this.mouseY - sCon2.y, this.mouseX - sCon2.x) * 180 / Math.PI;
		}
		
		private function drawCire():void 
		{
			sCon = new Sprite();
			var g:Graphics = sCon.graphics;
			g.beginFill(0x333333, .5);
			g.drawCircle(0, 0, 5);
			g.endFill();
			
			addChild(sCon)
		}
		
		private function drawCire2():void 
		{
			var sCon = new Sprite();
			var g:Graphics = sCon.graphics;
			g.beginFill(0x333333, .5);
			g.drawCircle(0, 0, 50);
			g.endFill();
			
			sCon.x = 200;
			sCon.y = 200;
			addChild(sCon)
		}
	}

}