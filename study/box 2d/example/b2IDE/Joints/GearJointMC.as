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
	*	<p>An author-time movie clip representing a gear joint in the physics engine.
	*	A gear joint is used to attach two joints to each other, so that as one moves
	*	it forces the other to move as well (possibly in the opposite direction). 
	*	The two joints attached may be either Prismatic or Revolute.
	*	</p><p>
	*	To define which joints are to be attached, place two AnchorMCs inside the GearJointMC,
	*	positioned so that they overlap the appropriate joints in the authoring environment.
	*	If b2IDE finds more than one suitable joint overlapping each anchor, it will choose
	*	the joint most directly below the GearJointMC in visual stacking order, so you'll
	*	probably want to place your GearJointMC on a layer immediately above the joints you
	*	wish it to attach. If you put more or fewer than two AnchorMCs inside the GearJointMC, 
	*	the joint will be ignored and b2IDE will trace a warning.
	*	</p><p>
	*	As with all joints, b2IDE has no default implementation to visually update the joint's 
	*	appearance. To associate a visual effect with the joint, you should attach the MC 
	*	a class that extends the joint and implements the #draw and/or #initDraw methods,
	*	as in the Testbed.
	*	</p>
	*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Gear_Joint
	*	
	****************************************************************************/
	
	public class GearJointMC extends AbstractJointMC {
		
		
		// set in IDE
		private var _ratio:Number = 1;
		
		
		
		/************************************************************************
		*	Constructs the instance.
		************************************************************************/
		public function GearJointMC() {
			//
		}
		
		
		
		
		/************************************************************************
		*	Create a shape definition based on this MC
		*	@private
		************************************************************************/
		public override function makeJointDefFromMC( w:WorldMC, ppm:Number ):b2JointDef {
			var def:b2GearJointDef = new b2GearJointDef();
			setJointDefProperties( def );
			// process anchors
			var anchors:Vector.<AnchorMC> = getAnchorMCs();
			if (anchors.length != 2) {
				trace("Unexpected number of AnchorMCs found in Gear joint: ("+anchors.length+").");
				trace(" 	Expected two. Joint will be ignored.");
				return null;
			}
			var p1:Point = anchors[0].localToGlobal( new Point() );
			var p2:Point = anchors[1].localToGlobal( new Point() );
			// arbitrarily, have joint1 be the one globally to the left (important in assigning ratio)
			var j1:AbstractJointMC = getAttachableJoint( w, ((p1.x<p2.x)?p1:p2) );
			var j2:AbstractJointMC = getAttachableJoint( w, ((p1.x<p2.x)?p2:p1) );
			if (j1==null || j2==null) {
				trace("Could not find Revolute/Prismatic joints under both anchors of Gear joint.");
				trace(" 	Joint will be ignored.");
				return null;
			}
			def.joint1 = j1.joint;
			def.joint2 = j2.joint;
			// prismatic/revolute joints always try to make body2 the dynamic one
			def.body1 = j1.joint.GetBody2();
			def.body2 = j2.joint.GetBody2();
			def.ratio = _ratio;
			return def;
		}
		
		
		
		
		
		
		//	Parameters inspectable from the IDE
		
		
		/************************************************************************
		*	The gear ratio between the two joints attached by this gear. The two joints
		*	are constricted by the formula:
		*	<pre>       coordinate1 + ratio * coordinate2 == constant</pre>
		*	where "coordinate1" is chosen to be that of the joint whose gear is furthest
		*	left in global coordinates.
		*	@default 1
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Gear_Joint
		************************************************************************/
		[Inspectable(defaultValue=1,type="Number",name="ratio")]
		public function set ratio( n:Number ):void {
			_ratio = n;
		}
		
		
	} // class
	
} // package