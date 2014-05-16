package com.aspirin.game.isometric {
	import com.aspirin.game.events.MapEvent;	

	import flash.events.Event;	

	import aspirin.net.DataLoader;	

	/**
	 * @author ashi
	 */
	public class MapLoader extends DataLoader {

		private var _map : IsoMapNormal;

		private var _tileTypes : Object = new Object();

		public function MapLoader( url : String ) : void {
			loadData(url);
		}

		protected override function onLoad(evt : Event) : void {
			var data : String = this.data;
			var lines : Array = data.split("\n");
			
			var tilesArr : Array = new Array();
			
			var numRows : int = 0;
			
			var numCols : int = 0;
			
			for (var i : int = 0;i < lines.length; i++) {
				var line : String = lines[i];
				
				// if line is a tile type definition.
				if(isDefinition(line)) {
					parseDefinition(line);
				}
				// otherwise, if line is not empty and not a comment, it's a list of tile types. add them to grid.
				else if(!lineIsEmpty(line) && !isComment(line)) {
					var tiles : Array = line.split(" ");
					numCols = Math.max(numCols, tiles.length);
					for (var j : int = 0;j < numCols; j++) {
						var symbol : String = tiles[j] ? tiles[j] : "0";
						var tile : Tile = new Tile(Map.TILE_SIZE, symbol);
						tile.x = j * Map.TILE_SIZE;
						tile.y = 0;
						tile.z = numRows * Map.TILE_SIZE;
						tile.walkable = _tileTypes[symbol].walkable == "true";
						tile.indexX = j;
						tile.indexZ = numRows;						
						
						tilesArr.push(tile);
					}
					
					numRows++;
				}
			}
			
			_map = new IsoMapNormal(numCols, numRows);
			_map.tileTypes = _tileTypes;
			
			for (var k : int = 0; k < tilesArr.length; k++) {
				tile = tilesArr[k];
				_map.setTile(tile.indexX, tile.indexZ, tile);
			}
			
			var me : MapEvent = new MapEvent(MapEvent.MAP_LOADED);
			me.map = _map;
			dispatchEvent(me);
		}
		
		private function parseDefinition(line : String) : void {
			// break apart the line into tokens
			var tokens : Array = line.split(" ");	
			
			// get rid of #
			tokens.shift(); 
			
			// first tokelayn is the symbol
			var symbol : String = tokens.shift() as String;
			
			// loop through the rest of the tokens, which are key/value pairs separated by :
			var definition : Object = new Object();
			for(var i : int = 0;i < tokens.length; i++) {
				var key : String = tokens[i].split(":")[0];
				var val : String = tokens[i].split(":")[1];
				definition[key] = val;
			}
			
			// register the type and definition
			setTileType(symbol, definition);
		}

		/**
		 * Links a symbol with a definition object.
		 * @param symbol The character to use for the definition.
		 * @param definition A generic object with definition properties
		 */
		public function setTileType(symbol : String, definition : Object) : void {
			_tileTypes[symbol] = definition;
		}

		private function lineIsEmpty(line : String) : Boolean {
			for(var i : int = 0;i < line.length; i++) {
				if(line.charAt(i) != " ") return false;
			}
			return true;
		}

		/**
		 * Returns true if line is a comment (starts with //).
		 * @param line The string to test.
		 */
		private function isComment(line : String) : Boolean {
			return line.indexOf("//") == 0;
		}

		/**
		 * Returns true if line is a definition (starts with #).
		 * @param line The string to test.
		 */
		private function isDefinition(line : String) : Boolean {
			return line.indexOf("#") == 0;
		}
	}
}
