package com.aspirin.game.isometric {
	import com.aspirin.game.isometric.Vector3D;

	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class IsoObject extends Sprite {
		protected var _position : Vector3D;
		protected var _size : Number;
		protected var _walkable : Boolean = true;
		protected var _vx : Number = 0;
		protected var _vy : Number = 0;
		protected var _vz : Number = 0;
		protected var _symbol : String = "0";
		
		public var indexX:int;
		public var indexZ:int;
		public var f:Number;
		public var g:Number;
		public var h:Number;
		public var parentObject:IsoObject;
		public var costMultiplier:Number = 1.0;
		
		// a more accurate version of 1.2247...
		public static const Y_CORRECT : Number = Math.cos(-Math.PI / 6) * Math.SQRT2;

		/**
		 * iso
		 * @param	size	占地面积
		 * @param	symbol	物品类型
		 */
		public function IsoObject(size : Number, symbol : String) {
			_size = size;
			_position = new Vector3D();
			_symbol = symbol;
			updateScreenPosition();
		}

		/**
		 * Converts current 3d position to a screen position 
		 * and places this display object at that position.
		 */
		protected function updateScreenPosition() : void {
			var screenPos : Point = IsoUtils.isoToScreen(_position);
			super.x = screenPos.x;
			super.y = screenPos.y;
		}

		/**
		 * String representation of this object.
		 */
		override public function toString() : String {
			return "[IsoObject (x:" + _position.x + ", y:" + _position.y + ", z:" + _position.z + ")]";
		}

		/**
		 * Sets / gets the x position in 3D space.
		 */
		override public function set x(value : Number) : void {
			_position.x = value;
			updateScreenPosition();
		}

		override public function get x() : Number {
			return _position.x;
		}
		
		public function get screenX() : Number {
			var screenPos : Point = IsoUtils.isoToScreen(_position);
			return screenPos.x;
		}

		/**
		 * Sets / gets the y position in 3D space.
		 */
		override public function set y(value : Number) : void {
			_position.y = value;
			updateScreenPosition();
		}

		override public function get y() : Number {
			return _position.y;
		}
		
		public function get screenY() : Number {
			var screenPos : Point = IsoUtils.isoToScreen(_position);
			return screenPos.y;
		}

		/**
		 * Sets / gets the z position in 3D space.
		 */
		override public function set z(value : Number) : void {
			_position.z = value;
			updateScreenPosition();
		}

		override public function get z() : Number {
			return _position.z;
		}

		/**
		 * Sets / gets the position in 3D space as a Point3D.
		 */
		public function set position(value : Vector3D) : void {
			_position = value;
			updateScreenPosition();
		}

		public function get position() : Vector3D {
			return _position;
		}

		/**
		 * Returns the transformed 3D depth of this object.
		 */ 
		public function get depth() : Number {
			return (_position.x + _position.z) * .866 - _position.y * .707;
		}

		/**
		 * Indicates whether the space occupied by this object can be occupied by another object.
		 */
		public function set walkable(value : Boolean) : void {
			_walkable = value;
		}

		public function get walkable() : Boolean {
			return _walkable;
		}

		/**
		 * Returns the size of this object.
		 */
		public function get size() : Number {
			return _size;
		}

		/**
		 * Returns the square area on the x-z plane that this object takes up.
		 */
		public function get rect() : Rectangle {
			return new Rectangle(x - size / 2, z - size / 2, size, size);
		}

		/**
		 * Sets / gets the velocity on the x axis.
		 */
		public function set vx(value : Number) : void {
			_vx = value;
		}

		public function get vx() : Number {
			return _vx;
		}

		/**
		 * Sets / gets the velocity on the y axis.
		 */
		public function set vy(value : Number) : void {
			_vy = value;
		}

		public function get vy() : Number {
			return _vy;
		}

		/**
		 * Sets / gets the velocity on the z axis.
		 */
		public function set vz(value : Number) : void {
			_vz = value;
		}

		public function get vz() : Number {
			return _vz;
		}
		
		public function get screenWidth():Number
		{
			return super.width;
		}
		
		public function get screenHeight():Number
		{
			return super.height;
		}
		
		public function set symbol(symbol : String) : void {
			_symbol = symbol;
		}
		
		public function get symbol() : String {
			return _symbol;
		}
		
		//
		public function draw() : void
		{
			
		}
	}
}