/**
 * VERSION: 1.0
 * DATE: 5/2/2009
 * ACTIONSCRIPT VERSION: 3.0 
 * UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
 **/
package gs.plugins {
	import flash.display.*;
	import gs.*;
/**
 * If you'd like the inbetween values in a tween to always get rounded to the nearest integer, use the roundProps
 * special property. Just pass in an Array containing the property names that you'd like rounded. For example,
 * if you're tweening the x, y, and alpha properties of mc and you want to round the x and y values (not alpha)
 * every time the tween is rendered, you'd do: <br /><br /><code>
 * 	
 * 	TweenMax.to(mc, 2, {x:300, y:200, alpha:0.5, roundProps:["x","y"]});<br /><br /></code>
 * 
 * <b>IMPORTANT:</b> roundProps requires TweenMax! TweenLite tweens will not round properties. <br /><br />
 * 
 * <b>USAGE:</b><br /><br />
 * <code>
 * 		import gs.TweenMax; <br /><br />
 * 
 * 		TweenMax.to(mc, 2, {x:300, y:200, alpha:0.5, roundProps:["x","y"]}); <br /><br />
 * </code>
 *
 * Bytes added to SWF: 158 (not including dependencies)<br /><br />
 * 
 * <b>Copyright 2009, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
	public class RoundPropsPlugin extends TweenPlugin {
		/** @private **/
		public static const VERSION:Number = 1.0;
		/** @private **/
		public static const API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		/** @private **/
		public function RoundPropsPlugin() {
			super();
			this.propName = "roundProps";
			this.overwriteProps = [];
			this.round = true;
		}
		
		/** @private **/
		public function add($object:Object, $propName:String, $start:Number, $change:Number):void {
			addTween($object, $propName, $start, $start + $change, $propName);
			this.overwriteProps[this.overwriteProps.length] = $propName;
		}

	}
}