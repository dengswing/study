package b2IDE.Shapes {
	
	import flash.display.*;
	import flash.geom.*
	import flash.events.*;
	import flash.utils.*;
	import b2IDE.*;
	import b2IDE.Shapes.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Common.*;
	
	/****************************************************************************
	*	
	*	<p>An author-time movie clip representing a polygonal collision shape in the physics engine.
	*	To use, create a movie clip in the IDE with this class as a base class, and populate it with
	*	three or more AnchorMCs. Then place it inside a clip extending WorldMC or BodyMC.
	*	</p><p>
	*	To define the polygon's geometry, simply add three or more AnchorMCs to the 
	*	PolygonMC. You don't have to worry about their order, b2IDE will automatically 
	*	sort them into the proper order for initialization with Box2D. Note, however, that you 
	*	can only create convex polygons. To create concave collision geometries, deconstruct
	*	them into a set of concave geometries, and combine those geometries into one collision shape.
	*	See the Box2D AS3 manual for details.
	*	</p><p>
	*	If you put two or fewer AnchorMCs inside the BoxMC, they will be ignored and the
	*	polygon will be initialzed as a rectangular box, and b2IDE will trace a warning.
	*	Likewise, if you include a larger number of anchors than your Box2D's setting for 
	*	maximum number of vertices in a polygon, b2IDE will trace a warning and 
	*	use as many vertices as it can.</p>
	*	
	*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Polygon_Definitions
	*	
	****************************************************************************/
	
	public class PolygonMC extends AbstractShapeMC {
		
		
		// set in IDE
		
		
		/************************************************************************
		*	Constructor
		************************************************************************/
		public function PolygonMC() {
			//
		}
		
		
		/************************************************************************
		*	Create a shape definition based on this MC
		*	@private
		************************************************************************/
		public override function makeShapeDefFromMC( pixelsPerMeter:Number ):b2ShapeDef {
			var def:b2PolygonDef = new b2PolygonDef();
			setShapeDefProperties( def );
			var anchors:Vector.<AnchorMC> = getAnchorMCs();
			if (anchors.length > 2) {
				setPolyFromAnchors( anchors, def, pixelsPerMeter );
			} else {
				setPolyBoxFromBounds( def, pixelsPerMeter );
				trace("Warning: unexpected number of AnchorMCs found in a PolygonMC ("+anchors.length+").");
				trace("Ignoring the AnchorMCs and treating this as a box, from author-time bounds.");
				trace(" 	To define the Poly's geometry with AnchorMCs, use 3 or more.");
			}
			return def;
		}
		
		/************************************************************************
		*	Create a shape definition from the bounds of the MC's contents
		*	Internally, attach a set of AnchorMCs and process like any Polygon, then
		*	remove them. This because it covers the case when the polygon is skewed.
		*	@private
		************************************************************************/
		internal function setPolyBoxFromBounds( def:b2PolygonDef, ppm:Number ):void {
			var r:Rectangle = getBounds(this);
			var tempAnchors:Vector.<AnchorMC> = new Vector.<AnchorMC>();
			var i:int;
			for (i=0; i<4; i++) {
				var amc:AnchorMC = new AnchorMC();
				tempAnchors.push( amc );
				switch(i) {
					case 0: amc.x=r.left; 	amc.y=r.top; 	break;
					case 1: amc.x=r.right; 	amc.y=r.top; 	break;
					case 2: amc.x=r.left; 	amc.y=r.bottom; 	break;
					case 3: amc.x=r.right; 	amc.y=r.bottom; 	break;
				}
				addChild( amc );
			}
			setPolyFromAnchors( tempAnchors, def, ppm );
			while(tempAnchors.length) {
				removeChild( tempAnchors.pop() );
			}
		}
		
		
		/************************************************************************
		*	Create a shape definition based on a queue of AnchorMCs
		*	@private
		************************************************************************/
		internal function setPolyFromAnchors( anchors:Vector.<AnchorMC>, def:b2PolygonDef, ppm:Number ):void {
			// create list of transformed Points
			var ptList:Vector.<Point> = new Vector.<Point>();
			for (var i:int=0; i<anchors.length; i++) {
				var amc:AnchorMC = anchors[i];
				var p:Point = new Point( amc.x, amc.y );
				p = parent.globalToLocal( this.localToGlobal(p) );
				ptList.push(p);
			}
			// deep magic
			var hull:Vector.<Point> = createConvexHull( ptList );
			// limit number of vertices
			limitVertices( hull );
			// make def
			def.vertexCount = hull.length;
			for (i=0; i<hull.length; i++) {
				def.vertices[i].Set( hull[i].x/ppm, hull[i].y/ppm );
			}
		}
		

		/************************************************************************
		*	Limit number of vertices, if necessary
		************************************************************************/
		private function limitVertices( pts:Vector.<Point> ):void {
			var lim:int = b2Settings.b2_maxPolygonVertices;
			if (pts.length > lim) {
				trace("Warning: PolygonMC found with "+pts.length+" exterior points, ");
				trace("		but the current limit on vertices per polygon is "+lim+". ");
				trace("		Extra vertices will be ignored for now. Please trim your polygon, ");
				trace("		or increase the limit by editing:");
				trace("		Box2D.Common.b2Settings.b2_maxPolygonVertices");
				pts.length = lim;
			}
		}
			
		
		/************************************************************************
		*	Create a convex hull from a jumble of points
		************************************************************************/
		private function createConvexHull( pts:Vector.<Point> ):Vector.<Point> {
			// require at least 3 points
			var len:int = pts.length;
			if (len < 3) {
				throw new ArgumentError("Cannot create polygon from fewer than 3 points");
			}
			// begin the algo. Find the leftmost, bottommost point, which is 
			// guaranteed to be part of the hull. Also find centroid of the points.
			var anchor:Point = pts[0];
			var center:Point = anchor.clone();
			for (var i:int=1; i<len; i++) {
				var p:Point = pts[i];
				if (p.x < anchor.x || (p.x==anchor.x && p.y > anchor.y) ) {
					anchor = p;
				}
				center.x += p.x;
				center.y += p.y;
			}
			center.x /= len;
			center.y /= len;
			// Make an array of objects containing each point, and the angle it 
			// makes with the anchor-center line
			var anchorAngle:Number = Math.atan2( center.y-anchor.y, center.x-anchor.x );
			var toSort:Array = []; // of vanilla Object
			for (i=0; i<len; i++) {
				p = pts[i];
				toSort[i] = { p:p };
				var a:Number = Math.atan2( center.y-p.y, center.x-p.x ) - anchorAngle;
				toSort[i].angle = (a<0) ? a+360 : a;
			}
			// sort according to said angle. 
			toSort.sortOn( "angle", Array.NUMERIC );
			// now follow the usual gift-wrapping method
			// first add the anchor node to the end to make it find a full loop. (pop it later.)
			toSort.push( { p:toSort[0].p.clone() } );
			// queue first two points
			pts = new Vector.<Point>();
			pts.push( toSort.shift().p );
			pts.push( toSort.shift().p );
			// now walk through the sorted list of points, adding each to the return stack.
			// Each time the last three points make an angle>180, delete the midpoint
			// check the angle with a cross product
			var sub:Vector.<Point> = new Vector.<Point>();
			var v1:b2Vec2, v2:b2Vec2;
			var remove:Boolean;
			while( toSort.length>0 ) {
				pts.push( toSort.shift().p );
				sub = pts.slice(-3);
				v1 = new b2Vec2( sub[1].x-sub[0].x, sub[1].y-sub[0].y );
				v2 = new b2Vec2( sub[1].x-sub[2].x, sub[1].y-sub[2].y );
				remove = (cross(v1,v2) > 0);
				while ( remove ) {
					pts[pts.length-2] = pts.pop();
					if (pts.length > 2) {
						sub = pts.slice(-3);
						v1 = new b2Vec2( sub[1].x-sub[0].x, sub[1].y-sub[0].y );
						v2 = new b2Vec2( sub[1].x-sub[2].x, sub[1].y-sub[2].y );
						remove = (cross(v1,v2) > 0);
					} else {
						remove = false;
					}
				}
			}
			// remove doubled anchor point
			pts.pop();
			return pts;
		}
		
		// helper - returns 2D cross product; i.e. magnitude of result in Z-dir.
		private function cross( v1:b2Vec2, v2:b2Vec2 ):Number {
			return v1.x * v2.y - v1.y * v2.x;
		}
		


		//	Parameters inspectable from the IDE
		
		
		
		
		
	} // class
	
} // package