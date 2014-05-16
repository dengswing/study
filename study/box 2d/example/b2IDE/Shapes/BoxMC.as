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
	*	<p>An author-time movie clip representing a rectangular collision shape in the physics engine.
	*	To use, create a movie clip in the IDE with this class as a base class, and place it
	*	inside a clip extending WorldMC or BodyMC.
	*	</p><p>
	*	There are two ways to define the box's geometry:
	*	<ul><li> If you put no AnchorMCs inside the CircleMC, b2IDE will 
	*		determine the bounds of the BoxMC's author-time contents, and assume 
	*		they represent a rectangle.</li>
	*	<li>If you put two AnchorMCs inside the BoxMC, b2IDE will assume that they 
	*		represent the box's opposite corners.</li>
	*	</ul>
	*	If you put any other number of AnchorMCs inside the BoxMC, they will be ignored and
	*	b2IDE will trace a warning.
	*	In either case, the rectangle is assumed to be oriented with the MovieClip's co-ordinate system.
	*	</p>
	*	
	****************************************************************************/
	
	public class BoxMC extends PolygonMC {
		
		
		// set in IDE
		
		
		/************************************************************************
		*	Constructs the instance.
		************************************************************************/
		public function BoxMC() {
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
			if (anchors.length == 2) {
				setBoxFromAnchors( anchors, def, pixelsPerMeter );
			} else {
				if (anchors.length>0) {
					trace("Warning: unexpected number of AnchorMCs found in a BoxMC ("+anchors.length+").");
					trace("Ignoring the AnchorMCs and inferring the box's geometry from author-time bounds.");
					trace(" 	To define the Box's geometry with AnchorMCs, ");
					trace(" 	use two at the box's opposite corners. ");
				}
				setBoxFromBounds( def, pixelsPerMeter );
			}
			return def;
		}
		
		
		/************************************************************************
		*	Create a shape definition based on this MC
		************************************************************************/
		private function setBoxFromBounds( def:b2PolygonDef, ppm:Number ):void {
			// simply create from bounds, as in superclass PolygonMC
			setPolyBoxFromBounds( def, ppm );
		}
		
		/************************************************************************
		*	Create a shape definition from the AnchorMCs. Assume that they are
		*	opposite corners of the box. Internally, add two more to complete the
		*	corners, and use the same method as in superclass PolygonMC
		************************************************************************/
		private function setBoxFromAnchors( anchors:Vector.<AnchorMC>, def:b2PolygonDef, ppm:Number ):void {
			var ta1:AnchorMC = new AnchorMC();
			var ta2:AnchorMC = new AnchorMC();
			ta1.x = anchors[0].x;		ta1.y = anchors[1].y; 
			ta2.x = anchors[1].x;		ta2.y = anchors[0].y; 
			addChild( ta1 );			addChild( ta2 );
			var tempAnchors:Vector.<AnchorMC> = new Vector.<AnchorMC>();
			tempAnchors.push( anchors[0] );
			tempAnchors.push( anchors[1] );
			tempAnchors.push( ta1 );
			tempAnchors.push( ta2 );
			setPolyFromAnchors( tempAnchors, def, ppm );
			removeChild( ta1 );
			removeChild( ta2 );
		}
		

		//	Parameters inspectable from the IDE
		
		
		
		
		
	} // class
	
} // package