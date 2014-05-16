
/**
 * 使用方法：container主容器(切记座标、大小不要有小数。不然会不准确)
 * 			//内容、遮罩、拖动条、滚动热区、上移、下移、滚动背景、类型、isDraw是否控制拖动条大小(true表示设置);
			var content_mc:Sprite = container.getChildByName("content_mc") as Sprite;
			var mask_mc:Sprite = container.getChildByName("mask_mc") as Sprite;
			var draw_mc:Sprite = container.getChildByName("draw_mc") as Sprite;
			var scroll_mc:Sprite = container.getChildByName("scroll_mc") as Sprite;
			var prev_mc:Sprite = container.getChildByName("prev_mc") as Sprite;
			var next_mc:Sprite = container.getChildByName("next_mc") as Sprite;
			var scroll_bg:Sprite = container.getChildByName("scroll_bg") as Sprite;		
			//
			
			content_mc.mask = mask_mc;				
			Scroll.setScroll(content_mc, mask_mc, draw_mc, scroll_mc, prev_mc, next_mc, scroll_bg);	
 * 
 * 
 */
package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Scroll 
	{
		/**
		 * 滚动条的设定功能
		 */
		public function Scroll() 
		{			
		}
		
		/**
		 * 滚动条的管理
		 * @param	content_mc 内容
		 * @param	mask_mc 遮罩
		 * @param	draw_mc 拖动条
		 * @param	scroll_mc 滚动热区
		 * @param	prev_mc 上移
		 * @param	next_mc 下移
		 * @param	scroll_bg 滚动背景
		 * @param	type 类型(height表示竖滚动条、width表示横滚动条)
		 * @param	isDraw 是否控制拖动条大小(true表示控制)
		 */
		public static function setScroll(content_mc:Sprite, mask_mc:Sprite, draw_mc:Sprite, scroll_mc:Sprite, prev_mc:Sprite = null, next_mc:Sprite = null, scroll_bg:Sprite = null, type:String = "height", isDraw:Boolean = false):void {
			//显示及隐藏滚动
			if (content_mc[type] < mask_mc[type]) {				
				draw_mc.visible = false;
				scroll_mc.visible = false;				
				if (prev_mc)				
					prev_mc.visible = false;
				if (next_mc)					
					next_mc.visible = false;
				if (scroll_bg)				
					scroll_bg.visible = false;
				
				gc();				
				return;
			}else {
				draw_mc.visible = true;
				scroll_mc.visible = true;				
				if (prev_mc)				
					prev_mc.visible = true;					
				if (next_mc)		
					next_mc.visible = true;						
				if (scroll_bg)		
					scroll_bg.visible = true;
			} 
			//
			
			//滚动速度;
			var speedNum:Number = 5;
				
			
			//定义拖动条大小（根据内容的多少来调整）
			if (isDraw) {		
				//滑块的高度=遮罩影片高度/内容的高度*滑块可拖动的范围
				var drawInit:Number = mask_mc[type] / content_mc[type] * scroll_mc[type];
				
				trace("drawInit=" + drawInit, scroll_mc[type] ,(content_mc[type] - mask_mc[type]));
				
				if (drawInit < 5) drawInit = 5;
				
				draw_mc[type] = drawInit;
			}			
			
			//求系数
			var space:Number = (content_mc[type] - mask_mc[type]) / (scroll_mc[type] - draw_mc[type]);		
			
			//标识x、y
			var setType:String = "";
			//最大座标
			var maxPosition:Number;
			
			//拖动的范围
			var myRectangle:Rectangle;
				
			if (type == "height") {					
				setType = "y";
				maxPosition = scroll_mc[setType] + scroll_mc[type] - draw_mc[type];
				
				myRectangle = new Rectangle(scroll_mc.x, scroll_mc[setType], 0, maxPosition - scroll_mc[setType]);
				
				trace("myRectangle=" +myRectangle);
			}else {
				setType = "x";
				maxPosition = scroll_mc[setType] + scroll_mc[type] - draw_mc[type];	
				
				myRectangle = new Rectangle(scroll_mc[setType], int(scroll_mc.y), maxPosition - scroll_mc[setType], 0);		
			}	
			
			trace(myRectangle.x, myRectangle.y, myRectangle.width, myRectangle.height, maxPosition, "space=" + space, "scroll_mc[setType]=" + scroll_mc[setType]);
			
			//定义到顶点(起始点)
			draw_mc[setType] = scroll_mc[setType];	
			
			//内容侦听及处理
			if (content_mc.hasEventListener(Event.ENTER_FRAME)) {				
				content_mc.removeEventListener(Event.ENTER_FRAME, enterFrameContent);
			}			
			content_mc.addEventListener(Event.ENTER_FRAME, enterFrameContent);			
			
			function enterFrameContent(evt:Event):void {
				var myMC:Sprite = evt.target as Sprite;
				
				if (myMC == null)
					gc();
				else 	
					myMC[setType] = mask_mc[setType] - ((draw_mc[setType] - scroll_mc[setType]) * space);				
			}
			//
			
			//拖拽的处理(记得先添加到舞台，不然没法访问到stage)
			draw_mc.buttonMode = true;			
			if (!draw_mc.hasEventListener(MouseEvent.MOUSE_DOWN))				
				draw_mc.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownDraw);			
			
			if (!draw_mc.stage.hasEventListener(MouseEvent.MOUSE_UP))					
				draw_mc.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpDraw);			
			
			function mouseDownDraw(mouseEvt:MouseEvent):void {
				var myMC:Sprite = mouseEvt.target as Sprite;				
				myMC.startDrag(false, myRectangle);				
			}
			function mouseUpDraw(mouseEvt:MouseEvent):void {								
				draw_mc.stopDrag();				
			}
			//
			
			//上滚动
			if (prev_mc) {						
				prev_mc.buttonMode = true;
				if (!prev_mc.hasEventListener(MouseEvent.CLICK))	
					prev_mc.addEventListener(MouseEvent.CLICK, mouseUpPrev);
			}	
			
			function mouseUpPrev(mouseEvt:MouseEvent):void {
				var myMC:Sprite = mouseEvt.target as Sprite;
				
				if (draw_mc[setType] - speedNum <= scroll_mc[setType]) {						
					draw_mc[setType] = scroll_mc[setType];
				} else {
					draw_mc[setType] -= speedNum;
				}				
			}				
			//
			
			//下滚动
			if (next_mc) {				
				next_mc.buttonMode = true;
				if (!next_mc.hasEventListener(MouseEvent.CLICK))				
					next_mc.addEventListener(MouseEvent.CLICK, mouseUpNext);
			}	
			
			function mouseUpNext(mouseEvt:MouseEvent):void {
				var myMC:Sprite = mouseEvt.target as Sprite;
			
				if (draw_mc[setType] + speedNum >= maxPosition) {						
				   draw_mc[setType] = maxPosition;
				} else {
				   draw_mc[setType] += speedNum;
				}	
				
				trace(draw_mc[setType]);
			}			
			//
			
			//鼠标滚动侦听
			if (!content_mc.parent.hasEventListener(MouseEvent.MOUSE_WHEEL))			
				content_mc.parent.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWhellContent);
			
			function mouseWhellContent(mouseEvt:MouseEvent):void {				
				var delta:Number = mouseEvt.delta;									
				if (delta>0) {
					  if (draw_mc[setType] - speedNum <= scroll_mc[setType]) {						  
						  draw_mc[setType] = scroll_mc[setType];
					  } else {
						  draw_mc[setType] -= speedNum;
					  }
				} else {
					  if (draw_mc[setType] + speedNum >= maxPosition) {							  
						  draw_mc[setType] = maxPosition;
					  } else {
						  draw_mc[setType] += speedNum;
					  }
				}				
			}
			//
			
			//移除所有侦听
			function gc():void {				
				if (content_mc.hasEventListener(Event.ENTER_FRAME))			
					content_mc.removeEventListener(Event.ENTER_FRAME, enterFrameContent);
				
				if (draw_mc.hasEventListener(MouseEvent.MOUSE_DOWN))				
					draw_mc.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownDraw);			
			
				if (draw_mc.stage.hasEventListener(MouseEvent.MOUSE_UP))					
					draw_mc.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpDraw);				
				
				if (prev_mc && prev_mc.hasEventListener(MouseEvent.CLICK))								
					prev_mc.removeEventListener(MouseEvent.CLICK, mouseUpPrev);
					
				if (next_mc && next_mc.hasEventListener(MouseEvent.CLICK))				
					next_mc.removeEventListener(MouseEvent.CLICK, mouseUpNext);
					
				if (content_mc.parent.hasEventListener(MouseEvent.MOUSE_WHEEL))				
					content_mc.parent.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWhellContent);		
				
			}
			
		}			
	}	
}