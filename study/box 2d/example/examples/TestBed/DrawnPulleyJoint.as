package TestBed {
	
	import flash.display.*;
	import flash.geom.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Common.Math.*;
	import b2IDE.*;
	import b2IDE.Joints.*;
	
	
	/****************************************************************************
	*	
	*	adds a #draw method to PulleyJointMC
	*	
	****************************************************************************/
	
	
	public class DrawnPulleyJoint extends PulleyJointMC {
		
		// in IDE
		public var string1:MovieClip;
		public var string2:MovieClip;
		
		private var switched:Boolean;
		private var string1Loc:Point;
		private var string2Loc:Point;
		
		
		/************************************************************************
		*	Constructor
		************************************************************************/
		public function DrawnPulleyJoint() {
			//
		}
		
		
		/************************************************************************
		*	Initialize the joint's position. 
		************************************************************************/
		public override function initDraw( ppm:Number ):void {
			var v1:b2Vec2 = joint.GetAnchor1();
			var v2:b2Vec2 = joint.GetAnchor2();
			string1Loc = parent.globalToLocal( string1.localToGlobal(new Point()) );
			string2Loc = parent.globalToLocal( string2.localToGlobal(new Point()) );
			switched = (v2.x < v1.x);
			draw( ppm );
		}
		
		/************************************************************************
		*	Update the joint's position. 
		************************************************************************/
		public override function draw( ppm:Number ):void {
			var v1:b2Vec2 = (switched) ? joint.GetAnchor2() : joint.GetAnchor1();
			var v2:b2Vec2 = (switched) ? joint.GetAnchor1() : joint.GetAnchor2();
			var p1:Point = new Point( v1.x*ppm, v1.y*ppm );
			var p2:Point = new Point( v2.x*ppm, v2.y*ppm );
			string1.scaleX = (p1.x - string1Loc.x)/100;
			string1.scaleY = (p1.y - string1Loc.y)/100;
			string2.scaleX = (p2.x - string2Loc.x)/100;
			string2.scaleY = (p2.y - string2Loc.y)/100;
		}
		
		

		
	} // class
	
	
	
	
} // package