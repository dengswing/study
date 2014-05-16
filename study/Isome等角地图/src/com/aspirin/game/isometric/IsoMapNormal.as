package com.aspirin.game.isometric {
	import com.aspirin.game.isometric.items.GraphicCube;
	import com.aspirin.game.isometric.items.Item;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;	

	/**
	 * @author ashi
	 */
	public class IsoMapNormal extends Map {
		protected var _container : Sprite;

		protected var _floor : Sprite;
		protected var _world : Sprite;
		protected var _char : Character;

		protected var _sortedItems : Array = new Array();

		public function IsoMapNormal(colNum : uint, rowNum : uint) {
			super(colNum, rowNum);
		}

		public override function renderMap(container : Sprite) : void {
			//TODO remove all sprites & graphics when getting start
			_container = container;
			
			_floor = new Sprite();
			_world = new Sprite();
			
			container.addChild(_floor);
			container.addChild(_world);
			
			addCharacter();	//添加人物
			
			drawTiles();	//添加格子
			sort();		//排序
			
			container.stage.addEventListener(MouseEvent.CLICK, clickHandler);
		}

		public function addCharacter() : void {
			_char = new Character(0xFF0000, Map.TILE_SIZE, null);
			_char.x = _numCols / 2 * Map.TILE_SIZE;
			_char.z = _numRows / 2 * Map.TILE_SIZE;
			_char.col = Math.floor(Math.abs((_char.x + (Map.TILE_SIZE * 0.5)) / Map.TILE_SIZE));
			_char.row = Math.floor(Math.abs((_char.z + (Map.TILE_SIZE * 0.5)) / Map.TILE_SIZE));
			_sortedItems.push(_char);
			_world.addChild(_char);
		}

		private function drawTiles() : void {
			while(_floor.numChildren > 0) {
				_floor.removeChildAt(0);
			}
			
			for (var i : int = 0;i < _numCols; i++) {
				for (var j : int = 0;j < _numRows; j++) {
					var tile : Tile = _tiles[i][j];
					tile.draw();
					_floor.addChild(tile);
					
					if(tile.symbol != "0") {
						addItem(tile, tile.symbol);
					}
				}
			}
		}
		
		/**
		 * 添加物品
		 * @param	tile
		 * @param	symbol
		 */
		private function addItem(tile : Tile, symbol : String) : void {
			var item : Item;
			switch(tileTypes[symbol].type) {
				case "GraphicCube":
					item = new GraphicCube(symbol);
					break;
			}
			
			if(isItemPlacement(item, tile.indexX, tile.indexZ)) {
				for (var i : int = tile.indexX;i < tile.indexX + item.cols;++i) {
					for (var j : int = tile.indexZ;j < tile.indexZ + item.rows;++j) {
						if(i < _numCols && j < _numRows) {
							var the_tile : Tile = _tiles[i][j];
							the_tile.addItem(item);
						}
					}
				}
				item.position = tile.position;
				item.col = tile.indexX;
				item.row = tile.indexZ;
				
				item.draw();
				_world.addChild(item);
				_sortedItems.push(item);
			}
			
		}
		
		/**
		 * 检测是否可以放置物品
		 * @param	item
		 * @param	col
		 * @param	row
		 * @return
		 */
		private function isItemPlacement(item : Item, col : int, row : int) : Boolean {
			var valid : Boolean = true;
			
			for (var i : int = col;i < col + item.cols;++i) {
				for (var j : int = row;j < row + item.rows;++j) {
					if(i < _numCols && j < _numRows) {
						var tile : Tile = _tiles[i][j];
						if (tile == null || tile.items.length > 0) {
							valid = false;
							break;
						}
					} else {
						return false;
					}
				}
			}
			return valid;
		}

		private var depth : uint;
		private var visitedItems : Dictionary = new Dictionary();
		private var dependency : Dictionary;
		
		/**
		 * 深度排序
		 */
		public function sort() : void {
			/*_sortedItems.sortOn(["row", "col"], [Array.NUMERIC, Array.NUMERIC]);
			depth = 0;
			for each(var k:Item in _sortedItems) {
				_world.addChildAt(k, depth);
				++depth;
			}
			return;*/
			
			dependency = new Dictionary();
			
			var children : Array = _sortedItems.slice();
			var max : uint = children.length;
			for (var i : uint = 0;i < max; ++i) {
				var behind : Array = [];
				var objA : Item = children[i];
				var rightA : Number = objA.col + objA.cols;
				var frontA : Number = objA.row + objA.rows;
				for (var j : uint = 0;j < max; ++j) {
					var objB : Item = children[j];
					// See if B should go behind A
					// simplest possible check, interpenetrations also count as "behind", which does do a bit more work later, but the inner loop tradeoff for a faster check makes up for it
					if ((objB.col < rightA) && (objB.row < frontA) && (i !== j)) {
						behind.push(objB);
					}
				}
				
				dependency[objA] = behind;
			}
			
			//trace("sort",depth);
			depth = 0;
			for each (var obj:Item in children)
				if (true !== visitedItems[obj])
					place(obj);
					
			visitedItems = new Dictionary();
			/*var copy : Array = _sortedItems.slice();
			var root : Node = new Node(copy[0]);
			for (var i : int = 1;i < copy.length; i++) {
				root.addItem(copy[i]);
			}
			var res : Array = new Array();
			root.toList(res);
			for (var j : int = 0;j < res.length; j++) {
				_world.addChild(res[j]);
			}*/
		}
		
		private function place(obj:Item):void
		{
			visitedItems[obj] = true;
			for each(var inner:Item in dependency[obj])
				if(true !== visitedItems[inner]){
					place(inner);
				}
			
			/*if (depth != obj.depth)
			{*/
				_world.addChildAt(obj, depth);
				//trace("obj.depth", depth, obj.toString());
			//}
			
			++depth;
		};

		private function clickHandler(event : MouseEvent) : void {
			var x : Number = _floor.mouseX;
			var y : Number = _floor.mouseY;
			var target : Vector3D = IsoUtils.screenToIso(new Point(x, y));
			
			var col : int = Math.floor(Math.abs(_char.x / Map.TILE_SIZE));
			var row : int = Math.floor(Math.abs(_char.z / Map.TILE_SIZE));
			
			var start : IsoObject = _tiles[col][row];
			
			col = Math.floor(Math.abs((target.x + (Map.TILE_SIZE * 0.5)) / Map.TILE_SIZE));
			row = Math.floor(Math.abs((target.z + (Map.TILE_SIZE * 0.5)) / Map.TILE_SIZE));
			
			if(col < _numCols && col >= 0 && row < _numRows && row >= 0) {
				var end : IsoObject = _tiles[col][row];
			
				if(findPath(start, end)) {
					endMoving();
					startMoving();
				}
			}
		}

		private function startMoving() : void {
			path.shift();
			pathIndex = 0;
			if(path.length > 0)
			_container.addEventListener(Event.ENTER_FRAME, onUpdate);
		}

		private function endMoving() : void {
			_container.removeEventListener(Event.ENTER_FRAME, onUpdate);
		}

		private var pathIndex : int = 0;	//移动路径
		private var v : int = 4;	//移动速度

		private function onUpdate(event : Event) : void {
			var targetX : Number = path[pathIndex].indexX * Map.TILE_SIZE;
			var targetZ : Number = path[pathIndex].indexZ * Map.TILE_SIZE;
			
			var dx : Number = targetX - _char.x;
			var dy : Number = targetZ - _char.z;
			
			var angle : Number = Math.atan2(dy, dx);
			
			var dist : Number = Math.sqrt(dx * dx + dy * dy);			
			
			if(dist > v) {
				_char.x += int(v * Math.cos(angle));
				_char.z += int(v * Math.sin(angle)); 
				_char.col = Math.floor(Math.abs((_char.x + (Map.TILE_SIZE * 0.5)) / Map.TILE_SIZE));
				_char.row = Math.floor(Math.abs((_char.z + (Map.TILE_SIZE * 0.5)) / Map.TILE_SIZE));
				sort();
			}else if(dist <= v) {
				//_char.x = targetX;
				//_char.z = targetY;

				pathIndex++;
				if(pathIndex == path.length) {
					_char.x = targetX;
					_char.z = targetZ;
					_char.col = Math.floor(Math.abs((_char.x + (Map.TILE_SIZE * 0.5)) / Map.TILE_SIZE));;
					_char.row = Math.floor(Math.abs((_char.z + (Map.TILE_SIZE * 0.5)) / Map.TILE_SIZE));
					sort();
					endMoving();
				} else {
					onUpdate(null);
				}
			}
			
			//drawTiles();
		}
	}
}
