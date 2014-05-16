package
{	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;  
	
	/** 
	 *  ... 
	 *  @author Loki Tang
	 * 
	 */		
	public class FirstStep extends Sprite 	
	{  
		private var buttom:uint = 300; 
		
		//重力
		private var gravity:uint = 3; 
		
		public function FirstStep():void  {			
			if (stage) 
				init(); 
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		} 
		
		private function init(e:Event = null):void  { 
			removeEventListener(Event.ADDED_TO_STAGE, init); 
			
			// 划线
			var buttom_line:Sprite = new Sprite(); 
			buttom_line.graphics.lineStyle(3);
			buttom_line.graphics.moveTo(0, buttom);
			buttom_line.graphics.lineTo(stage.stageWidth, buttom);
			this.addChild( buttom_line );
			//
			
			stage.addEventListener(MouseEvent.CLICK , onClick);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame); 
		}	
		
		/**
		 * @explain 鼠标每次点击就增加一个小球
		 * @param	e
		 */
		private function onClick(e:MouseEvent):void { 			
			var co:CircleObj = new CircleObj(); 
			co.x = this.mouseX; 
			co.y = this.mouseY; 
			this.addChild( co );
		}
		
		private function onEnterFrame(e:Event):void { 			
			if (this.numChildren <= 0) return;			
			
			for ( var i:uint = 0; i < this.numChildren; i++) {					
				var obj:CircleObj = this.getChildAt(i) as CircleObj; 
				if (obj) {	
					
					trace(obj.y, buttom, obj.speed);
					
					if ( obj.y <= buttom - 5 ) { 							
						//如果小球不超过底线，则小球的速度加上加速度
						obj.speed += gravity;
						//预测，如果小球下一帧的运动超过底线，则将小球的位置强制置于底线 
						
						//因为小球是不能穿过底线的。
						if ( obj.y + obj.speed > buttom -5 ) {
							obj.y = buttom - 5;
							obj.speed = -obj.speed * .9;
							
							trace("CC");
							continue; 						
						} 
						
						trace("BB");
					}else { //如果小球超过底线，则反弹，速度相反，并且有损耗。
						obj.y = buttom - 5; 
						obj.speed = -obj.speed * .8; 
						
						trace("AA");
					}
				
					obj.y += obj.speed;
				} 
			} 			 
		}
		
		
	} 		
}

import flash.display.Sprite
 
class CircleObj extends Sprite {	 
	 public var speed:int = 0;
	 
	 public function CircleObj() {		 
		this.graphics.beginFill(0x0, 1);
		this.graphics.drawCircle(0, 0, 10);
		this.graphics.endFill(); 
	}
}  