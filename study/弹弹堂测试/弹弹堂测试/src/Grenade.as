package  
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	/**
	 * ...
	 * @author rider
	 */
	public class Grenade extends Sprite
	{
		
		private var angle:Number;
		private var bmpData:BitmapData;
		private var mc:mc_grenade;
		//已知角度和速率==知道速度
		private var speed:Number=15;
		//空气阻力系数
		private var friction:Number=.9;
		//重力加速度
		private var gravity:Number=.5;
		
		public function Grenade(_angle:Number, _bmpData:BitmapData, _speed:int) 
		{
			angle	=	_angle;
			bmpData	=	_bmpData;
			speed	=	_speed / 15;
			init();
		}
		private var vx:Number;
		private var vy:Number;
		
		private function init():void {
			mc	=	new mc_grenade();
			addChild(mc);
			mc.gotoAndStop(1);
			vx = Math.cos(angle) * speed;
			vy = Math.sin(angle) * speed;
			
			this.addEventListener(Event.ENTER_FRAME,goMove);
			
		}
		private function goMove(e:Event):void {
			vy+=gravity;
			x += vx;
			y += vy;
			mc.rotation += 2;
			if (bmpData.hitTest(new Point(), 0x01, new Point(this.x, this.y))) {
				this.removeEventListener(Event.ENTER_FRAME, goMove);
				mc.play();
				var hole:Shape	=	new Shape();
				hole.graphics.beginFill(0xff0000);
				hole.graphics.drawCircle(0, 0, 30);
				
				var hole_matrix:Matrix	=	new Matrix();
				hole_matrix.translate(this.x,this.y);
				bmpData.draw(hole, hole_matrix, null, BlendMode.ERASE);
			}
		}
	}

}