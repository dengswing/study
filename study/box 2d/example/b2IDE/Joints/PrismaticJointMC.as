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
	*	<p>An author-time movie clip representing a prismatic joint in the physics engine.
	*	A prismatic joint joins two bodies so that they can move, with respect to each other,
	*	only along a specified axis, and so that they cannot rotate in relation to one another.
	*	</p><p>
	*	To define which joints are to be attached, place two AnchorMCs inside the PrismaticJointMC,
	*	positioned so that they overlap the author-time shapes or bodies you which to join. 
	*	Alternately, if one of the anchors does not overlap a body or shape, it will be assumed 
	*	to attach to the world's static ground body. 
	*	</p><p>
	*	If b2IDE finds more than one suitable body or shape overlapping each anchor, it will choose
	*	the one most directly below the joint MC in visual stacking order, so you'll
	*	probably want to place your joint on a layer immediately above the bodies or shapes you
	*	wish it to attach. If you put more or fewer than two AnchorMCs inside the joint, 
	*	the joint will be ignored and b2IDE will trace a warning.
	*	</p><p>
	*	As with all joints, b2IDE has no default implementation to visually update the joint's 
	*	appearance. To associate a visual effect with the joint, you should attach the MC 
	*	a class that extends the joint and implements the #draw and/or #initDraw methods,
	*	as in the Testbed.
	*	</p>
	*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Prismatic_Joint
	*	
	****************************************************************************/
	
	public class PrismaticJointMC extends AbstractJointMC {
		
		
		// set in IDE
		private var _enableLimit:Boolean = false;
		private var _enableMotor:Boolean = false;
		private var _lowerTransPercent:Number = 100;
		private var _upperTransPercent:Number = 100;
		private var _maxMotorForce:Number = 0;
		private var _motorSpeed:Number = 0;
		
		
		
		/************************************************************************
		*	Constructs the instance.
		************************************************************************/
		public function PrismaticJointMC() {
			//
		}
		
		
		
		
		/************************************************************************
		*	Create a shape definition based on this MC
		*	@private
		************************************************************************/
		public override function makeJointDefFromMC( w:WorldMC, ppm:Number ):b2JointDef {
			var def:b2PrismaticJointDef = new b2PrismaticJointDef();
			setJointDefProperties( def );
			def.enableLimit = _enableLimit;
			def.enableMotor = _enableMotor;
			def.maxMotorForce = _maxMotorForce;
			def.motorSpeed = _motorSpeed;
			// process anchors
			var anchors:Vector.<AnchorMC> = getAnchorMCs();
			if (anchors.length != 2) {
				trace("Unexpected number of AnchorMCs found in Prismatic joint: ("+anchors.length+").");
				trace(" 	Expected two. Joint will be ignored.");
				return null;
			}
			var p1:Point = anchors[0].localToGlobal( new Point() );
			var p2:Point = anchors[1].localToGlobal( new Point() );
			// find bodies to attach
			var bv1:Vector.<BodyMC> = getAttachableBodies( w, p1, 1 );
			var bv2:Vector.<BodyMC> = getAttachableBodies( w, p2, 1 );
			if (bv1.length==0 && bv2.length==0) {
				trace("Could not find bodies or shapes overlapping either anchor of prismatic joint.");
				trace(" 	Joint will be ignored.");
				return null;
			}
			// if only one body is found, use ground body for the other
			var b1:b2Body = (bv1.length>0) ? bv1[0].body : w.getGroundBodyMC().body;
			var b2:b2Body = (bv2.length>0) ? bv2[0].body : w.getGroundBodyMC().body;
			// prefer that if either body is static, it's body 1, in case someone attaches a Gear joint
			if (b2.IsStatic()) {
				var temp:b2Body=b1; b1=b2; b2=temp;
			}
			if (b2.IsStatic()) {
				trace("Both bodies/shapes under prismatic joint were static.");
				trace(" 	Joint will be ignored.");
				return null;
			}
			// arbitrarily choose the worldAxis to be in the upper (or straight right) direction, 
			// in global screen coords. Important for which direction is upper/lower translation
			var wp1:Point = w.globalToLocal( p1 );
			var wp2:Point = w.globalToLocal( p2 );
			var wanchor:Point = new Point( wp2.x-wp1.x, wp2.y-wp1.y );
			var worldAxis:b2Vec2 = new b2Vec2( wanchor.x/ppm, wanchor.y/ppm );
			var dx:Number = p2.x - p1.x;
			var dy:Number = p2.y - p1.y;
			if ( (dy>0) || (dy==0 && dx<0) ) {
				worldAxis = worldAxis.Negative();
			}
			// per Erin Catto's advice, place anchor at center of mass of the two bodies,
			// or at the center of the dynamic body if one is static
			// http://www.box2d.org/forum/viewtopic.php?f=3&t=3215
			var anchor:b2Vec2 = new b2Vec2();
			if (b1.IsStatic()) {
				anchor = b2.GetWorldCenter();
			} else {
				var a1:b2Vec2 = b1.GetWorldCenter();
				var a2:b2Vec2 = b2.GetWorldCenter();
				var m1:Number = b1.GetMass();
				var m2:Number = b2.GetMass();
				anchor.x = (a1.x*m1 + a2.x*m2) / (m1+m2);
				anchor.y = (a1.y*m1 + a2.y*m2) / (m1+m2);
			}
			// find limits in terms of the distance between anchors
			var dist:Number = worldAxis.Length();
			var lmin:Number = dist * (100 - _lowerTransPercent)/100;
			var lmax:Number = dist * (100 - _upperTransPercent)/100;
			def.lowerTranslation = Math.min(lmin,lmax);
			def.upperTranslation = Math.max(lmin,lmax);
			// continue
			worldAxis.Normalize();
			def.Initialize( b1, b2, anchor, worldAxis);
			return def;
		}
		
		
		
		
		
		
		//	Parameters inspectable from the IDE
		
		
		/************************************************************************
		*	Whether to constrict the joint's movement according to the translation limit parameters.
		*	@default false
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Prismatic_Joint
		************************************************************************/
		[Inspectable(defaultValue=false,type="Boolean",name="enable limit")]
		public function set enableLimit( b:Boolean ):void {
			_enableLimit = b;
		}
		/************************************************************************
		*	Whether to enable the joint's motor.
		*	@default false
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Prismatic_Joint
		************************************************************************/
		[Inspectable(defaultValue=false,type="Boolean",name="enable motor")]
		public function set enableMotor( b:Boolean ):void {
			_enableMotor = b;
		}
		/************************************************************************
		*	<p>The lower translation limit, as a percentage of the initial separation
		*	between the anchors. For example, a value of 50 means the lower limit will be 
		*	when the distance between the two bodies is half their original separation.
		*	</p><p>
		*	For the purpose of "upper" and "lower" translation limits, the prismatic
		*	joint is considered to be pointing toward which ever anchor is higher than 
		*	the other (in screen coordinates), or if they are directly horizontal, toward
		*	the rightmost anchor.</p>
		*	@default 100
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Prismatic_Joint
		************************************************************************/
		[Inspectable(defaultValue=100,type="Number",name="% lower translation")]
		public function set lowerTransPercent( n:Number ):void {
			_lowerTransPercent = n;
		}
		/************************************************************************
		*	<p>The upper translation limit, as a percentage of the initial separation
		*	between the anchors. For example, a value of 200 means the upper limit will be 
		*	when the distance between the two bodies is twice their original separation.
		*	</p><p>
		*	For the purpose of "upper" and "lower" translation limits, the prismatic
		*	joint is considered to be pointing toward which ever anchor is higher than 
		*	the other (in screen coordinates), or if they are directly horizontal, toward
		*	the rightmost anchor.</p>
		*	@default 100
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Prismatic_Joint
		************************************************************************/
		[Inspectable(defaultValue=100,type="Number",name="% upper translation")]
		public function set upperTransPercent( n:Number ):void {
			_upperTransPercent = n;
		}
		/************************************************************************
		*	The maximum force available to the joint's motor, if it is enabled.
		*	@default 0
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Prismatic_Joint
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="max motor Force")]
		public function set maxMotorForce( n:Number ):void {
			_maxMotorForce = n;
		}
		/************************************************************************
		*	The motor's speed, if it is enabled.
		*	@default 0
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Prismatic_Joint
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="motor speed")]
		public function set motorSpeed( n:Number ):void {
			_motorSpeed = n;
		}
		
		
	} // class
	
} // package