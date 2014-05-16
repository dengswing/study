package com.normsoule.pixelblitz.core
{	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * The Camera2D class creates a virtual camera object.
	 * <p>
	 * The virtual camera calculates horizontal and vertical scrolling based on the camera target and the boundry.
	 * This class is the foundation for parallax scrolling, 
	 * the illusion that objects move slower the further away from the camera they are.
	 * </p>
	 */
	public class Camera2D
	{
		private static var instance:Camera2D;
		private static var allowInstance:Boolean;

		private var distX:int;
		private var distY:int;
		
		/**
		 * @private
		 * The amount of 'lag' that the camera uses.
		 * <p>
		 * Ideal values are between 0 and 1. A value greater than 1 will produce 
		 * the opposite effect and cause the camera to advance past the target point, which will result in abnormal scrolling.
		 * </p>
		 * @default .1
		 */
		public var ease:Number = .1;
		
		/**
		 * @private
		 * The camera target.
		 * <p>
		 * The target is the focal point that the camera follows to calculate scrolling.
		 *  This point could be mapped to the Mouse coordinates, or to a renderable object's <code>x, y</code> coordinates, or simply a Point object
		 * being manipulated in any number of ways.
		 * </p>
		 * <p>
		 * <b>Note:</b> if no target is specified scrolling will not occur.
		 * </p>
		 */
		public var target:Point;
		
		/**
		 * The resultant point of the scrolling calculation.
		 * <p>
		 * This is the global point that all renderable objects will be offset from. 
		 * The renderable object <code>x, y</code> values are not modified.
		 * </p>
		 */
		public var basePoint:Point = new Point();
		
		/**
		 * @private
		 * Defines the boundry limits for the camera.
		 * <p>
		 * The camera will not move outside of the boundry Rectangle.
		 * </p>
		 * @default a new Rectangle of the default size
		 */
		public var boundry:Rectangle = new Rectangle();
		
		/**
		 * @private
		 */
		public function Camera2D()
		{
			// singleton
			if ( !allowInstance )
			{
				throw new Error( "Camera2D is instantiated internally" );
			}
		}
		
		/**
		 * Creates the singleton Camera2D instance.
		 * 
		 * @return The singleton instance of Camera2D. 
		 */
		public static function getInstance():Camera2D
		{
			if ( !instance )
			{
				allowInstance = true;
				instance = new Camera2D();
				allowInstance = false;
			}
			return instance;
		}
		
		/**
		 * Scrolls the virtual camera based on the <code>target</code> point.
		 * <p>
		 * <b>Note:</b> if the <code>target</code> is <code>null</code> then no scrolling will occur.
		 * </p>
		 */
		public function scroll():void
		{
			if ( target )
			{
				scrollTarget();
			}
		}
		
		private function scrollTarget():void
		{	
			// horizontal
			if ( target.x < boundry.right && target.x > boundry.left )
			{
				distX = boundry.left - target.x - basePoint.x;
				basePoint.x += distX * ease;
			}
			else
			{
				if ( target.x > boundry.right )
				{
					distX = boundry.left - ( boundry.right + basePoint.x ); 
					basePoint.x += distX * ease;
				}
				 if ( target.x < boundry.left )
				{
					distX = boundry.left - ( boundry.left + basePoint.x ); 
					basePoint.x += distX * ease;
				}
			}
			// vertical
			if ( target.y < boundry.bottom && target.y > boundry.top )
			{
				distY = boundry.top - target.y - basePoint.y;
				basePoint.y += distY * ease;
			}
			else
			{
				if ( target.y > boundry.bottom )
				{
					distY = boundry.top - ( boundry.bottom + basePoint.y ); 
					basePoint.y += distY * ease;
				}
				if ( target.y < boundry.top )
				{
					distY = boundry.top - ( boundry.top + basePoint.y ); 
					basePoint.y += distY * ease;
				}
			}
		}
	}
}