package com.aspirin.game.isometric {
	import com.aspirin.game.isometric.items.Item;	
	
	public class Tile extends IsoObject {
		protected var _height : Number;
		protected var _color : uint = 0xFFFFFF;
		
		protected var _items : Array = new Array();
		
		public function Tile(size : Number, symbol : String) {
			super(size, symbol);
			_height = height;
		}

		/**
		 * Draw the tile.
		 */
		override public function draw() : void {
			graphics.clear();
			graphics.beginFill(_color);
			graphics.lineStyle(0, 0, .5);
			graphics.moveTo(-size, 0);
			graphics.lineTo(0, -size * .5);
			graphics.lineTo(size, 0);
			graphics.lineTo(0, size * .5);
			graphics.lineTo(-size, 0);
		}

		/**
		 * Sets / gets the height of this object. Not used in this class, but can be used in subclasses.
		 */
		override public function set height(value : Number) : void {
			_height = value;
			draw();
		}

		override public function get height() : Number {
			return _height;
		}

		/**
		 * Sets / gets the color of this tile.
		 */
		public function set color(value : uint) : void {
			_color = value;
			draw();
		}

		public function get color() : uint {
			return _color;
		}
		
		public function addItem(item:Item):void {
			_items.push(item);
		}
		
		public function removeItem(item:Item):void {
			for (var i:int = 0; i < _items.length;++i) {
				if (_items[i] == item) {
					_items.splice(i, 1);
					break;
				}
			}
		}
		
		public function get items() : Array {
			return _items;
		}
	}
}