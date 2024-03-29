﻿/**
 * VERSION: 2.0
 * DATE: 5/2/2009
 * ACTIONSCRIPT VERSION: 3.0 
 * UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
 **/
package gs.plugins {
	import flash.display.*;
	import gs.*;
/**
 * Slightly faster way to change a DisplayObject's x, y, scaleX, and scaleY value(s). You'd likely
 * only see a difference if/when tweening very large quantities of objects, but this just demonstrates
 * how you can use a TweenPlugin to optimize a particular kind of tween. The trade offs of using this 
 * plugin are: 
 * <ul>
 * 		<li>It affects x, y, scaleX, and scaleY (all of them)
 * 		<li>It doesn't accommodate overwriting individual properties. But again, this is an example
 * 	   of using a plugin for a particular scenario where you know ahead of time what requirements
 * 	   you're working with. 
 * </ul><br />
 * 
 * <b>USAGE:</b><br /><br />
 * <code>
 * 		import gs.TweenLite; <br />
 * 		import gs.plugins.FastTransformPlugin; <br />
 * 		TweenPlugin.activate([FastTransformPlugin]); //activation is permanent in the SWF, so this line only needs to be run once.<br /><br />
 * 
 * 		TweenLite.to(mc, 1, {fastTransform:{x:50, y:300, scaleX:2, scaleY:2}}); <br /><br />
 * </code>
 * 
 * <b>Copyright 2009, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
	public class FastTransformPlugin extends TweenPlugin {
		/** @private **/
		public static const VERSION:Number = 2.0;
		/** @private **/
		public static const API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		/** @private **/
		protected var _target:DisplayObject;
		/** @private **/
		protected var xStart:Number;
		/** @private **/
		protected var xChange:Number = 0;
		/** @private **/
		protected var yStart:Number;
		/** @private **/
		protected var yChange:Number = 0;
		/** @private **/
		protected var scaleStart:Number;
		/** @private **/
		protected var scaleChange:Number = 0;
		
		/** @private **/
		public function FastTransformPlugin() {
			super();
			this.propName = "fastTransform";
			this.overwriteProps = ["x", "y", "scaleX", "scaleY"];
		}
		
		/** @private **/
		override public function onInitTween($target:Object, $value:*, $tween:TweenLite):Boolean {
			_target = $target as DisplayObject;
			xStart = _target.x;
			xChange = $value.x - _target.x;
			yStart = _target.y;
			yChange = $value.y - _target.y;
			scaleStart = _target.scaleX;
			scaleChange = $value.scaleX - _target.scaleX;
			return true;
		}
		
		/** @private **/
		override public function set changeFactor($n:Number):void {
			_target.x = xStart + ($n * xChange);
			_target.y = yStart + ($n * yChange);
			_target.scaleX = _target.scaleY = scaleStart + ($n * scaleChange);
		}

	}
}