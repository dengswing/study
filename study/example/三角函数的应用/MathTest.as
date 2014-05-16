package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	
	[SWF(backgroundColor = 0x000000)]
	
	public class MathTest extends Sprite 
	{
		//背景半径50
		private var bgRadius:int = 100;
		
		//背景
		private var bg_mc:DrawCircle;
		
		//移动目录
		private var move_mc:DrawCircle;		
		
		private var moveAngle:Number;
		
		/**
		 * 简单三角函数的应用
		 */
		public function MathTest()
		{ 
			this.addEventListener(Event.ADDED_TO_STAGE, init);					
		}
		
		private function init(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			initMathTest()	
		}
		
		private function initMathTest():void 
		{
			//画个园
			bg_mc= new DrawCircle(bgRadius);
			addChild(bg_mc);
			bg_mc.x = this.stage.stageWidth / 2;
			bg_mc.y = this.stage.stageHeight / 2;
			
			//画一个移动对象
			move_mc= new DrawCircle(10);
			addChild(move_mc);			
		
			this.stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(evt:Event):void
		{			
			moveAngle = radiansChangeAngle(computeMouseAndBgAngle());
			
			//角度转换
			if (moveAngle < 0)			
				moveAngle = moveAngle + 360;
			else 
				moveAngle = moveAngle;
		
			trace(moveAngle.toFixed());
			
			move_mc.x = bgRadius * Math.cos(angleChangeRadians(moveAngle)) + bg_mc.x;
			move_mc.y = bgRadius * Math.sin(angleChangeRadians(moveAngle)) + bg_mc.y;			
		}
		
		/**
		 * 计算背景相对的角度
		 * @return
		 */
		private function computeMouseAndBgAngle():Number
		{
			return Math.atan2(bg_mc.y - this.stage.mouseY, bg_mc.x - this.stage.mouseX);			
		}
		
		/**
		 * 角度转换成弧度
		 * @param	angle
		 * @return
		 */
		private function angleChangeRadians(angle:Number):Number 
		{
			return 	angle * (Math.PI / 180);
		}
		
		/**
		 * 弧度转换成角度
		 * @param	radians
		 * @return
		 */
		private function radiansChangeAngle(radians:Number):Number
		{
			return 	radians * (180 / Math.PI);
		}				
		
	}
	
}
import flash.display.Sprite;

class DrawCircle extends Sprite
{
	public function DrawCircle(radius:int = 5, color:uint = 0xFFFFFF, alpha:Number = 1)			
	{
		this.graphics.lineStyle(1, color);
		this.graphics.beginFill(color, 0);
		this.graphics.drawCircle(0, 0, radius);
		this.graphics.endFill();		
	}		
}