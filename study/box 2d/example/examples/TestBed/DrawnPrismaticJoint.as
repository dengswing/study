package TestBed {
	
	import flash.geom.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Common.Math.*;
	import b2IDE.*;
	import b2IDE.Joints.*;
	
	
	/****************************************************************************
	*	
	*	adds a #draw method to PrismaticJointMC
	*	
	****************************************************************************/
	
	
	public class DrawnPrismaticJoint extends PrismaticJointMC {
		
		private var b1:BodyMC;
		private var b2:BodyMC;
		private var p1:Point;
		private var p2:Point;
		private var initWidth:Number = 100;
		
		/************************************************************************
		*	Constructor
		************************************************************************/
		public function DrawnPrismaticJoint() {
			//
		}
		
		
		/************************************************************************
		*	Initialize the joint's position. 
		************************************************************************/
		public override function initDraw( ppm:Number ):void {
			b1 = joint.GetBody1().GetUserData() as BodyMC;
			b2 = joint.GetBody2().GetUserData() as BodyMC;
			p1 = localToGlobal( new Point() );
			p2 = localToGlobal( new Point(initWidth,0) );
			if ( b2.hitTestPoint( p1.x, p1.y) ) {
				var tmp:BodyMC=b1; b1=b2; b2=tmp;
			}
			p1 = b1.globalToLocal( p1 );
			p2 = b2.globalToLocal( p2 );
		}
		
		/************************************************************************
		*	Update the joint's position. 
		************************************************************************/
		public override function draw( ppm:Number ):void {
			var w1:Point = parent.globalToLocal( b1.localToGlobal(p1) );
			var w2:Point = parent.globalToLocal( b2.localToGlobal(p2) );
			x = w1.x;
			y = w1.y;
			scaleX = Point.distance(w1,w2) / initWidth;
			rotation = Math.atan2( w2.y-w1.y, w2.x-w1.x ) * (180/Math.PI);
		}
		
		

		
	} // class
	
	
	
	
} // package