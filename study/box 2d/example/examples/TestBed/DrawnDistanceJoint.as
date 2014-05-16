package TestBed {
	
	import flash.geom.*;
	import Box2D.Common.Math.*;
	import b2IDE.Joints.*;
	
	
	/****************************************************************************
	*	
	*	adds a #draw method to DistanceJointMC
	*	
	****************************************************************************/
	
	
	public class DrawnDistanceJoint extends DistanceJointMC {
		
		
		
		/************************************************************************
		*	Constructor
		************************************************************************/
		public function DrawnDistanceJoint() {
			//
		}
		
		
		/************************************************************************
		*	Update the joint MovieClip's position. 
		************************************************************************/
		public override function draw( ppm:Number ):void {
			var v1:b2Vec2 = joint.GetAnchor1();
			var v2:b2Vec2 = joint.GetAnchor2();
			var p1:Point = new Point( v1.x*ppm, v1.y*ppm );
			var p2:Point = new Point( v2.x*ppm, v2.y*ppm );
			x = p1.x;
			y = p1.y;
			scaleX = Point.distance(p1, p2)  / getBounds(this).right;
			rotation = Math.atan2( p2.y-p1.y, p2.x-p1.x ) * (180/Math.PI);
		}
		
		

		
	} // class
	
	
	
	
} // package