package {
	import com.aspirin.game.events.MapEvent;
	import com.aspirin.game.isometric.Map;
	import com.aspirin.game.isometric.MapLoader;
	
	import flash.display.Sprite;		

	/**
	 * @author ashi
	 */
	public class Main extends Sprite {
		
		[Embed(source="../libs/artworks/artworks.swf", symbol="BlueCube_1")]
		public var BlueCube_1 : Class;
		
		[Embed(source="../libs/artworks/artworks.swf", symbol="BlueCube_2")]
		public var BlueCube_2 : Class;
		
		[Embed(source="../libs/artworks/artworks.swf", symbol="BlueCube_3")]
		public var BlueCube_3 : Class;
		
		[Embed(source="../libs/artworks/artworks.swf", symbol="Flower_1")]
		public var Flower_1 : Class;
		
		[Embed(source="../libs/artworks/artworks.swf", symbol="Flower_2")]
		public var Flower_2 : Class;
		
		private var loader : MapLoader;
		
		private var map : Map;

		private var container : Sprite;
		
		public function Main() {
			loader = new MapLoader("map.txt");
			loader.addEventListener(MapEvent.MAP_LOADED, onLoad);
		}
		
		private function onLoad(evt : MapEvent) : void {
			
			container = new Sprite();
			addChild(container);
			
			map = evt.map;
			map.renderMap(container);
			
			container.x = (this.stage.stageWidth)/2;
			container.y = (this.stage.stageHeight)/2 - 190;
		}
	}
}
