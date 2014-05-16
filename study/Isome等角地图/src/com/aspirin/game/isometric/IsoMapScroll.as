package com.aspirin.game.isometric {
	import flash.events.Event;	
	import flash.geom.Point;	
	import flash.events.MouseEvent;	
	import flash.display.Sprite;	

	/**
	 * @author ashi
	 */
	public class IsoMapScroll extends Map {
		protected var _container : Sprite;
		protected var _viewPort : Sprite;
		
		protected var _floor : Sprite;
		protected var _world : Sprite;
		protected var _char : Character;
		
		protected var _viewPortWidth : int = 550;
		protected var _viewPortHeight : int = 400;

		public function IsoMapScroll(colNum : uint, rowNum : uint) {
			super(colNum, rowNum);
		}

		public override function renderMap(container : Sprite) : void {
			//TODO remove all sprites & graphics when getting start
			_container = container;
			
			_viewPort = new Sprite();
			_floor = new Sprite();
			_world = new Sprite();
			
			container.addChild(_floor);
			container.addChild(_world);
			
			addCharacter();
			drawViewPort();
			
			drawTiles();
			container.addEventListener(MouseEvent.CLICK, clickHandler);
		}

		public function addCharacter() : void {
			_char = new Character(0xFF0000, Map.TILE_SIZE, _floor);
			_world.addChild(_char);
		}
		
		private function drawViewPort() : void
		{
			_viewPort.graphics.lineStyle(0,0,1);
			_viewPort.graphics.beginFill(0,1);
			_viewPort.graphics.drawRect(-_viewPortWidth/2, -_viewPortHeight/2, _viewPortWidth, _viewPortHeight);
			_container.addChild(_viewPort);
			_floor.mask = _viewPort;
		}
		
		private function drawTiles() : void
		{
			while(_floor.numChildren > 0) {
				_floor.removeChildAt(0);
			}
			
			for (var i : int = 0;i < _numCols; i++) {
				for (var j : int = 0;j < _numRows; j++) {
					var tile : IsoObject = _tiles[i][j];
					
					if(_tileTypes[tile.symbol]['isFloor'] == "true" && isInScreen(tile)) {
						_floor.addChild(tile);
					} else if(isInScreen(tile)){
						_world.addChild(tile);
					}
				}
			}
		}
		
		private function isInScreen(tile : IsoObject) : Boolean
		{
			if((tile.screenX + _floor.x> - _viewPortWidth/2 - tile.size && tile.screenX + _floor.x< _viewPortWidth/2 + tile.size)
			&& (tile.screenY + _floor.y> - _viewPortHeight/2 - tile.size && tile.screenY + _floor.y< _viewPortHeight/2 + tile.size))
			return true;
			else
			return false;
		}

		private function clickHandler(event : MouseEvent) : void {
			var x : Number = _floor.mouseX;
			var y : Number = _floor.mouseY;
			var target : Vector3D = IsoUtils.screenToIso(new Point(x, y));
			
			var col : int = Math.floor(Math.abs(_char.x / Map.TILE_SIZE));
			var row : int = Math.floor(Math.abs(_char.z / Map.TILE_SIZE));
			
			var start : IsoObject = _tiles[col][row];
			
			col = Math.floor(Math.abs((target.x + (Map.TILE_SIZE * 0.5)) / Map.TILE_SIZE));
			row = Math.floor(Math.abs((target.z + (Map.TILE_SIZE * 0.5)) / Map.TILE_SIZE));
			
			var end : IsoObject = _tiles[col][row];
			
			if(findPath(start, end))
			{
				endMoving();
				startMoving();
			}
		}
		
		private function startMoving() : void
		{
			path.shift();
			pathIndex = 0;
			_container.addEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		private function endMoving() : void
		{
			_container.removeEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		private var pathIndex : int = 0;
		private var v : int = 5;

		private function onUpdate(event : Event) : void {
			var targetX : Number = path[pathIndex].indexX * Map.TILE_SIZE;
			var targetY : Number = path[pathIndex].indexY * Map.TILE_SIZE;
			
			var dx : Number = targetX - _char.x;
			var dy : Number = targetY - _char.z;
			
			var angle : Number = Math.atan2(dy, dx);
			
			var dist : Number = Math.sqrt(dx * dx + dy * dy);
			
			if(dist > v)
			{
			   _char.x += int(v * Math.cos(angle));
			   _char.z += int(v * Math.sin(angle)); 
			}else if(dist <= v){
				_char.x = targetX;
				_char.z = targetY;
				
				pathIndex ++;
				if(pathIndex == path.length)
				{
				   endMoving();
				}else{
				   onUpdate(null);
				}
			}
			
			drawTiles();
		}
	}
}
