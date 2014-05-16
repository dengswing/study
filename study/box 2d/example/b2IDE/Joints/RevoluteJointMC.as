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
	*	<p>An author-time movie clip representing a revolute joint in the physics engine.
	*	A revolute joint joins two bodies as if they are pinned, and free to rotate relative
	*	to one another but not to move otherwise.
	*	</p><p>
	*	To define which joints are to be attached, place one AnchorMC inside the RevoluteJointMC,
	*	positioned so that it overlaps both author-time shapes or bodies you which to join. 
	*	Alternately, if you do not put in any AnchorMCs, the joint will use its origin as the anchor.
	*	</p><p>
	*	If b2IDE finds the anchor does only overlaps one body or shape, it will use the 
	*	world's static ground body as the other.
	*	If b2IDE finds more than one suitable body or shape overlapping each anchor, it will choose
	*	the one most directly below the joint MC in visual stacking order, so you'll
	*	probably want to place your joint on a layer immediately above the bodies or shapes you
	*	wish it to attach. If you put two or more AnchorMCs inside the joint MC, 
	*	the joint will be ignored and b2IDE will trace a warning.
	*	</p><p>
	*	As with all joints, b2IDE has no default implementation to visually update the joint's 
	*	appearance. To associate a visual effect with the joint, you should attach the MC 
	*	a class that extends the joint and implements the #draw and/or #initDraw methods,
	*	as in the Testbed.
	*	</p>
	*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Revolute_Joint
	*	
	****************************************************************************/
	
	public class RevoluteJointMC extends AbstractJointMC {
		
		
		// set in IDE
		private var _enableLimit:Boolean = false;
		private var _enableMotor:Boolean = false;
		private var _lowerAngle:Number = 0;
		private var _upperAngle:Number = 0;
		private var _maxMotorTorque:Number = 0;
		private var _motorSpeed:Number = 0;
		
		
		
		/************************************************************************
		*	Constructs the instance.
		************************************************************************/
		public function RevoluteJointMC() {
			//
		}
		
		
		
		
		/************************************************************************
		*	Create a shape definition based on this MC
		*	@private
		************************************************************************/
		public override function makeJointDefFromMC( w:WorldMC, ppm:Number ):b2JointDef {
			var def:b2RevoluteJointDef = new b2RevoluteJointDef();
			setJointDefProperties( def );
			def.enableLimit = _enableLimit;
			def.enableMotor = _enableMotor;
			def.lowerAngle = (_lowerAngle<_upperAngle) ? _lowerAngle : _upperAngle;
			def.upperAngle = (_lowerAngle<_upperAngle) ? _upperAngle : _lowerAngle;
			def.maxMotorTorque = _maxMotorTorque;
			def.motorSpeed = _motorSpeed;
			// process anchors
			var anchors:Vector.<AnchorMC> = getAnchorMCs();
			if (anchors.length > 1) {
				trace("Unexpected number of AnchorMCs found in Revolute joint: ("+anchors.length+").");
				trace(" 	Expected zero or one. Joint will be ignored.");
				return null;
			}
			// find bodies to attach
			var loc:DisplayObject = (anchors.length>0) ? anchors[0] : this;
			var p:Point = loc.localToGlobal( new Point() );
			// need at least one non-static body
			var bodies:Vector.<BodyMC> = getAttachableBodies( w, p, 1, true );
			if (bodies.length==0) {
				trace("Could not find a non-static body or shape overlapping revolute joint.");
				trace(" 	Joint will be ignored.");
				return null;
			}
			// and (optionally) another that can be static or dynamic, and isn't the first one
			var bodies2:Vector.<BodyMC> = getAttachableBodies( w, p, 2 );
			while( bodies2.length ) {
				var bmc:BodyMC = bodies2.shift();
				if (bmc != bodies[0]) {
					bodies.push( bmc );
					bodies2.length = 0;
				}
			}
			// if only one body is now found, use ground body for the other
			// note that the body known to be dynamic will be body 2, 
			// in case someone later wants to apply a Gear joint
			var b2:b2Body = bodies[0].body;
			var b1:b2Body = (bodies.length>1) ? bodies[1].body : w.getGroundBodyMC().body;
			p = w.globalToLocal( p );
			var anchor:b2Vec2 = new b2Vec2( p.x/ppm, p.y/ppm );
			def.Initialize( b1, b2, anchor );
			return def;
		}
		
		
		
		
		
		

		//	Parameters inspectable from the IDE
		
		
		/************************************************************************
		*	Whether to constrict the joint's movement according to the rotation limit parameters.
		*	@default false
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Revolute_Joint
		************************************************************************/
		[Inspectable(defaultValue=false,type="Boolean",name="enable limit")]
		public function set enableLimit( b:Boolean ):void {
			_enableLimit = b;
		}
		/************************************************************************
		*	Whether to enable the joint's motor.
		*	@default false
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Revolute_Joint
		************************************************************************/
		[Inspectable(defaultValue=false,type="Boolean",name="enable motor")]
		public function set enableMotor( b:Boolean ):void {
			_enableMotor = b;
		}
		/************************************************************************
		*	The lower angle (in degrees) to which the joint will be constricted, if 
		*	the joint's limits are enabled. This angle is considered to be the angle 
		*	of the lower body in relation to the higher, in visual stacking order, 
		*	and is considered to be zero at the time of initialization.
		*	@default 0
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Revolute_Joint
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="angle lower (deg)")]
		public function set lowerAngle( n:Number ):void {
			_lowerAngle = n / (180/Math.PI);
		}
		/************************************************************************
		*	The upper angle (in degrees) to which the joint will be constricted, if 
		*	the joint's limits are enabled. This angle is considered to be the angle 
		*	of the lower body in relation to the higher, in visual stacking order, 
		*	and is considered to be zero at the time of initialization.
		*	@default 0
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Revolute_Joint
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="angle upper (deg)")]
		public function set upperAngle( n:Number ):void {
			_upperAngle = n / (180/Math.PI);
		}
		/************************************************************************
		*	The maximum torque available to the joint's motor, if it is enabled.
		*	@default 0
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Revolute_Joint
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="max motor torque")]
		public function set maxMotorTorque( n:Number ):void {
			_maxMotorTorque = n;
		}
		/************************************************************************
		*	The motor's speed, if it is enabled.
		*	@default 0
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Revolute_Joint
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="motor speed")]
		public function set motorSpeed( n:Number ):void {
			_motorSpeed = n;
		}
		
		
		
	} // class
	
} // package