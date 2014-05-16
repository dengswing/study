package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * 可以指定热点的Sprite。
	 * 使用这个类来指定鼠标响应的热点比使用Sprite的hitArea效率高
	 */
	public class HitAreaSprite extends Sprite
	{
		
		public function HitAreaSprite() 
		{
			addRollOverListener();
		}
		
		//-----------------------------------------------------------------------------------------------------------------------------
		// 重写方法
		//-----------------------------------------------------------------------------------------------------------------------------
		
		override public function set mouseEnabled(bool:Boolean):void
		{
			throw new Error("MouseEnabled unsupported");
		}
		
		//-----------------------------------------------------------------------------------------------------------------------------
		// 抽象方法，子类覆盖
		//-----------------------------------------------------------------------------------------------------------------------------
		
		/**
		 * 获得显示对象的矩形边界
		 * 
		 * @return
		 */
		protected function getSpriteBounds():Rectangle
		{
			throw new Error("Abstract method");
		}
		
		/**
		 * 判断鼠标点是否在热点中
		 * 
		 * @param	mouseX
		 * @param	mouseY
		 * 
		 * @return	如果鼠标点在热点中返回true
		 */
		protected function inHitArea(mouseX:Number, mouseY:Number):Boolean
		{
			throw new Error("Abstract method");
		}
		
		//-----------------------------------------------------------------------------------------------------------------------------
		// Listeners
		//-----------------------------------------------------------------------------------------------------------------------------
		
		private function rollOverHandler(event:MouseEvent):void 
		{
			event.stopImmediatePropagation();
			super.mouseEnabled = false;
			removeRollOverListener();
			addEnterFrameListener();
		}
		
		private function enterFrameHandler(event:Event):void 
		{
			var bounds:Rectangle = getSpriteBounds();
			if (bounds == null || !bounds.contains(mouseX, mouseY))
			{
				addRollOverListener();
				removeEnterFrameListener();
				super.mouseEnabled = true;
				return;
			}
			if (inHitArea(mouseX, mouseY))
			{
				super.mouseEnabled = true;
			}
			else
			{
				super.mouseEnabled = false;
			}
		}
		
		private function addEnterFrameListener():void
		{
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function removeEnterFrameListener():void
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function addRollOverListener():void
		{
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, int.MAX_VALUE);
		}
		
		private function removeRollOverListener():void
		{
			removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
		}
		
		//-----------------------------------------------------------------------------------------------------------------------------
		// 实现 IDestroy 接口
		//-----------------------------------------------------------------------------------------------------------------------------
		
		public function destroy():void
		{
			removeEnterFrameListener();
			removeRollOverListener();
		}
	}

}