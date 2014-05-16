package com.aspirin.game.isometric.items {
	import com.aspirin.game.isometric.IsoObject;
	import com.aspirin.game.isometric.Map;
	
	import flash.geom.Rectangle;	

	/**
	 * @author ashi
	 */
	public class Item extends IsoObject {
		private var _col : int;	//行
		private var _row : int;	//列

		private var _cols : int;	//宽
		private var _rows : int;	//高

		private var _type : int;

		/**
		 * 物品
		 * @param	symbol	物品类型
		 * @param	cols	物品大小宽
		 * @param	rows	物品大小高
		 */
		public function Item(symbol : String,cols : int, rows : int) {
			_cols = cols;
			_rows = rows;
			super(_cols * _rows * Map.TILE_SIZE, symbol);
		}

		public function get col() : int {
			return _col;
		}

		public function set col(col : int) : void {
			_col = col;
		}

		public function get row() : int {
			return _row;
		}

		public function set row(row : int) : void {
			_row = row;
		}

		public function get cols() : int {
			return _cols;
		}

		public function set cols(cols : int) : void {
			_cols = cols;
		}

		public function get rows() : int {
			return _rows;
		}

		public function set rows(rows : int) : void {
			_rows = rows;
		}

		public function get type() : int {
			return _type;
		}

		public function set type(type : int) : void {
			_type = type;
		}
		
		public function get bound() : Rectangle
		{
			var rect : Rectangle = new Rectangle(col, row, cols - 1, rows - 1);
			return rect;
		}
		
		public function getRelation(target : Item) : int
		{
		    var targetBox : Rectangle = target.bound;
		    var sourceBox : Rectangle = this.bound;
		    var relation : int = -1;
		    if(targetBox.top > sourceBox.bottom)
		    {
		    	relation = 5;
		    	if( targetBox.left > sourceBox.right)
		    	{
					relation = 2;
				}else if( targetBox.right < sourceBox.left )
				{
				    relation = 8;
				}
		    }else if( targetBox.bottom < sourceBox.top)
		    {
		    	relation = 3;
		    	if( targetBox.left > sourceBox.right)
		    	{
					relation = 0;
				}else if( targetBox.right < sourceBox.left )
				{
				    relation = 6;	
				}
				
		    }else if(targetBox.left > sourceBox.right)
		    {
		    	relation = 1;
		    }else if(targetBox.right < sourceBox.left)
		    {
		    	relation = 7;
		    }
		  
			return relation;
		}
	}
}
