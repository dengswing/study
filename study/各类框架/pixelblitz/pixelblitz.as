package {

	import com.normsoule.pixelblitz.effects.FogEffect;
	import com.normsoule.pixelblitz.effects.GlowEffect;
	import com.normsoule.pixelblitz.effects.GridEffect;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import com.normsoule.pixelblitz.core.Renderer2D;
	import com.normsoule.pixelblitz.effects.TrailsEffect;
	import com.normsoule.pixelblitz.elements.PixelSprite;
	import com.normsoule.pixelblitz.layers.RenderLayer;

	/**
	 * This example bounces 20 PixelSprites around the stage. Click on a PixelSprite and it will be removed.
	 *
	 * This demonstrates several of the basic ingredients in using the PixelBlitz engine: 
	 *
	 *create the main renderer, 
	 *create a renderLayer and add it to the renderer,
	 *create some PixelSprites and add them to the renderLayer,
	 *create and apply an effect to a layer,
	 *check mouse interaction using the getCollisionPoint method
	 *properly remove PixelSprites and make them available for garbage collection
	 * and lastly call the renderer.render() method to render the PixelClips to the screen
	 */ 
	 
	public class pixelblitz extends Sprite {
		private const stageWidth:int = stage.stageWidth;
		private const stageHeight:int = stage.stageHeight;
		// main renderer
		private var renderer:Renderer2D=new Renderer2D(stageWidth,stageHeight);
		// renderLayer to hold the PixelClips
		private var layer:RenderLayer = new RenderLayer();
		// array to hold a reference to all of the PixelClips
		private var holder:Array = [];
		public function pixelblitz() {
			for (var i:int = 0; i < 20; i++) {
				// create 20 pixelClips
				spawn();
			}
			// add the layer to the renderer
			renderer.addLayer( layer );
			layer.effect = new TrailsEffect();
			stage.addEventListener( Event.ENTER_FRAME, update );
			stage.addEventListener( MouseEvent.MOUSE_DOWN, mouseHandler );
			addChild( renderer );
		}
		private function spawn():void {
			// create a new PixelSprite with the library linked symbol BoxHead
			var ps:PixelSprite = new PixelSprite( new BoxHead() );
			// center on the x axis
			ps.x=stageWidth/2;
			// center on the y axis
			ps.y=stageHeight/2;
			// assign a random x velocity
			ps.vx=Math.random()*12-6;
			// assign a random y velocity
			ps.vy=Math.random()*12-6;
			// add the PixelSprite to the layer
			layer.addItem( ps );
			// store a reference to the PixelSprite in the holder array
			holder.push( ps );
		}
		private function mouseHandler( event:MouseEvent ):void {
			// loop backwards through the holder array to check the top-most clips first
			for (var i:int = holder.length - 1; i > -1; i--) {
				// reference to each PixelSprite
				var ps:PixelSprite=holder[i];
				// check if the current mouse position is within a PixelSprite
				if (ps.getCollisionPoint(new Point(stage.mouseX,stage.mouseY))) {
					// remove the pixelSprite and clear internal data
					ps.dispose();
					// destroy the reference to the PixelSprite to make it available for garbage collection
					holder.splice( i, 1 );
					// break out of the loop to avoid removing more than one per click
					break;
				}
			}
		}
		private function update( event:Event ):void {
			for (var i:int = 0; i < holder.length; i++) {
				// grab a reference to each PixelSprite
				var ps:PixelSprite=holder[i];
				// bounce off of the walls
				if (ps.x+ps.width>stageWidth) {
					ps.x=stageWidth-ps.width;
					ps.vx=- ps.vx;
				} else if ( ps.x < 0 ) {
					ps.x=0;
					ps.vx=- ps.vx;
				}
				if (ps.y+ps.height>stageHeight) {
					ps.y=stageHeight-ps.height;
					ps.vy=- ps.vy;
				} else if ( ps.y < 0 ) {
					ps.y=0;
					ps.vy=- ps.vy;
				}
				// move on the x axis
				ps.x+=ps.vx;
				// move on the y axis
				ps.y+=ps.vy;
			}
			// render everything
			renderer.render();
		}
	}
}