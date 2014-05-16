package com.aspirin.game.isometric {
	import flash.display.Sprite;	
	
	/**
	 * @author ashi
	 */
	public class Map {
		public static const TILE_SIZE : uint = 20;

		protected var _numCols : int;	//最大行
		protected var _numRows : int;	//最大列

		//格子
		protected var _tiles : Array;
		protected var _tileTypes : Object;	//物品绑定类型

		/**
		 * 地图
		 * @param	numCols		max行
		 * @param	numRows		max列
		 */
		public function Map(numCols : uint, numRows : uint) {
			_numCols = numCols;
			_numRows = numRows;
			//trace(_numCols + ":" + _numRows);
			_tiles = new Array(_numCols);
			for(var i : int = 0;i < _numCols; i++) {
				_tiles[i] = new Array(numRows);
			}
		}

		/**
		 * 设置格子数据
		 * @param	x
		 * @param	y
		 * @param	tile
		 */
		public function setTile( x : int, y : int, tile : IsoObject ) : void {
			//TODO: validate the tile
			_tiles[x][y] = tile;
		}
		
		public function get tileTypes() : Object {
			return _tileTypes;
		}
		
		public function set tileTypes(tileTypes : Object) : void {
			_tileTypes = tileTypes;
		}
		
		/**
		 * 显示地图
		 * @param	container
		 */
		public function renderMap(container : Sprite) : void {
		}

		//寻路
		private var _open : Array;
		private var _closed : Array;
		private var _endNode : IsoObject;
		private var _startNode : IsoObject;
		private var _path : Array;	//最近的路

		private var _heuristic : Function = diagonal;
		private var _straightCost : Number = 1.0;
		private var _diagCost : Number = Math.SQRT2;
		
		public function findPath(start : IsoObject, end : IsoObject) : Boolean
		{
			_open = new Array();
			_closed = new Array();
			
			_startNode = start;
			_endNode = end;
			
			_startNode.g = 0;
			_startNode.h = _heuristic(_startNode);
			_startNode.f = _startNode.g + _startNode.h;
			
			return search();
		}
		
		public function search():Boolean
		{
			var node:IsoObject = _startNode;
			while(node != _endNode)
			{
				var startX:int = Math.max(0, node.indexX - 1);
				var endX:int = Math.min(_numCols - 1, node.indexX + 1);
				var startY:int = Math.max(0, node.indexZ - 1);
				var endY:int = Math.min(_numRows - 1, node.indexZ + 1);
				
				for(var i:int = startX; i <= endX; i++)
				{
					for(var j:int = startY; j <= endY; j++)
					{
						var test:IsoObject = _tiles[i][j];
						if(test == node || 
						   !test.walkable ||
						   !_tiles[node.indexX][test.indexZ].walkable || //斜角
						   !_tiles[test.indexX][node.indexZ].walkable)
						{
							continue;
						}
						
						var cost:Number = _straightCost;	//直线
						if(!((node.indexX == test.indexX) || (node.indexZ == test.indexZ))) //斜线
						{
							cost = _diagCost;
						}
						var g:Number = node.g + cost * test.costMultiplier;
						var h:Number = _heuristic(test);
						var f:Number = g + h;
						if(isOpen(test) || isClosed(test))
						{
							if(test.f > f)
							{
								test.f = f;
								test.g = g;
								test.h = h;
								test.parentObject = node;
							}
						}
						else
						{
							test.f = f;
							test.g = g;
							test.h = h;
							test.parentObject = node;
							_open.push(test);
						}
					}
				}
				
				
				for(var o:int = 0; o < _open.length; o++)
				{
				}
				
				_closed.push(node);
				
				if(_open.length == 0)
				{
					trace("no path found");
					return false;
				}
				
				_open.sortOn("f", Array.NUMERIC);
				node = _open.shift() as IsoObject;
			}
			
			buildPath();
			return true;
		}
		
		private function buildPath():void
		{
			_path = new Array();
			var node:IsoObject = _endNode;
			_path.push(node);
			while(node != _startNode)
			{
				node = node.parentObject;
				_path.unshift(node);
			}
		}
		
		public function get path() : Array
		{
			return _path;
		}
		
		private function isOpen(node : IsoObject) : Boolean
		{
			for(var i:int = 0; i < _open.length; i++)
			{
				if(_open[i] == node)
				{
					return true;
				}
			}
			return false;
		}
		
		private function isClosed(node:IsoObject):Boolean
		{
			for(var i:int = 0; i < _closed.length; i++)
			{
				if(_closed[i] == node)
				{
					return true;
				}
			}
			return false;
		}
		
		/*private function manhattan(node:IsoObject):Number
		{
			return Math.abs(node.x - _endNode.x) * _straightCost + Math.abs(node.y + _endNode.y) * _straightCost;
		}
		
		private function euclidian(node:IsoObject):Number
		{
			var dx:Number = node.x - _endNode.x;
			var dy:Number = node.y - _endNode.y;
			return Math.sqrt(dx * dx + dy * dy) * _straightCost;
		}*/
		
		private function diagonal(node:IsoObject):Number
		{
			var dx:Number = Math.abs(node.indexX - _endNode.indexX);
			var dy:Number = Math.abs(node.indexZ - _endNode.indexZ);
			var diag:Number = Math.min(dx, dy);
			var straight:Number = dx + dy;
			return _diagCost * diag + _straightCost * (straight - 2 * diag);
		}
		
		public function get visited():Array
		{
			return _closed.concat(_open);
		}
	}
}
