package b2IDE {
	
	import flash.display.*;
	import flash.geom.*
	import flash.events.*;
	import flash.utils.*;
	import b2IDE.*;
	import Box2D.Dynamics.*;
	
	/****************************************************************************
	*	
	*	<p>An author-time container corresponding to a rigid body in the physics engine.
	*	To use, a movie clip extending this class should be placed inside a WorldMC. 
	*	You'll also want to populate the BodyMC with shapes, from the b2IDE.Shapes package.
	*	</p><p>
	*	Note: When you use a BodyMC, you can rotate it, scale it, or skew it as you like, 
	*	and things should work out fine. However, since the Box2D engine does not consider 
	*	bodies to take any transformations except translation and rotation, if you scale or
	*	skew your BodyMC, internally b2IDE will unscale it, and apply the scaling or skewing
	*	to its children. This shouldn't cause any problems, but if you manage the BodyMC's
	*	display manually, you may need to take this into account.
	*	</p>
	*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Bodies
	*	@see b2IDE.Shapes
	*	
	****************************************************************************/
	
	public class BodyMC extends AbstractWorldObject {
		
		/**
		* Reference to the Box2D.Dynamics.b2Body representing this world.
		*/
		public var body:b2Body;
		
		// set in IDE
		private var _linearDamping:Number = -1; // <0 means inherit from world
		private var _angularDamping:Number = -1; // <0 means inherit from world
		private var _allowSleep:Boolean = true;
		private var _isSleeping:Boolean = false;
		private var _fixedRotation:Boolean = false;
		private var _isBullet:Boolean = false;
		
		
		/************************************************************************
		*	Constructor
		************************************************************************/
		public function BodyMC() {
			//
		}
		
		
		/************************************************************************
		*	Create a body definition based on this MC
		*	@private
		************************************************************************/
		public function makeBodyDefFromMC( pixelsPerMeter:Number,
									   baseLinearDamping:Number, 
									   baseAngularDamping:Number ):b2BodyDef {
			var ppm:Number = pixelsPerMeter;
			var def:b2BodyDef = new b2BodyDef();
			def.position.Set( x/ppm, y/ppm );
			def.angle = rotation * (Math.PI/180);
			def.linearDamping = (_linearDamping < 0) ? baseLinearDamping : _linearDamping;
			def.angularDamping = (_angularDamping < 0) ? baseAngularDamping : _angularDamping;
			def.allowSleep = _allowSleep;
			def.isSleeping = _isSleeping;
			def.fixedRotation = _fixedRotation;
			def.isBullet = _isBullet;
			def.userData = this;
			return def;
		}
		
		
		
		/************************************************************************
		*	If this bodyMC has a scale transformation, unscale self and apply the 
		*	transformation to children instead. To preserve user clarity, leave 
		*	translation/rotation as they are.
		************************************************************************/
		public function unscaleSelf():void {
			// allow a tolerance, as merely rotated MCs tend to have a scale of ~ 1.000001
			var ds:Number = Math.max( Math.abs(1-scaleX), Math.abs(1-scaleY) );
			if (ds < .00001) { return; } // body is not scaled (significantly)
			// note the previous tolerance is low enough that some bodies will be caught
			// even though they're only rotated, but it's necessary to catch bodies
			// that are slightly skewed. Anyway, the resulting adjustment to rotated bodies
			// should be too small to notice.
			var ix:Number = x;
			var iy:Number = y;
			var irot:Number = rotation / 180*Math.PI;
			var im:Matrix = transform.matrix;
			im.translate( -ix, -iy );
			im.rotate( -irot );
			for (var i:int=0; i<numChildren; i++) {
				var child:DisplayObject = getChildAt(i);
				var cm:Matrix = child.transform.matrix;
				cm.concat( im );
				child.transform.matrix = cm;
			}
			im.identity();
			im.rotate( irot );
			im.translate( ix, iy );
			transform.matrix = im;
		}
		
		
		



		//	Parameters inspectable from the IDE
		
		
		
		/************************************************************************
		*	Amount of linear damping - using a value less than 0 will cause the body to
		*	inherit the WorldMC's base damping value.
		*	@default -1
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Damping
		************************************************************************/
		[Inspectable(defaultValue=-1,type="Number",name="damping, linear (<0=inherit)")]
		public function set linearDamping( n:Number ):void {
			_linearDamping = n;
		}
		
		/************************************************************************
		*	Amount of angular damping - using a value less than 0 will cause the body to
		*	inherit the WorldMC's base damping value.
		*	@default -1
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Damping
		************************************************************************/
		[Inspectable(defaultValue=-1,type="Number",name="damping, angular (<0=inherit)")]
		public function set angularDamping( n:Number ):void {
			_angularDamping = n;
		}
		
		/************************************************************************
		*	Whether the body is allowed to go to sleep.
		*	@default true
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Sleep_Parameters
		************************************************************************/
		[Inspectable(defaultValue=true,type="Boolean",name="allow sleep")]
		public function set allowSleep( b:Boolean ):void {
			_allowSleep = b;
		}
		
		/************************************************************************
		*	Whether the body is initially sleeping.
		*	@default false
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Sleep_Parameters
		************************************************************************/
		[Inspectable(defaultValue=false,type="Boolean",name="is sleeping")]
		public function set isSleeping( b:Boolean ):void {
			_isSleeping = b;
		}
		
		/************************************************************************
		*	If true, the body is not allowed to rotate.
		*	@default false
		************************************************************************/
		[Inspectable(defaultValue=false,type="Boolean",name="fixed rotation")]
		public function set fixedRotation( b:Boolean ):void {
			_fixedRotation = b;
		}
		
		/************************************************************************
		*	Whether the body uses continual collision detection.
		*	@default false
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Bullets
		************************************************************************/
		[Inspectable(defaultValue=false,type="Boolean",name="is bullet")]
		public function set isBullet( b:Boolean ):void {
			_isBullet = b;
		}
		
		
		
	} // class
	
} // package