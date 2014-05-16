package index.base.geom{
	
	import flash.events.EventDispatcher;
	import flash.display.DisplayObject;
	
	import index.base.events.DotEvent;
	
	public class Dot extends EventDispatcher{
		
		private var _x:Number;
		private var _y:Number;
		private var _r:Number;
		private var dis:DisplayObject;
		
		public var isListen:Boolean;
		
		public function Dot(x_:Number = 0,y_:Number = 0,r_:Number = 0,_isListen:Boolean = false){
			_x = x_;
			_y = y_;
			_r = r_;
			isListen = _isListen;
		}
		
		//绑定DisplayObject
		public function bind(_dis:DisplayObject,isInTime:Boolean = false):void{
			dis = _dis;
			updata();
			if(isInTime) dis.addEventListener("enterFrame",enterFrameFun);
		}
		
		//帧频繁事件
		private function enterFrameFun(e:Object):void{
			if(_x != dis.x) x = dis.x;
			if(_y != dis.y) y = dis.y;
			if(_r != dis.rotation) r = dis.rotation;
		}
		
		//更新xy数据
		public function updata():void{
			if(dis != null){
				_x = dis.x;
				_y = dis.y;
				_r = dis.rotation;
			}
		}
		
		//计算该点向R方向前进某距离后的点
		public function go(num:Number,isChange:Boolean = false):Dot{
			updata();
			var yx:Number = Math.tan(_r * Math.PI / 180);
			var tmpx:Number = num / Math.sqrt(Math.pow(yx,2) + 1);
			var tmpy:Number = tmpx * yx;
			var n:int = Number(Math.abs(_r) <= 90) * 2 - 1;
			var dot:Dot = new Dot(_x + tmpx * n,_y + tmpy * n,_r);
			if(isChange){
				x = dot.x;
				y = dot.y;
			}
			return dot;
		}
		
		//计算该点与另外一点的距离
		public function from(_dot:Dot,isQuadrant:Boolean = false):Number{
			updata();
			var num:Number = Math.sqrt(Math.pow(_dot.x - _x,2) + Math.pow(_dot.y - _y,2));
			if(!isQuadrant) num = Math.abs(num);
			return num;
		}
		
		//计算该点与另外一点所形成的线段与水平线的夹角,按顺时间计算
		public function angle(_dot:Dot,isRadian:Boolean = false):Number{
			updata();
			var numx:Number = _dot.x - _x;
			var numy:Number = _dot.y - _y;
			var num:Number = Math.atan(numy/numx);
			if(!isRadian) num = num * 180 / Math.PI;
			return num;
		}
		
		//返回当前点处在另外一点的哪个象限中 或 返回另外一点处在当前点的哪个象限中
		public function quadrant(_dot:Dot,isMaster:Boolean = true):int{
			updata();
			if(_x == _dot.x || _y == _dot.y){
				return 0;
			}
			
			var num:int;
			var p1:Boolean = (_x - _dot.x) > 0;
			var p2:Boolean = (_y - _dot.y) > 0;
			num = isMaster ? (p1 ? (p2 ? 2 : 3) : (p2 ? 1 : 4)) : (p1 ? (p2 ? 4 : 1) : (p2 ? 3 : 2));
			
			return num;
		}
		
		//返回该点距0点的距离
		public function get length():Number{
			updata();
			var num:Number = Math.sqrt(Math.pow(_x,2) + Math.pow(_y,2));
			return num;
		}
		
		//清除显示对象
		public function clear():void{
			dis = null;
		}
		
		//改变旋转值
		public function set r(num:Number):void{
			_r = num;
			if(dis != null) dis.rotation = num;
			if(isListen) dispatchEvent(new DotEvent(DotEvent.R_CHANGE,true));
		}
		
		//改变旋转值
		public function get r():Number{
			updata();
			return _r;
		}
		
		//改变X坐标
		public function set x(num:Number):void{
			_x = num;
			if(dis != null) dis.x = num;
			if(isListen) dispatchEvent(new DotEvent(DotEvent.X_CHANGE,true));
		}
		
		//设置X坐标
		public function get x():Number{
			updata();
			return _x;
		}
		
		//改变Y坐标
		public function set y(num:Number):void{
			_y = num;
			if(dis != null) dis.y = num;
			if(isListen) dispatchEvent(new DotEvent(DotEvent.Y_CHANGE,true));
		}
		
		//设置Y坐标
		public function get y():Number{
			updata();
			return _y;
		}
	}
}