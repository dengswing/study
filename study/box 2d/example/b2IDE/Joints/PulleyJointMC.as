package b2IDE.Joints{
	
	import flash.display.*;
	import flash.geom.*
	import flash.events.*;
	import flash.utils.*;
	import b2IDE.*;
	import b2IDE.Shapes.*;
	import b2IDE.Joints.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Common.Math.*;
	
	/****************************************************************************
	*	
	*	<p>An author-time movie clip representing a pulley joint in the physics engine.
	*	A pully joint joins two bodies to two anchor points on the world's static ground body, 
	*	such that the distance of each body from its anchor varies with that of the other.
	*	</p><p>
	*	To define which joints are to be attached, place four AnchorMCs inside the PulleyJointMC. 
	*	b2IDE will determine the body or shape most directly below the pulley joint 
	*	in visual stacking order, and use the world's static ground body if none is found. 
	*	</p><p>
	*	Of the four bodies or shapes thus chosen, if two of them are static and two dynamic, 
	*	b2IDE will join the leftmost dynamic body with the leftmost static body for 
	*	one side of the pulley, and the remaining two for the other. If more or fewer than 
	*	two of the bodies are static, or if there are not four AnchorMCs in the joint, 
	*	the joint will be ignored and b2IDE will trace a warning.
	*	</p><p>
	*	As with all joints, b2IDE has no default implementation to visually update the joint's 
	*	appearance. To associate a visual effect with the joint, you should attach the MC 
	*	a class that extends the joint and implements the #draw and/or #initDraw methods,
	*	as in the Testbed.
	*	</p>
	*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Pulley_Joint
	*	
	****************************************************************************/
	
	public class PulleyJointMC extends AbstractJointMC {
		
		
		// set in IDE
		private var _maxLengthPercent1:Number = 0;
		private var _maxLengthPercent2:Number = 0;
		private var _ratio:Number = 1;
		
		
		
		/************************************************************************
		*	Constructs the instance.
		************************************************************************/
		public function PulleyJointMC() {
			//
		}
		
		
		
		
		/************************************************************************
		*	Create a shape definition based on this MC
		*	@private
		************************************************************************/
		public override function makeJointDefFromMC( w:WorldMC, ppm:Number ):b2JointDef {
			var def:b2PulleyJointDef = new b2PulleyJointDef();
			setJointDefProperties( def );
			// process anchors
			var anchors:Vector.<AnchorMC> = getAnchorMCs();
			if (anchors.length != 4) {
				trace("Unexpected number of AnchorMCs found in Pulley joint: ("+anchors.length+").");
				trace(" 	Expected four. Joint will be ignored.");
				return null;
			}
			var points:Vector.<Point> = new Vector.<Point>();
			var i:int;
			for (i=0; i<anchors.length; i++) {
				points[i] = anchors[i].localToGlobal( new Point() );
			}
			// find bodies to attach
			var bodies:Vector.<BodyMC> = new Vector.<BodyMC>();
			for (i=0; i<points.length; i++) {
				var bv:Vector.<BodyMC> = getAttachableBodies( w, points[i], 1 );
				bodies[i] = (bv.length==0) ? null : bv[0];
			}
			var statics:Vector.<int> = new Vector.<int>();
			var dynamics:Vector.<int> = new Vector.<int>();
			for (i=0; i<bodies.length; i++) {
				if (bodies[i] == null) {
					statics.push(i);
				} else if (bodies[i].body.IsStatic()) {
					statics.push(i);
				} else {
					dynamics.push(i);
				}
			}
			if (statics.length != 2) {
				trace("Unexpected number of static bodies among Pulley joint anchors: ("+statics.length+").");
				trace(" 	Expected two. Joint will be ignored.");
				return null;
			}
			// arbitrarily, leftmost anchors are for pulley 1
			if (points[statics[1]].x < points[statics[0]].x) {
				statics.reverse();
			}
			if (points[dynamics[1]].x < points[dynamics[0]].x) {
				dynamics.reverse();
			}
			// for rest of calculations, put point list back into world coords
			for (i=0; i<points.length; i++) {
				points[i] = w.globalToLocal( points[i] );
			}
			// now have 4 reference points in world coords
			var sp1:Point = points[statics[0]];
			var sp2:Point = points[statics[1]];
			var dp1:Point = points[dynamics[0]];
			var dp2:Point = points[dynamics[1]];
			// dynamic bodies
			var b1:b2Body = bodies[dynamics[0]].body;
			var b2:b2Body = bodies[dynamics[1]].body;
			// ground anchors in world coords
			var ga1:b2Vec2 = new b2Vec2( sp1.x/ppm, sp1.y/ppm );
			var ga2:b2Vec2 = new b2Vec2( sp2.x/ppm, sp2.y/ppm );
			// dynamic body anchors
			var anchor1:b2Vec2 = new b2Vec2( dp1.x/ppm, dp1.y/ppm );
			var anchor2:b2Vec2 = new b2Vec2( dp2.x/ppm, dp2.y/ppm );
			// init
			def.Initialize( b1, b2, ga1, ga2, anchor1, anchor2,	_ratio );
			
			/* TODO
			do something with max lengths and IDE parameters */
			if (def.maxLength1<0 || def.maxLength1<0) {
				trace("Warning: a pulley Joint has been configured such that the initial combined ");
				trace(" 	length of its two sides is less than the minimum setting specified in ");
				trace(" 	Box2D.Dynamics.Joints.b2PulleyJoint.b2_minPulleyLength.");
				trace(" 	This causes Box2D to treat the pulley as having negative max lengths, ");
				trace(" 	which makes things bug out. To fix, do any of the following: ");
				trace(" 	 1. Change the minimum setting (something like .02 or .002 should work)");
				trace(" 	 2. Lower your world scaling factor");
				trace(" 	 3. Change your pulley's layout so the initial distances are larger");
				trace(" 	b2IDE will now finish registering your pulley, but expect it to act strangely.");
			}
			if (_maxLengthPercent1 > 0) {
				var ta1:b2Vec2 = anchor1.Copy();
				ta1.Subtract(ga1);
				def.maxLength1 = ta1.Length() * (_maxLengthPercent1/100);
			}
			if (_maxLengthPercent2 > 0) {
				var ta2:b2Vec2 = anchor2.Copy();
				ta2.Subtract(ga2);
				def.maxLength2 = ta2.Length() * (_maxLengthPercent2/100);
			}
			return def;
		}
		
		
		
		
		
		
		//	Parameters inspectable from the IDE
		
		
		/************************************************************************
		*	<p>Max length of the leftmost side of the pulley system, as a percentage of 
		*	the initial length. For example, if the leftmost static anchor and the leftmost
		*	dynamic anchor start out 500 pixels apart, a value of "110" will limit their
		*	maximum separation to 550 pixels (110% of 500 pixels). If the a value of 100
		*	is used, this side of the pulley is assumed to initially be at its maximum length.
		*	</p><p>
		*	If you leave this setting at the default (0) or less, 
		*	Box2D will automatically choose a value that lets this side of the pulley 
		*	get as long as possible without the opposite
		*	side getting shorter than some minimum length, specified in
		*	Box2D.Dynamics.Joints.b2PulleyJoint.b2_minPulleyLength.
		*	</p><p> However, note that 
		*	this minimum setting is 2.0 (meters) in the standard Box2D distribution, 
		*	which is quite long. Particularly if the combined length of both sides of your 
		*	is initially shorter than 2m (in world-scaled units), Box2D will treat the 
		*	pulleys as if they have a negative max length, which is bad. In this case, 
		*	b2IDE will trace a warning that you need to change the b2_minPulleyLength setting.
		*	</p>
		*	@default 0
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Pulley_Joint
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="max Length % (left)")]
		public function set maxLengthPercent1( n:Number ):void {
			_maxLengthPercent1 = n;
		}
		/************************************************************************
		*	<p>Max length of the rightmost side of the pulley system, as a percentage of 
		*	the initial length. For example, if the rightmost static anchor and the rightmost
		*	dynamic anchor start out 500 pixels apart, a value of "110" will limit their
		*	maximum separation to 550 pixels (110% of 500 pixels). If the a value of 100
		*	is used, this side of the pulley is assumed to initially be at its maximum length.
		*	</p><p>
		*	If you leave this setting at the default (0) or less, 
		*	Box2D will automatically choose a value that lets this side of the pulley 
		*	get as long as possible without the opposite
		*	side getting shorter than some minimum length, specified in
		*	Box2D.Dynamics.Joints.b2PulleyJoint.b2_minPulleyLength.
		*	</p><p> However, note that 
		*	this minimum setting is 2.0 (meters) in the standard Box2D distribution, 
		*	which is quite long. Particularly if the combined length of both sides of your 
		*	is initially shorter than 2m (in world-scaled units), Box2D will treat the 
		*	pulleys as if they have a negative max length, which is bad. In this case, 
		*	b2IDE will trace a warning that you need to change the b2_minPulleyLength setting.
		*	</p>
		*	@default 0
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Pulley_Joint
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="max Length % (right)")]
		public function set maxLengthPercent2( n:Number ):void {
			_maxLengthPercent2 = n;
		}
		/************************************************************************
		*	A ratio specifying, in the manner of a block-and-tackle, how far one arm
		*	of the pulley system moves in response to the other. When this ratio is 
		*	greater than 1, the body attached to the left arm of the pulley must move
		*	5 meters for the other body to move 1 meter (but will require 5 times less
		*	force to do so than with a ratio of 1). Values of 0 or below are ignored.
		*	@default 1
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Pulley_Joint
		************************************************************************/
		[Inspectable(defaultValue=1,type="Number",name="ratio")]
		public function set ratio( n:Number ):void {
			if (n>0) { _ratio = n; }
		}
		
		
	} // class
	
} // package