﻿package{
	import flash.display.DisplayObject;
	import flash.display.Graphics;	
	import flash.events.EventDispatcher;
	
	public class CollisionGrid extends EventDispatcher
	{
		private var _checks:Vector.<DisplayObject>;
		private var _grid:Vector.<Vector.<DisplayObject>>;
		private var _gridSize:Number;
		private var _height:Number;
		private var _numCells:int;
		private var _numCols:int;
		private var _numRows:int;
		private var _width:Number;
		
		public function CollisionGrid(width:Number, height:Number, gridSize:Number)
		{
			_width = width;
			_height = height;
			_gridSize = gridSize;
			_numCols = Math.ceil(_width / _gridSize);
			_numRows = Math.ceil(_height / _gridSize);
			_numCells = _numCols * _numRows;
		}
		
		public function drawGrid(graphics:Graphics):void
		{
			graphics.lineStyle(0, .5);
			for(var i:int = 0; i <= _width; i += _gridSize)
			{
				graphics.moveTo(i, 0);
				graphics.lineTo(i, _height);
			}
			for(i = 0; i <= _height; i += _gridSize)	
			{
				graphics.moveTo(0, i);
				graphics.lineTo(_width, i);
			}
		}
		
		public function check(objects:Vector.<DisplayObject>):void
		{
			var numObjects:int = objects.length;
			_grid = new Vector.<Vector.<DisplayObject>>(_numCells);
			_checks = new Vector.<DisplayObject>();
			for(var i:int = 0; i < numObjects; i++)
			{
				var obj:DisplayObject = objects[i];
				var index:int=Math.floor(obj.y / _gridSize)*_numCols+Math.floor(obj.x /_gridSize);
				if(_grid[index] == null) _grid[index] = new Vector.<DisplayObject>;
				_grid[index].push(obj);
			}
			
			checkGrid();
		}
			
		private function checkGrid():void
		{
			for(var i:int = 0; i < _numCols; i++)
			{
				for(var j:int = 0; j < _numRows; j++)
				{
					checkOneCell(i, j);
					checkTwoCells(i, j, i + 1, j);
					checkTwoCells(i, j, i - 1, j + 1);
					checkTwoCells(i, j, i, j + 1);
					checkTwoCells(i, j, i + 1, j + 1);
				
				}
			}
		}
		
		private function checkOneCell(x:int, y:int):void
		{
			var cell:Vector.<DisplayObject> = _grid[y * _numCols + x];
			if(cell == null) return;
			var cellLength:int = cell.length;
			for(var i:int = 0; i < cellLength - 1; i++)
			{
				var objA:DisplayObject = cell[i];
				for(var j:int = i + 1; j < cellLength; j++)
				{
					var objB:DisplayObject = cell[j];
					_checks.push(objA, objB);
				}
			}
		}
		
		private function checkTwoCells(x1:int, y1:int, x2:int, y2:int):void
		{
			if(x2 >= _numCols || x2 < 0 || y2 >= _numRows) return;
			var cellA:Vector.<DisplayObject> = _grid[y1 * _numCols + x1];
			var cellB:Vector.<DisplayObject> = _grid[y2 * _numCols + x2];
			if(cellA == null || cellB == null) return;
			var cellALength:int = cellA.length;
			var cellBLength:int = cellB.length;
			
			for(var i:int = 0; i < cellALength; i++)
			{
				
				var objA:DisplayObject = cellA[i];
				for(var j:int = 0; j < cellBLength; j++)
				{
					var objB:DisplayObject = cellB[j];
					_checks.push(objA, objB);
				}
			}
		}
		
		public function get checks():Vector.<DisplayObject>
		{
			return _checks;
		}
	}
}