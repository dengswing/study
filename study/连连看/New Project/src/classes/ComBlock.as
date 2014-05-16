package classes
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	
	import util.*;
	import DemoEvent.*;
	public class  ComBlock extends MovieClip
	{
		
		public var 	flag 		:int = -1;
		public var currentNum 	:int = 0;
		public var _blank 		:int = 0;
		private var _randNum	:int = 0;
		
		private var _disp		:PickEventDispatcher;
		private var _id	 		:int;
		private var child		:Shape;
		private var conMC:MovieClip;
		
		public function ComBlock(id,disp:PickEventDispatcher,blank,randNum)
		{
			_id	   		= id;
			_disp  		= disp;
			_blank 		= blank;
			_randNum 	= randNum;
			initGame();
			initEvent();
			
		}
		private function initGame():void
		{
			conMC = new BoxIcon();
			addChild(conMC);
			
			this.cacheAsBitmap  = true;
			
			if(_blank == 1)
			{
				this.mouseChildren  = false;
				this.buttonMode 	= true;
				//this.tt.text        = _randNum.toString();
				//this.blanktxt.text  = _id.toString();
				conMC.gotoAndStop(_randNum+1);
			}
			else
			{
				this.alpha = 0.2;
			}
		}
		private function initEvent():void
		{
			if(_blank == 1)this.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoveHandler);
		}
		
		/*
		 * @ Function 
		 */
		public function drawRect():void
		{
			child = new Shape();
            child.graphics.lineStyle(2, 0x0000FF);
            child.graphics.drawRect(-30, -30, 60, 60);
          
            addChild(child);
		}
		public function clearRect():void
		{
			trace('clear');
			Clear.removeChild(child);
		}
		
		private function killAll():void
		{
			Clear.removeEvent(this,MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
		}		
		/*
		 * @ Event
		 */
		 private function onMouseDownHandler(evt:MouseEvent):void
		 {
			 flag = -flag;
			 if(flag==1)
			 {
				currentNum =_randNum; 	
				//trace('text:'+_currentNum);
			 	//this.gotoAndStop(2);
				this.alpha = 0.8;
				drawRect();
			 }
			 else
			 {
				 currentNum = 0;
				// this.gotoAndStop(1);
				this.alpha = 1.0;
				clearRect();
			 }
			// trace(flag);
			 _disp.doMouseDown(this.currentNum,this.flag,this._id);
		 }
		private function onRemoveHandler(evt:Event):void
		{ 
			killAll();
			evt.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoveHandler);
		}
		 
	}
	
}