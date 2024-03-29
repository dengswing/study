/**
 * VERSION: 1.53
 * DATE: 5/5/2009
 * ACTIONSCRIPT VERSION: 3.0 
 * UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
 **/
package gs.plugins {
	import flash.display.*;
	import gs.*;
/**
 * Toggles the visibility at the end of a tween. For example, if you want to set <code>visible</code> to false
 * at the end of the tween, do:<br /><br /><code>
 * 
 * TweenLite.to(mc, 1, {x:100, visible:false});<br /><br /></code>
 * 
 * The <code>visible</code> property is forced to true during the course of the tween. <br /><br />
 * 
 * <b>USAGE:</b><br /><br />
 * <code>
 * 		import gs.TweenLite; <br />
 * 		import gs.plugins.VisiblePlugin; <br />
 * 		TweenPlugin.activate([VisiblePlugin]); //activation is permanent in the SWF, so this line only needs to be run once.<br /><br />
 * 
 * 		TweenLite.to(mc, 1, {x:100, visible:false}); <br /><br />
 * </code>
 *
 * Bytes added to SWF: 244 (not including dependencies)<br /><br />
 * 
 * <b>Copyright 2009, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
	public class VisiblePlugin extends TweenPlugin {
		/** @private **/
		public static const VERSION:Number = 1.53;
		/** @private **/
		public static const API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		/** @private **/
		protected var _target:Object;
		/** @private **/
		protected var _tween:TweenLite;
		/** @private **/
		protected var _visible:Boolean;
		/** @private **/
		protected var _hideAtStart:Boolean;
		
		/** @private **/
		public function VisiblePlugin() {
			super();
			this.propName = "visible";
			this.overwriteProps = ["visible"];
			this.onComplete = onCompleteTween;
		}
		
		/** @private **/
		override public function onInitTween($target:Object, $value:*, $tween:TweenLite):Boolean {
			init($target, Boolean($value), $tween);
			return true;
		}
		
		/** @private **/
		protected function init($target:Object, $visible:Boolean, $tween:TweenLite):void {
			_target = $target;
			_tween = $tween;
			_visible = $visible;
			if (_tween.vars.runBackwards == true && _tween.vars.immediateRender == true && $visible == false) {
				_hideAtStart = true;
			}
		}
		
		/** @private **/
		public function onCompleteTween():void {
			if (!_hideAtStart && (_tween.cachedTime != 0 || _tween.duration == 0)) { 
				_target.visible = _visible;
			}
		}
		
		/** @private **/
		override public function set changeFactor($n:Number):void {
			if (_hideAtStart && _tween.cachedTotalTime == 0) {
				_target.visible = false;
			} else if (_target.visible != true) {
				_target.visible = true;
			}
		}

	}
}