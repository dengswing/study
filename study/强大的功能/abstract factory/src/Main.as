package 
{
	import factory.ClothesShops;
	import factory.DecorateShops;
	import factory.ShopsShow;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import interfaceI.IFactoryShops;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Main extends Sprite 
	{
		//商店显示
		private var myShowShops:ShopsShow;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point		
			
			//创建按钮
			for (var i:int = 0; i < 3; i++) {				
				var btn:DrawRect = new DrawRect();
				btn.name = "btn" + i;
				btn.x = i * 50;
				btn.y = 100;
				btn.addEventListener(MouseEvent.CLICK, clickHandler);		
				addChild(btn);
			}			
		}
		
		/**
		 * 处理按钮事件
		 * @param	e
		 */
		private function clickHandler(e:MouseEvent):void 
		{
			switch(e.target.name) {
				case "btn0":	//衣服商店显示	
					myShowShops = new ShopsShow(new ClothesShops());	
					break;
				case "btn1":	//装饰商店显示
					myShowShops = new ShopsShow(new DecorateShops());	
					break;
				default:
					myShowShops = null;
					break;				
			}
			
			//商店显示
			if (myShowShops)
				myShowShops.operateShow();			
		}
		
	}
	
}

class DrawRect extends flash.display.Sprite {
	
	public function DrawRect() {
		this.graphics.beginFill(Math.random() * 0xFFFFFF);
		this.graphics.drawRect(0, 0, 20, 20);
		this.graphics.endFill();		
	}	
}