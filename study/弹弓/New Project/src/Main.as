package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class Main extends Sprite
	{
		private var xSpeed:Number; //x速度
		private var ySpeed:Number; //y速度
		private var t0:Number = 0;
		private var t1:Number = 20; //每次的速度
		private var g:Number = 1; //弧度
		private var angel:Number;
		private var bmpd:Arrow;
		private var timer:Timer;
		private var mb:mubiao;
		private var bmpd1:BitmapData;
		private var bmp1:Bitmap;
		private var bmpd2:BitmapData;
		private var bmp2:Bitmap;
		public function Main()
		{
			bmpd = new Arrow();
			bmpd1=new BitmapData(bmpd.width,bmpd.height,true,0);
			bmpd1.draw(bmpd);
			bmp1=new Bitmap(bmpd1);
			addChild(bmp1);
			bmp1.x = 275;
			bmp1.y = 200;
			
			mb=new mubiao();
			bmpd2=new BitmapData(200,200,true,0);
			bmpd2.draw(mb);
			bmp2=new Bitmap(bmpd2);
			addChild(bmp2);
			bmp2.x=100;
			bmp2.y=200;
			
			stage.addEventListener(MouseEvent.CLICK,clickHandler);
			
			timer = new Timer(33);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
		}
		private function moveArrow():void{
			t0++;
			bmp1.x = (275 + (t0 * xSpeed));
			bmp1.y = (200 + t0 * ySpeed) + (g * t0 * t0 / 2);
			t0++;
			var Sx:Number = (275 + (t0 * xSpeed));
			var Sy:Number = (200 + t0 * ySpeed) + (g * t0 * t0 / 2);
			t0--;
			var dx:Number = Sx - bmp1.x;
			var dy:Number = Sy - bmp1.y;
			angel = Math.atan2(dy,dx);
			bmp1.rotation = angel * 180 / Math.PI + 180;
		}
		private function clickHandler(e:MouseEvent):void{
			var pos:Point = new Point(e.stageX, e.stageY);
			var g1:Graphics = this.graphics;
			g1.clear();
			g1.lineStyle(1);
			g1.beginFill(0xff0000);
			g1.drawCircle(275,200,3);
			g1.drawCircle(pos.x,pos.y,2);
			g1.endFill();
			
			xSpeed = (pos.x - 275) / t1;
			ySpeed = (((pos.y - 200) - ((g * t1) * (t1 / 2))) / t1);
			timer.start();
		}
		private function timerHandler(e:TimerEvent):void{
			moveArrow();
			if(bmp1.y > 600 || bmp1.x < 0 || bmp1.x > 800){
				timer.stop();
				bmp1.x = 275;
				bmp1.y = 200;
				t0 = 0;
			}
			if (bmpd1.hitTest(new Point(bmp1.x,bmp1.y),255,bmp2,new Point(bmp2.x,bmp2.y),255)) {
				bmp1.filters=[new GlowFilter()];
				bmp2.filters = [new GlowFilter()];
				timer.stop();
			}
			else {
				bmp1.filters=[];
				bmp2.filters=[];
			}
		}
	}
}