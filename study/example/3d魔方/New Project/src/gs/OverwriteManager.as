﻿/**
 * VERSION: 5.02
 * DATE: 5/5/2009
 * AS3 (AS2 is also available)
 * UPDATES & DOCUMENTATION AT: http://www.TweenLite.com
 **/

package gs {
	import flash.errors.*;
	import flash.utils.*;
	import gs.core.tween.*;
/**
 *  When multiple tweens with the same target exist, there is a potential for conflicts (if, for example, they are both running
 *  concurrently and trying to control the same property), and OverwriteManager allows you to control how (and if) overwriting
 *  occurs. In TweenMax, the default mode is "AUTO" and in TweenLite, the default mode is "ALL" which means 
 *  that as soon as a tween is created, TweenLite finds any existing tweens of the same target, and kills them immediately. 
 *  For example: <br /><br /><code>
 * 		
 * 		TweenLite.to(mc, 1, {x:100, y:200}); <br />
 * 		TweenLite.to(mc, 1, {alpha:0.5, delay:2}); //Without OverwriteManager, this tween immediately overwrites the previous one<br /><br /></code>
 *  		
 * 	Even though there are no overlapping properties in the previous example, the 2nd tween would overwrite the first. 
 * 	The primary reason for this has to do with speed and file size. You could always override this behavior by using the 
 *  "overwrite" special property and setting it to 0 or false, like: <br /><br /><code>
 * 		
 * 		TweenLite.to(mc, 1, {alpha:0, delay:2, overwrite:0}); //skips overwriting and ignores existing tweens of the same target<br /><br /></code>
 *  
 *  TweenMax, however, inits OverwriteManager internally and sets the default mode to "AUTO", so it will wait until each 
 *  tween begins the first time and then selectively kill only the individual properties in each tween that is running 
 *  at that time. Obviously this is slightly more processor-intensive, but it is unlikely that you'd notice any speed 
 *  difference whatsoever unless hundreds of tweens with the same target are beginning at the same time.<br /><br />
 * 
 * 	There are actually 4 modes to choose from (see below) which give you fine-grained control. You can set a default
 *  mode which affects all TweenLite and TweenMax tweens globally and you can use the "overwrite" special property
 *  in TweenLite/Max to override the default behavior for individual tweens. 
 * 		
 * 	OverwriteManager is a separate, optional class primarily because of file size concerns. You may be wondering 
 * 	"what the heck? It's about 1Kb! What's the big deal?". Well, there are thousands of developers using TweenLite 
 *  because of its extremely small footprint and blistering speed. Even 1Kb would represent a significant increase 
 *  in file size proportionally speaking, and some developers have no use for the capabilities of this class. <br /><br />
 * 	
 * 	So OverwriteManager is an optional enhancement to TweenLite, but it is automatically included with TweenMax
 * 	without any additional steps required on your part. That also means that if you use TweenMax anywhere in your project, 
 * 	OverwriteManager will automatically get initted and will therefore affect TweenLite, making its
 * 	default mode "AUTO" instead of "ALL". <br /><br />
 * 	
 * 
 * <b>USAGE:</b><br /><br />
 * 
 * 	OverwriteManager has four modes: NONE, ALL, AUTO, and CONCURRENT. By default, it uses AUTO. Here's what they do:
 * 	<ul>
 * 		<li><b> NONE (0) </b>: No tweens are overwritten. This is the fastest mode, but you need to be careful not to create any tweens with
 * 					overlapping properties, otherwise they'll conflict with each other.<br /><br />
 * 						
 * 		<li><b> ALL (1) </b>: Similar to the default behavior of TweenLite/TweenMax where all tweens of the same object are completely
 * 				   overwritten immediately when the tween is created. <br /><br /><code>
 * 						
 * 						TweenLite.to(mc, 1, {x:100, y:200});<br />
 * 						TweenLite.to(mc, 1, {x:300, delay:2}); //immediately overwrites the previous tween<br /><br /></code>
 * 							
 * 		<li><b> AUTO (2) </b>: Searches for and overwrites only individual overlapping properties in tweens that are running at the time the tween begins. <br /><br /><code>
 *  						
 * 						TweenLite.to(mc, 1, {x:100, y:200});<br />
 * 						TweenLite.to(mc, 1, {x:300}); //only overwrites the "x" property in the previous tween<br /><br /></code>
 * 							
 * 		<li><b> CONCURRENT (3) </b>: Overwrites all tweens of the same object that are active at the time the tween begins.<br /><br /><code>
 * 						
 * 						TweenLite.to(mc, 1, {x:100, y:200});<br />
 * 						TweenLite.to(mc, 1, {x:300, delay:2}); //does NOT overwrite the previous tween because the first tween will have finished by the time this one begins.<br /><br /></code>
 * 	</ul>
 * 		
 * 	To add OverwriteManager's capabilities to TweenLite, you must init() the class once (typically on the first frame of your file) like so:<br /><br /><code>
 * 			
 * 		OverwriteManager.init();<br /><br /></code>
 * 		
 * 	You do NOT need to add this line if you're using TweenMax because it automatically does it internally.<br /><br />
 * 	
 * 
 * <b>EXAMPLES:</b><br /><br /> 
 * 
 * 	To start OverwriteManager in AUTO mode (the default) and then do a simple TweenLite tween, simply do:<br /><br /><code>
 * 		
 * 		import gs.OverwriteManager;<br />
 * 		import gs.TweenLite;<br /><br />
 * 		
 * 		OverwriteManager.init();<br />
 * 		TweenLite.to(mc, 2, {x:"300"});<br /><br /></code>
 * 		
 * 	You can also define overwrite behavior in individual tweens, like so:<br /><br /><code>
 * 	
 * 		import gs.OverwriteManager;<br />
 * 		import gs.TweenLite;<br /><br />
 * 		
 * 		OverwriteManager.init();<br />
 * 		TweenLite.to(mc, 2, {x:"300", y:"100"});<br />
 * 		TweenLite.to(mc, 1, {alpha:0.5, overwrite:1}); //or simply the constant OverwriteManager.ALL<br />
 * 		TweenLite.to(mc, 3, {x:200, rotation:30, overwrite:2}); //or simply the constant OverwriteManager.AUTO<br /><br /></code>
 * 		
 * 	But normally, you'll just control the overwriting directly through the OverwriteManager with its mode property, like this:<br /><br /><code>
 * 		
 * 		import gs.OverwriteManager;<br /><br />
 * 		
 * 		OverwriteManager.init(OverwriteManager.ALL);<br /><br />
 * 		
 * 		//-OR-//<br /><br />
 * 		
 * 		OverwriteManager.init();<br />
 * 		OverwriteManager.mode = OverwriteManager.ALL;<br /><br /></code>
 * 		
 * 	The mode can be changed anytime.<br /><br />
 * 
 * <b>Copyright 2009, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */	 
	public class OverwriteManager {
		/** @private **/
		public static const version:Number = 5.02;
		public static const NONE:int = 0;
		public static const ALL:int = 1;
		public static const AUTO:int = 2;
		public static const CONCURRENT:int = 3;
		/** @private **/
		public static var mode:int;
		/** @private **/
		public static var enabled:Boolean;
		
		/** 
		 * Initializes OverwriteManager and enables management in one of four modes: 
		 * <ul>
		 * <li><b> NONE (0):</b> No tweens are overwritten. This is the fastest mode, but you need to be careful not to create any tweens with
		 * 			overlapping properties, otherwise they'll conflict with each other.
		 * 				
		 * <li><b> ALL (1):</b> Similar to the default behavior of TweenLite/TweenMax where all tweens of the same object are completely
		 * 		   overwritten immediately when the tween is created. <br /><br /><code>
		 * 				
		 * 				TweenLite.to(mc, 1, {x:100, y:200});<br />
		 * 				TweenLite.to(mc, 1, {x:300, delay:2}); //immediately overwrites the previous tween<br /><br /></code>
		 * 					
		 * <li><b> AUTO (2):</b> Searches for and overwrites only individual overlapping properties in tweens that are running at the time the tween begins. <br /><code>
		 * 				
		 * 				TweenLite.to(mc, 1, {x:100, y:200});<br />
		 * 				TweenLite.to(mc, 1, {x:300}); //only overwrites the "x" property in the previous tween<br /><br /></code>
		 * 					
		 * <li><b> CONCURRENT (3):</b> Overwrites all tweens of the same object that are active at the time the tween begins.<br /><br /><code>
		 * 				
		 * 				TweenLite.to(mc, 1, {x:100, y:200});<br />
		 * 				TweenLite.to(mc, 1, {x:300, delay:2}); //does NOT overwrite the previous tween because the first tween will have finished by the time this one begins. </code>
		 * </ul>
		 **/
		public static function init($mode:int=2):int {
			if (TweenLite.version < 11.097) {
				trace("TweenLite warning: Your TweenLite class needs to be updated to work with OverwriteManager (or you may need to clear your ASO files). Please download and install the latest version from http://www.tweenlite.com.");
			}
			TweenLite.overwriteManager = OverwriteManager;
			mode = $mode;
			enabled = true;
			return mode;
		}
		
		/** @private **/
		public static function manageOverwrites($tween:TweenLite, $props:Object, $targetTweens:Array):void {
			var vars:Object = $tween.vars;
			var m:int = (vars.overwrite == undefined) ? mode : int(vars.overwrite);
			if (m < 2 || $targetTweens == null) {
				return;
			}
			var startTime:Number = $tween.startTime, overlaps:Array = [], cousins:Array = [], i:int, tween:TweenLite;
			for (i = $targetTweens.length - 1; i > -1; i--) {
				tween = $targetTweens[i];
				if (tween == $tween || tween.gc) {
					//ignore
				} else if (tween.timeline != $tween.timeline) {
					cousins[cousins.length] = tween;
				} else if (tween.startTime <= startTime && tween.startTime + tween.totalDuration > startTime && !getGlobalPaused(tween)) {
					overlaps[overlaps.length] = tween;
				}
			}
			
			if (cousins.length != 0) { //tweens that are nested in other timelines may have various offsets and timescales so we need to translate them to a global/root one to see how they compare.
				var combinedTimeScale:Number = $tween.cachedTimeScale, combinedStartTime:Number = startTime, cousin:Tweenable, cousinStartTime:Number, timeline:SimpleTimeline;
				timeline = $tween.timeline;
				while (timeline != null) {
					combinedTimeScale *= timeline.cachedTimeScale;
					combinedStartTime += timeline.startTime;
					timeline = timeline.timeline;
				}
				startTime = combinedTimeScale * combinedStartTime;
				for (i = cousins.length - 1; i > -1; i--) {
					cousin = cousins[i];
					combinedTimeScale = cousin.cachedTimeScale;
					combinedStartTime = cousin.startTime;
					timeline = cousin.timeline;
					while (timeline != null) {
						combinedTimeScale *= timeline.cachedTimeScale;
						combinedStartTime += timeline.startTime;
						timeline = timeline.timeline;
					}
					cousinStartTime = combinedTimeScale * combinedStartTime;
					if (cousinStartTime <= startTime && cousinStartTime + (cousin.totalDuration * combinedTimeScale) > startTime) {
						overlaps[overlaps.length] = cousin;
					}
				}
			}
			
			if (overlaps.length == 0) {
				return;
			}
			
			if (m == AUTO) {
				for (i = overlaps.length - 1; i > -1; i--) {
					overlaps[i].killVars($props);
				}
			
			} else {
				for (i = overlaps.length - 1; i > -1; i--) {
					overlaps[i].enabled = false; //flags for garbage collection
				}
			}
			
		}
		
		/** @private **/
		public static function getGlobalPaused($tween:Tweenable):Boolean {
			var tween:Tweenable = $tween;
			while (tween != null) {
				if (tween.cachedPaused) {
					return true;
				}
				tween = tween.timeline;
			}
			return false;
		}
		
	}
}