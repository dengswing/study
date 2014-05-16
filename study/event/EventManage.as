package 
{
	import flash.display.Sprite;

	import flash.events.Event;
	import flash.display.DisplayObject
	/**
	 * ...
	 * @author dengSwing
	 */
	public class EventManage extends Sprite  
	{		
		public function EventManage() {
			initEventManage();
		}
		
		private function initEventManage():void {	
			
			var mySprite:SpriteManage = new SpriteManage(20, 20, 20, "big");	
			//mySprite.name = "bigMain";
			addChild(mySprite);
			
			var mySprite_1:SpriteManage = new SpriteManage(50, 20, 20, "small_1");
			//mySprite_1.name = "small_1Main";
			
			var mySprite_2:SpriteManage = new SpriteManage(40, 30, 20, "small_2");
			//mySprite_2.name = "small_2Main";
			
			mySprite.addChild(mySprite_1);
			mySprite.addChild(mySprite_2);
			
			mySprite.addEventListener(SpriteManage.MY_CLICK, myClickHandler_1);
			mySprite_1.addEventListener(SpriteManage.MY_CLICK, myClickHandler_2);
			mySprite_2.addEventListener(SpriteManage.MY_CLICK, myClickHandler_3);
			
			
			
			
		}
		
		
		private function myClickHandler_1(evt:Event):void {
			trace("1=====>" + evt.target.name, evt.currentTarget.name);
		}
		private function myClickHandler_2(evt:Event):void {
			trace("2=====>" + evt.target.name, evt.currentTarget.name);
		}
		private function myClickHandler_3(evt:Event):void {
			trace("3=====>" + evt.target.name, evt.currentTarget.name);
		}
		
	}
	
}
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;


class SpriteManage extends Sprite {	
	internal static const MY_CLICK:String = "yes_click";
	
	public function SpriteManage(x:Number = 0, y:Number = 0, size:Number = 20,name:String="ha") {
		this.name = name;
		
		addChild(createCircle(x, y, size));
		init();
	}
	private function init():void {
		this.addEventListener(MouseEvent.CLICK, clickHandler);	
	}
	
	
	private function clickHandler(mouseEvt:MouseEvent):void {	
		trace(this.name, "==>" + mouseEvt.target, mouseEvt.target.name, mouseEvt.currentTarget, mouseEvt.currentTarget.name);
		dispatcher();
		
		/*
		 *  small_2 ==>[object Sprite] hh [object SpriteManage] small_2
			3=====>small_2 small_2
			big ==>[object Sprite] hh [object SpriteManage] big
			1=====>big big
			
			
			small_2 ==>[object Sprite] hh [object SpriteManage] small_2
			3=====>small_2 small_2
			1=====>small_2 big
			big ==>[object Sprite] hh [object SpriteManage] big
			1=====>big big

		*/
	}
	private function dispatcher():void {			
		this.dispatchEvent(new Event(SpriteManage.MY_CLICK, true, false));
	}
	
	private function createCircle(x:Number=0,y:Number=0,size:Number=20):Sprite {
		var mySprite:Sprite = new Sprite();
		mySprite.graphics.beginFill(0xFF0000, 0.5);
		mySprite.graphics.drawCircle(0, 0, size);
		mySprite.graphics.endFill();		
		mySprite.x = x;
		mySprite.y = y;			
		mySprite.name = "hh";
		return mySprite;
	}
}