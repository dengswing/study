package b2IDE.Shapes {
	
	import flash.display.*;
	import flash.geom.*
	import flash.events.*;
	import flash.utils.*;
	import b2IDE.*;
	import b2IDE.Shapes.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	/****************************************************************************
	*	
	*	<p>An author-time movie clip representing a circular collision shape in the physics engine.
	*	To use, create a movie clip in the IDE with this class as a base class, and place it
	*	inside a clip extending WorldMC or BodyMC.
	*	</p><p>
	*	There are two ways to define the circle's geometry:
	*	<ul><li> If you put no AnchorMCs inside the CircleMC, b2IDE will 
	*		determine the bounds of the CircleMC's author-time contents, and assume 
	*		they represent a circular geometry.</li>
	*	<li>If you put two AnchorMCs inside the CircleMC, b2IDE will assume that the
	*		one nearer to the CircleMC's origin represents the circle's center and the 
	*		other is a point on the circle's edge.</li>
	*	</ul>
	*	If you put any other number of AnchorMCs inside the CircleMC, they will be ignored and
	*	b2IDE will trace a warning.
	*	</p>
	*	
	****************************************************************************/
	
	public class CircleMC extends AbstractShapeMC {
		
		
		// set in IDE
		
		
		/************************************************************************
		*	Constructs the instance.
		************************************************************************/
		public function CircleMC() {
			//
		}
		
		
		/************************************************************************
		*	Create a shape definition based on this MC
		*	@private
		************************************************************************/
		public override function makeShapeDefFromMC( pixelsPerMeter:Number ):b2ShapeDef {
			checkForScaling();
			var def:b2CircleDef = new b2CircleDef();
			setShapeDefProperties( def );
			var anchors:Vector.<AnchorMC> = getAnchorMCs();
			if (anchors.length == 2) {
				setCircleFromAnchors( anchors, def, pixelsPerMeter );
			} else {
				setCircleFromBounds( def, pixelsPerMeter );
				if (anchors.length>0) {
					trace("Warning: unexpected number of AnchorMCs found in a CircleMC ("+anchors.length+").");
					trace("Ignoring the AnchorMCs and inferring the circle's geometry from author-time bounds.");
					trace(" 	To define the Circle's geometry with AnchorMCs, use two: ");
					trace(" 	one for the center, and one to define the edge. b2IDE will assume ");
					trace(" 	the anchor nearer to the MovieClip's center is the center.");
				}
			}
			return def;
		}
		
		private function checkForScaling():void {
			var ds:Number = Math.abs( (scaleX-scaleY)/Math.max(scaleX,scaleY) );
			if (ds < .001) { return ; }
			if (ds < .01) {
				trace("Warning: a CircleMC was found that appears to be slightly scaled or skewed.");
				trace(" 	It will be processed normally, as if it was a perfect circle, but ");
				trace(" 	the difference between its visual and actual shape may be noticable.");
			} else {
				trace("Warning: a CircleMC was found that appears to be scaled or skewed.");
				trace(" 	It will be processed normally, as if it was a perfect circle, but the ");
				trace(" 	difference between its visual and actual shape will probably be noticable.");
			}
		}
		
		
		private function setCircleFromBounds( def:b2CircleDef, ppm:Number ):void {
			var r:Rectangle = getBounds(this);
			var hx:Number = r.width * scaleX / 2 / ppm;
			var hy:Number = r.height * scaleY / 2 / ppm;
			var p:Point = new Point( (r.left+r.right)/2, (r.top+r.bottom)/2 );
			p = parent.globalToLocal( this.localToGlobal(p) );
			var pos:b2Vec2 = new b2Vec2( p.x/ppm, p.y/ppm );
			def.localPosition = pos;
			def.radius = Math.max(hx, hy);
		}
		
		private function setCircleFromAnchors( anchors:Vector.<AnchorMC>, def:b2CircleDef, ppm:Number ):void {
			var p0:Point = new Point();
			var p1:Point = new Point( anchors[0].x, anchors[0].y );
			var p2:Point = new Point( anchors[1].x, anchors[1].y );
			if ( Point.distance(p0,p2) < Point.distance(p0,p1) ) {
				var p3:Point = p1.clone();
				p1 = p2;
				p2 = p3;
			}
			p0 = parent.globalToLocal( this.localToGlobal(p1) );
			p1 = parent.globalToLocal( this.localToGlobal(p2) );
			var pos:b2Vec2 = new b2Vec2( p0.x/ppm, p0.y/ppm );
			def.localPosition = pos;
			def.radius = Point.distance(p0,p1) / ppm;
		}
		




		//	Parameters inspectable from the IDE
		
		
		
		
		
	} // class
	
} // package