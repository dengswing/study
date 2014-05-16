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
	*	<p>An author-time movie clip representing a Mouse joint in the physics engine.
	*	A mouse joint is essentially a temporary distance joint, created between the world's 
	*	ground body and a dynamic body that the user has clicked. As the user drags their mouse,
	*	the ground-body end of the temporary joint is moved with the mouse.
	*	</p><p>
	*	If you include a Movie Clip that extends MouseJointMC in your WorldMC, 
	*	b2IDE will automatically create some event handlers for you, which will create a 
	*	Mouse joint when objects are clicked, update its anchor position as the mouse moves,
	*	and destroy the joint when the mouse is released. 
	*	
	*	
	*	</p><p>
	*	As with all joints, b2IDE has no default implementation to visually update the joint's 
	*	appearance. To associate a visual effect with the joint, you should attach the MC 
	*	a class that extends the joint and implements the #draw and/or #initDraw methods,
	*	as in the Testbed.
	*	</p>
	*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Mouse_Joint
	*	
	****************************************************************************/
	
	public class MouseJointMC extends AbstractJointMC {
		
		
		// set in IDE
		private var _maxForceMultiplier:Number = 10;
		private var _frequencyHz:Number = 5;
		private var _dampingRatio:Number = 0.7;
		
		
		
		/************************************************************************
		*	Constructs the instance.
		************************************************************************/
		public function MouseJointMC() {
			//
		}
		
		
		
		
		/************************************************************************
		*	Create a shape definition based on this MC
		*	@private
		************************************************************************/
		public override function makeJointDefFromMC( w:WorldMC, ppm:Number ):b2JointDef {
			var def:b2MouseJointDef = new b2MouseJointDef();
			setJointDefProperties( def );
			def.frequencyHz = _frequencyHz;
			def.dampingRatio = _dampingRatio;
			// find bodies to attach to, etc.
			var mouseWorld:Point = new Point( w.mouseX, w.mouseY );
			var mouseGlobal:Point = w.localToGlobal( mouseWorld );
			var bv:Vector.<BodyMC> = getAttachableBodies( w, mouseGlobal, 1, true );
			if (bv.length==0) {
				return null; // nothing to attach to at the mouse
			}
			def.body1 = w.world.GetGroundBody();
			def.body2 = bv[0].body;
			def.target.Set( mouseWorld.x/ppm, mouseWorld.y/ppm );
			def.timeStep = w.timestep;
			def.maxForce = _maxForceMultiplier * bv[0].body.GetMass();
			return def;
		}
		
		
		
		
		
		
		//	Parameters inspectable from the IDE
		
		
		/************************************************************************
		*	Maximum force multiplier - the maximum force available to the joint is
		*	this value, multiplied by the mass of the body being dragged.
		*	You'll probably find values in the range of 10-200 work best.
		*	@default 10
		************************************************************************/
		[Inspectable(defaultValue=10,type="Number",name="max force multiplier")]
		public function set maxForceMultiplier( n:Number ):void {
			_maxForceMultiplier = n;
		}
		/************************************************************************
		*	The response speed, in Hz. 
		*	@default 5
		************************************************************************/
		[Inspectable(defaultValue=5,type="Number",name="frequency Hz")]
		public function set frequencyHz( n:Number ):void {
			_frequencyHz = n;
		}
		/************************************************************************
		*	The damping ratio, where 0 is none, and 1 is critical damping.
		*	@default 0.7
		************************************************************************/
		[Inspectable(defaultValue=0.7,type="Number",name="damping ratio")]
		public function set dampingRatio( n:Number ):void {
			_dampingRatio = n;
		}
		
		
	} // class
	
} // package