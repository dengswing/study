package com.normsoule.pixelblitz.layers
{
	import com.normsoule.pixelblitz.core.Renderer2D;
	
	/**
	 * The IRenderLayer interface is implemented by objects that could be added to the Renderer2D and rendered.
	 */
	public interface IRenderLayer
	{	
		/**
		 * The renderer that will render this layer.
		 */
		function set renderer( value:Renderer2D ):void
		/**
		 * @private
		 */
		function get renderer():Renderer2D
		
		/**
		 * Sets the width, height, and rect of the layer.
		 * 
		 * @param width The width to set this layer to.
		 * @param height The height to set this layer to.
		 */
		function setSize( width:int, height:int ):void
		
		/**
		 * Renders all of the visible items in the layer.
		 * Items that are outside of the visible area will not be rendered.
		 * Calculates and applies parallax scrolling if useParallax is set to true.
		 */
		function render():void
	}
}