package com.aspirin.game.isometric {
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.geom.Matrix;		

	/**
	 * @author ashi
	 */
	public class IsoCanvas extends Sprite{
		private var bd : BitmapData;
		private var w : int;
		private var h : int;

		public function IsoCanvas(w : int, h : int) {
			this.w = w;
			this.h = h;
			
			bd = new BitmapData(w, h);
		}
		
		public function draw(tile : IsoObject) : void {
			var matrix : Matrix= new Matrix();
			matrix.tx = tile.screenX + w/2;
			matrix.ty = tile.screenY + h/2;
			bd.draw(tile, matrix, null, BlendMode.LAYER);
			//var bm : Bitmap = new Bitmap(bd);
			//bm.x = tile.screenX - tile.screenWidth/2;
			//bm.y = tile.screenY -tile.screenHeight/2;
			this.graphics.beginBitmapFill(bd, null, true);
			this.graphics.drawRect(0, 0, w, h);
			this.graphics.endFill();
			//addChild(bm);
		}
		
		public function clear() : void
		{
			//bd.dispose();
			//bd = new BitmapData(w, h);
			this.graphics.clear();
		}
		
		public override function set x( n : Number ) : void
		{
			
		}
		
		public override function set y( n : Number ) : void
		{
			
		}
	}
}
