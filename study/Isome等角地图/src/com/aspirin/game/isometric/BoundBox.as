package com.aspirin.game.isometric {
	import flash.geom.Point;	
	
	/**
	 * @author ashi
	 */
	public class BoundBox{
		private var _left : Point;
		private var _top : Point;
		private var _bottom : Point;
		private var _right : Point;
		
		public function BoundBox(left : Point = null, top : Point = null, bottom : Point = null, right : Point = null) : void {
			this.left = left;
			this.top = top;
			this.bottom = bottom;
			this.right = right;
		}
		
		public function get left() : Point {
			return _left;
		}
		
		public function set left(left : Point) : void {
			_left = left;
		}
		
		public function get top() : Point {
			return _top;
		}
		
		public function set top(top : Point) : void {
			_top = top;
		}
		
		public function get bottom() : Point {
			return _bottom;
		}
		
		public function set bottom(bottom : Point) : void {
			_bottom = bottom;
		}
		
		public function get right() : Point {
			return _right;
		}
		
		public function set right(right : Point) : void {
			_right = right;
		}
	}
}
