/**
 * VERSION: 1.01
 * DATE: 5/2/2009
 * ACTIONSCRIPT VERSION: 3.0 
 * UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
 **/
package gs.plugins {
	import flash.display.*;
	import gs.*;
/**
 * Tweens a MovieClip to a particular frame number. <br /><br />
 * 
 * <b>USAGE:</b><br /><br />
 * <code>
 * 		import gs.TweenLite; <br />
 * 		import gs.plugins.FramePlugin; <br />
 * 		TweenPlugin.activate([FramePlugin]); //activation is permanent in the SWF, so this line only needs to be run once.<br /><br />
 * 
 * 		TweenLite.to(mc, 1, {frame:125}); <br /><br />
 * </code>
 *
 * Bytes added to SWF: 339 (not including dependencies)<br /><br />
 * 
 * <b>Copyright 2009, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
	public class FramePlugin extends TweenPlugin {
		/** @private **/
		public static const VERSION:Number = 1.01;
		/** @private **/
		public static const API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		/** @private **/
		public var frame:int;
		/** @private **/
		protected var _target:MovieClip;
		
		/** @private **/
		public function FramePlugin() {
			super();
			this.propName = "frame";
			this.overwriteProps = ["frame","frameLabel"];
			this.round = true;
		}
		
		/** @private **/
		override public function onInitTween($target:Object, $value:*, $tween:TweenLite):Boolean {
			if (!($target is MovieClip) || isNaN($value)) {
				return false;
			}
			_target = $target as MovieClip;
			this.frame = _target.currentFrame;
			addTween(this, "frame", this.frame, $value, "frame");
			return true;
		}
		
		/** @private **/
		override public function set changeFactor($n:Number):void {
			updateTweens($n);
			_target.gotoAndStop(this.frame);
		}

	}
}