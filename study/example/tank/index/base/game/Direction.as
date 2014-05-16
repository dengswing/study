package index.base.game{
	
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.display.InteractiveObject;
	
	import index.base.events.DirectionEvent;
	
	public class Direction extends EventDispatcher{
		
		//方向表示
		public static const UP:uint = 0;
		public static const DOWN:uint = 1;
		public static const LEFT:uint = 2;
		public static const RIGHT:uint = 3;
		
		//作用区域
		public var area:InteractiveObject;
		//是否单向
		public var sole:Boolean;
		
		//上下左右键值
		private const directionAr:Array = new Array(4);
		
		//是否上下左右
		private var _up:Boolean = false;
		private var _down:Boolean = false;
		private var _left:Boolean = false;
		private var _right:Boolean = false;
		
		public function Direction(_area:InteractiveObject,isSole:Boolean = false,_up:uint = 38,_down:uint = 40,_left:uint = 37,_right:uint = 39){
			area = _area;
			sole = isSole;
			directionAr[UP] = _up;
			directionAr[DOWN] = _down;
			directionAr[LEFT] = _left;
			directionAr[RIGHT] = _right;
			start();
		}
		
		//开始获取事件
		public function start():void{
			area.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			area.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			area.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		//事件帧频繁触发
		private function onEnterFrame(e:Event):void{
			var num:uint = Number(_up) + Number(_down) + Number(_left) + Number(_right);
			if(num == 0){
				return;
			}
			
			var eve:DirectionEvent = new DirectionEvent(DirectionEvent.DO);
			eve.up = _up;
			eve.down = _down;
			eve.left = _left;
			eve.right = _right;
			dispatchEvent(eve);
		}
		
		//停止获取事件
		public function stop():void{
			area.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			area.removeEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			area.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		//鼠标按下去事件
		private function onKeyDown(e:KeyboardEvent):void{
			key(e.keyCode,true)
		}
		
		//鼠标弹上来事件
		private function onKeyUp(e:KeyboardEvent):void{
			key(e.keyCode,false)
		}
		
		//变化状态
		private function key(num:uint,isDown:Boolean):void{
			switch(num){
				case directionAr[UP]:
					if(sole) clear();
					_up = isDown;
				break;
				case directionAr[DOWN]:
					if(sole) clear();
					_down = isDown;
				break;
				case directionAr[LEFT]:
					if(sole) clear();
					_left = isDown;
				break;
				case directionAr[RIGHT]:
					if(sole) clear();
					_right = isDown;
				break;
			}
		}
		
		//设置按钮
		public function setKey(num:uint,vars:uint):void{
			directionAr[num] = vars;
		}
		
		//清空按键
		public function clear():void{
			_up = _down = _left = _right = false;
		}
	}
}