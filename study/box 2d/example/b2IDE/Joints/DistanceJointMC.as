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
	*	<p>An author-time movie clip representing a distance joint in the physics engine.
	*	A prismatic joint joins two bodies as if by a massless rod, so that they can rotate 
	*	relative to one another, but their anchored points will stay the same distance apart.
	*	</p><p>
	*	To define which joints are to be attached, place two AnchorMCs inside the DistanceJointMC,
	*	positioned so that they overlap the author-time shapes or bodies you which to join. Alternately, if
	*	one of the anchors does not overlap a body or shape, it will be assumed to attach to the 
	*	world's static ground body. 
	*	</p><p>
	*	If b2IDE finds more than one suitable body or shape overlapping each anchor, it will choose
	*	the one most directly below the joint MC in visual stacking order, so you'll
	*	probably want to place your joint on a layer immediately above the bodies or shapes you
	*	wish it to attach. If you put more or fewer than two AnchorMCs inside the DistanceJointMC, 
	*	the joint will be ignored and b2IDE will trace a warning.
	*	</p><p>
	*	As with all joints, b2IDE has no default implementation to visually update the joint's 
	*	appearance. To associate a visual effect with the joint, you should attach the MC 
	*	a class that extends the joint and implements the #draw and/or #initDraw methods,
	*	as in the Testbed.
	*	</p>
	*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Distance_Joint
	*	
	****************************************************************************/
	
	public class DistanceJointMC extends AbstractJointMC {
		
		
		// set in IDE
		private var _frequencyHz:Number = 0;
		private var _dampingRatio:Number = 0;
		private var _percentLength:Number = 100;
		
		
		
		/************************************************************************
		*	Constructs the instance.
		************************************************************************/
		public function DistanceJointMC() {
			//
		}
		
		
		
		
		/************************************************************************
		*	Create a shape definition based on this MC
		*	@private
		************************************************************************/
		public override function makeJointDefFromMC( w:WorldMC, ppm:Number ):b2JointDef {
			var def:b2DistanceJointDef = new b2DistanceJointDef();
			setJointDefProperties( def );
			def.frequencyHz = _frequencyHz;
			def.dampingRatio = _dampingRatio;
			// process anchors
			var anchors:Vector.<AnchorMC> = getAnchorMCs();
			if (anchors.length != 2) {
				trace("Unexpected number of AnchorMCs found in Distance joint: ("+anchors.length+").");
				trace(" 	Expected two. Joint will be ignored.");
				return null;
			}
			var p1:Point = anchors[0].localToGlobal( new Point() );
			var p2:Point = anchors[1].localToGlobal( new Point() );
			// find bodies to attach
			var bv1:Vector.<BodyMC> = getAttachableBodies( w, p1, 1 );
			var bv2:Vector.<BodyMC> = getAttachableBodies( w, p2, 1 );
			if (bv1.length==0 && bv2.length==0) {
				trace("Could not find any bodies or shapes overlapping distance joint.");
				trace(" 	Joint will be ignored.");
				return null;
			}
			// if only one body is found, use ground body for the other
			var b1:b2Body = (bv1.length>0) ? bv1[0].body : w.getGroundBodyMC().body;
			var b2:b2Body = (bv2.length>0) ? bv2[0].body : w.getGroundBodyMC().body;
			p1 = w.globalToLocal( p1 );
			p2 = w.globalToLocal( p2 );
			var anchor1:b2Vec2 = new b2Vec2( p1.x/ppm, p1.y/ppm );
			var anchor2:b2Vec2 = new b2Vec2( p2.x/ppm, p2.y/ppm );
			def.Initialize( b1, b2, anchor1, anchor2 );
			def.length = def.length * _percentLength/100;
			return def;
		}
		
		
		
		
		
		
		
		//	Parameters inspectable from the IDE
		
		
		/************************************************************************
		*	The percentage of the joint's separation on the stage which should be used
		*	as its equilibrium separation in the engine. For example if this is set to 50,
		*	the engine will consider the joint to be initially stretched to double its
		*	equilibrium length.
		*	@default 100
		************************************************************************/
		[Inspectable(defaultValue=100,type="Number",name="% length equilibrium")]
		public function set percentLength( n:Number ):void {
			_percentLength = n;
		}
		
		/************************************************************************
		*	The response speed, in Hz. 
		*	@default 0
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Distance_Joint
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="frequency Hz")]
		public function set frequencyHz( n:Number ):void {
			_frequencyHz = n;
		}
		/************************************************************************
		*	The damping ratio, where 0 is none, and 1 is critical damping.
		*	@default 0
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Distance_Joint
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="damping ratio")]
		public function set dampingRatio( n:Number ):void {
			_dampingRatio = n;
		}
		
		
	} // class
	
} // package