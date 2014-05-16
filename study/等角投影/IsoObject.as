package {	
	import flash.display.Sprite
	import flash.geom.Point
	import flash.geom.Rectangle;
	
	public class IsoObject extends Sprite
	{
		
		protected var _position:Point3D;
		protected var _size:Number;
		protected var _walkable:Boolean = false
		
		// 1.2247 的精确计算版本
		public static const Y_CORRECT:Number = Math.cos(Math.PI / 6) * Math.SQRT2;
		
		protected var _vx:Number = 0;
		protected var _vy:Number = 0;
		protected var _vz:Number = 0;
		
		public function IsoObject(size:Number)
		{
			_size = size;
			_position = new Point3D();
			updateScreenPosition();
		}
		
		/**
		* 把当前时刻的一个3D 坐标点转换成屏幕上的2D 坐标点
		* 并将自己安置于该点
		*/
		protected function updateScreenPosition():void
		{
			var screenPos:Point = IsoUtils.isoToScreen(_position);
			super.x = screenPos.x;
			super.y = screenPos.y;
		}
		
		/**
		* 自身的具体描述方式
		*/
		override public function toString():String
		{
			return "[IsoObject (x:" + _position.x + ", y:" + _position.y+ ", z:" + _position.z + ")]";
		}
		
		/**
		* 设置/读取3D 空间中的x 坐标
		*/
		override public function set x(value:Number):void
		{
			_position.x = value;
			updateScreenPosition();
		}
		
		override public function get x():Number
		{
			return _position.x;
		}
		
		/**
		* 设置/读取3D 空间中的y 坐标
		*/
		override public function set y(value:Number):void
		{
			_position.y = value;			
			updateScreenPosition();
		}
		
		override public function get y():Number
		{
			return _position.y;
		}
		
		/**
		* 设置/读取3D 空间中的z 坐标
		*/
		override public function set z(value:Number):void
		{
			_position.z = value;
			updateScreenPosition();
		}
		
		override public function get z():Number
		{
			return _position.z;
		}
		
		/**
		* 设置/读取3D 空间中的坐标点
		*/
		public function set position(value:Point3D):void
		{
			_position = value;
			updateScreenPosition();
		}
		
		public function get position():Point3D
		{
			return _position;
		}
		
		/**
		* 返回形变后的层深
		*/
		public function get depth():Number
		{
			return (_position.x + _position.z) * .866 - _position.y * .707;
		}
		
		/**
		* 指定其它对象是否可以经过所占的位置
		*/
		public function set walkable(value:Boolean):void
		{
			_walkable = value;
		}
		
		public function get walkable():Boolean
		{
			return _walkable;
		}
		
		/**
		* 返回尺寸
		*/
		public function get size():Number
		{
			return _size;
		}
		
		/**
		* 返回占用着的矩形
		*/
		public function get rect():Rectangle
		{
			return new Rectangle(x - size / 2, z - size / 2, size, size);
		}
		
		
		/**
		* 设置和读取x 轴方向上的速度
		*/
		public function set vx(value:Number):void		
		{
			_vx = value;
		}
		
		public function get vx():Number
		{
			return _vx;
		}
		
		/**
		* 设置和读取y 轴方向上的速度
		*/
		public function set vy(value:Number):void
		{
			_vy = value;
		}
		
		public function get vy():Number
		{
			return _vy;
		}
		
		/**
		* 设置和读取z 轴方向上的速度
		*/
		public function set vz(value:Number):void
		{
			_vz = value;
		}
		public function get vz():Number
		{
			return _vz;
		}
	}
}