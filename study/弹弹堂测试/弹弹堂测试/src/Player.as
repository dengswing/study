package  
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author rider
	 */
	public class Player extends Sprite
	{
		
		private var mc:MC_Role;
		private var mapData:BitmapData;
		private var gravity:Number	=	0.05;
		private var downSpeed:Number	=	1;
		
		private var isDown:Boolean	=	false;		// 是否在下坠
		
		public function Player(_mapData:BitmapData,_stage:Stage) 
		{
			mapData	=	_mapData;
			init();
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouse);
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouse);
		}
		private function init():void {
			mc	=	new MC_Role();
			addChild(mc);
		}
		private function onEnterFrame(e:Event):void
		{
			if (!(mapData.hitTest(new Point(), 0x01, new Point(this.x - (mc.hit.width / 2), this.y))) 
				&& !(mapData.hitTest(new Point(), 0x01, new Point(this.x + (mc.hit.width / 2), this.y)))) 
				{
					downSpeed += downSpeed * gravity;
					this.y += downSpeed ;
					
					if (!isDown)	isDown =	true;
				}else {
					if (isDown) {
						isDown	=	false;
						downSpeed	=	1;
						vectorXY(this.x,this.y);
					}
				}
		}
		/**
		 * 
		 * 传入X Y 
		 * @param	_x
		 * @param	_y
		 */
		private function vectorXY(_x:int, _y:int):void {
			
			var hitLeftY:int	=	_y;
			var hitLeft:uint	=	mapData.getPixel32(int(_x - mc.hit.width / 2),hitLeftY);
			/**
			 * 计算左右碰撞显示点
			 */
			if (hitLeft != 0)
			{			//判断当前状态是否与背景碰撞
				while (true)
				{			//如果碰撞，则往上找，找到空白像素点
					hitLeftY --;
					
					if (mapData.getPixel32(int(_x - mc.hit.width / 2), hitLeftY) == 0) {
						break;
					}
				}
			}else {					//如果未碰撞，往下找，找出与背景碰撞点
				while (true) {			
					hitLeftY ++;
					if (mapData.getPixel32(int(_x - mc.hit.width / 2), hitLeftY) != 0) {
						break;
					}else if (hitLeftY >= mapData.height) {
						break;
					}
				}
			}
			
			/**
			 * 计算右边碰撞点
			 */
			var hitRightY:int	=	_y;
			var hitRight:uint	=	mapData.getPixel32(int(_x + mc.hit.width / 2), hitRightY);
			
			
			if (hitRight != 0) {
				while (true) {
					hitRightY --;
					if (mapData.getPixel32(int(_x + mc.hit.width / 2), hitRightY) == 0) {
						break;
					}
				}
			}else {
				while (true) {
					hitRightY ++;
					if (mapData.getPixel32(int(_x + mc.hit.width / 2), hitRightY) != 0) {
						break;
					}else if (hitRightY >= mapData.height) {
						break;
					}
				}
			}
			
			/**
			 * 以角色中心点，重新计算Y坐标，更正Y
			 */
			var hitY:int	=	_y;
			var hit:uint	=	mapData.getPixel32(_x, hitY);
			
			
			if (hit != 0) {
				while (true) {
					hitY --;
					if (mapData.getPixel32(_x, hitY) == 0) {
						break;
					}
				}
			}else {
				while (true) {
					hitY ++;
					if (mapData.getPixel32(_x, hitY) != 0) {
						break;
					}else if (hitY >= mapData.height) {
						break;
					}
				}
			}
			
			/**
			 * 计算玩家的角度
			 */
			this.y	=	hitY + 1;
			this.x 	= 	_x;
			var _rotation:int = Math.atan2((hitRightY - hitLeftY),((_x + mc.hit.width / 2) - (_x - mc.hit.width / 2))) * 180 / Math.PI - this.rotation;
            if (this.rotation == 0) this.rotation = _rotation;
			else this.rotation = this.rotation + _rotation /4;
			
		}
		
		
		private function onKeyDown(e:KeyboardEvent):void {
			var _speed:int;
			if (e.keyCode == 39) {
				_speed = 3;
				this.scaleX = 1;
			}
			else if (e.keyCode == 37) {
				_speed = -3;
				this.scaleX = -1;
			}
			else return;
			vectorXY(this.x + _speed, this.y);
		}
		
		
		/**
		 * 按下鼠标
		 */
		private function onMouse(e:MouseEvent):void {
			this.graphics.clear();
			if (e.type == MouseEvent.MOUSE_DOWN) {
				this.graphics.lineStyle(1, 0xff0000);
				this.graphics.lineTo(this.mouseX, this.mouseY);
				this.graphics.moveTo(this.x, this.y);
				this.graphics.endFill();
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			}else {
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
				shot();
			}
		}
		private function onMove(e:MouseEvent):void {
			this.graphics.clear();
			this.graphics.lineStyle(1, 0xff0000);
			this.graphics.lineTo(this.mouseX, this.mouseY);
			this.graphics.moveTo(this.x, this.y);
			this.graphics.endFill();
		}
		/**
		 * 发射子弹
		 */
		private function shot():void
		{
			var _x:int	=	this.parent.mouseX - this.x;
			var _y:int	=	this.parent.mouseY - this.y;
			var _angle:Number = Math.atan2(_y, _x);
			trace(_angle);
			var grenade:Grenade = new Grenade(_angle, mapData, Math.sqrt(_x * _x + _y * _y));
			
			this.parent.addChild(grenade);
			grenade.x  	= this.x;
			grenade.y 	= this.y;
		}
	}

}