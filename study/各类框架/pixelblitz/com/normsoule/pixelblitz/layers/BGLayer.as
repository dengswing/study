package com.normsoule.pixelblitz.layers
{	
	import com.normsoule.pixelblitz.core.Renderer2D;
	import com.normsoule.pixelblitz.effects.IEffect;
	import com.normsoule.pixelblitz.elements.PixelSprite;
	
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	/**
	 * The BGLayer class is a simple render layer with a background gradient.
	 * <p>
	 * Renderable objects cannot be added to this layer. 
	 * The only purpose of this class is to create a fast and effecient way of creating background gradients.
	 * In order to get type checking use the constants defined in the BgGradient class.
	 * </p>
	 * @see BgGradient
	 */
	public class BGLayer extends RenderLayer
	{
		private var bg:Shape = new Shape();
		private var matrix:Matrix = new Matrix();
		private var bgColors:Array = [];
		private var bgGradientType:int;
		private var _renderer:Renderer2D;
		
		/**
		 * Creates a BGLayer.
		 * @param bgColor1 The left or top color depending on the bg gradient type.
		 * @param bgColor2 The right or bottom color depending on the bg gradient type.
		 * @param bgGradientType An integer value to represent the type of gradient to use, vertical or horizontal. 
		 * In order to get type checking use the constants defined in the BgGradient class.
		 * @see BgGradient
		 */
		public function BGLayer( bgColor1:uint = 0xFFFFFF, bgColor2:uint = 0x000000, bgGradientType:int = 2 )
		{
			super( false );
			
			bgColors[0] = bgColor1;
			bgColors[1] = bgColor2;
			this.bgGradientType = bgGradientType;
		}
		
		/**
		 * Sets the width, height, and rect of the layer.
		 * 
		 * @param width The width to set this layer to.
		 * @param height The height to set this layer to.
		 */
		public override function setSize( width:int, height:int ):void
		{
			bitmapData = new BitmapData( width, height );
			rect = bitmapData.rect;
				
			matrix.createGradientBox( width, height, Math.PI / bgGradientType );
			bg.graphics.beginGradientFill( GradientType.LINEAR, [ bgColors[0], bgColors[1] ], [ 1, 1 ], [ 0x00, 0xFF ], matrix );
			bg.graphics.drawRect( 0, 0, bitmapData.width, bitmapData.height );
			bg.graphics.endFill();
			bitmapData.draw( bg );
			
			_renderer.hasBG = true;
		}
		
		/**
		 * Subscribes the Renderer2D instance to this layer.
		 */
		public override function set renderer( value:Renderer2D ):void
		{
			_renderer = value;
			_renderer.hasBG = true;
		}
		
		/**
		 * @private
		 */
		public override function get effect():IEffect { return null; }
		/**
		 * @private
		 */
		public override function set effect( value:IEffect ):void {}
		/**
		 * @private
		 */
		public override function addItem ( item:PixelSprite ):void {}
		/**
		 * @private
		 */
		public override function render():void {}
	}
}