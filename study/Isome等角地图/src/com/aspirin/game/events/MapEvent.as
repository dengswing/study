package com.aspirin.game.events {
	import com.aspirin.game.isometric.IsoMapScroll;
	import com.aspirin.game.isometric.Map;
	
	import flash.events.Event;	

	/**
	 * @author ashi
	 */
	public class MapEvent extends Event{
		public static const MAP_LOADED : String = "map_loaded";
		public static const MAP_ERROR : String = "map_error";
		
		private var _map : Map;
		
		public function MapEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false, map : IsoMapScroll = null) {
			super(type, bubbles, cancelable);
			if(map) this.map = map;
		}
		
		public function get map() : Map {
			return _map;
		}
		
		public function set map(map : Map) : void {
			_map = map;
		}
	}
}
