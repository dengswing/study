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
	*	<p>An abstract base class for all author-time classes representing shapes in the physics engine.
	*	This class' purpose is to define properties common to all shapes, to be inherited.
	*	Do extend this directly; extend one of the actual shapes instead.
	*	</p>
	*	
	****************************************************************************/
	
	public class AbstractShapeMC extends AbstractWorldObject {
		
		/**
		* Reference to the Box2D.Collision.Shapes.b2Shape representing this shape.
		*/
		public var shape:b2Shape;
		
		// set in IDE
		private var _friction:Number = 0.2;
		private var _restitution:Number = 0;
		private var _density:Number = 0; // 0 = fixed
		private var _isSensor:Boolean = false;
		private var _filterCategoryBits:uint = 0x0001;
		private var _filterMaskBits:uint = 0xFFFF;
		private var _filterGroupIndex:int = 0;
		
		
		/************************************************************************
		*	Constructs the instance.
		************************************************************************/
		public function AbstractShapeMC() {
			//
		}
		
		
		
		/************************************************************************
		*	Create a shape definition based on this MC to be passed to Box2D. 
		*	This should be overridden by child classes.
		*	@private
		************************************************************************/
		public virtual function makeShapeDefFromMC( pixelsPerMeter:Number ):b2ShapeDef {
			return null;
		}
		
		/************************************************************************
		*	Set the base properties common to all shape definitions
		*	@private
		************************************************************************/
		protected function setShapeDefProperties( def:b2ShapeDef ):void {
			def.friction = _friction;
			def.density = _density;
			def.restitution = _restitution;
			def.isSensor = _isSensor;
			def.filter.categoryBits = _filterCategoryBits;
			def.filter.maskBits = _filterMaskBits;
			def.filter.groupIndex = _filterGroupIndex;
			def.userData = this;
		}
		
		
		/************************************************************************
		*	Get a list of all AnchorMCs in the shape (used for specifying geometry)
		*	@private
		************************************************************************/
		protected function getAnchorMCs():Vector.<AnchorMC> {
			var anchors:Vector.<AnchorMC> = new Vector.<AnchorMC>();
			for (var i:int=0; i<numChildren; i++) {
				var c:DisplayObject = getChildAt(i);
				if (c is AnchorMC) { anchors.push( c as AnchorMC ); }
			}
			return anchors;
		}
		
		/************************************************************************
		*	Remove AnchorMCs from display list after processing them
		*	@private
		************************************************************************/
		public function removeAnchorMCs():void {
			for (var i:int=0; i<numChildren; i++) {
				if (getChildAt(i) is AnchorMC) {
					removeChildAt(i);
					i--;
				}
			}
		}



		//	Parameters inspectable from the IDE
		
		
		
		/************************************************************************
		*	Coefficient of friction, between 0 and 1.
		*	@default 0
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Friction_and_Restitution
		************************************************************************/
		[Inspectable(defaultValue=0.2,type="Number",name="Friction")]
		public function set friction( n:Number ):void {
			_friction = n;
		}
		
		/************************************************************************
		*	Coefficient of restitution (bounciness), usually between 0 and 1.
		*	@default 0
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Friction_and_Restitution
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="Restitution")]
		public function set restitution( n:Number ):void {
			_restitution = n;
		}
		
		/************************************************************************
		*	Density of the shape, in kg/m<sup>2</sup> - set to zero to make the shape static. 
		*	After initialization, the shape's mass will be set automatically based on 
		*	the density and geometry.
		*	@default 0
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Density
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="Density")]
		public function set density ( n:Number ):void {
			_density = n;
		}
		/** @private */
		public function get density ():Number {
			return _density;
		}
		
		/************************************************************************
		*	Whether the shape is a sensor, used only for detecting collisions.
		*	@default false
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Sensors
		************************************************************************/
		[Inspectable(defaultValue=false,type="Boolean",name="is sensor")]
		public function set isSensor( b:Boolean ):void {
			_isSensor = b;
		}
		
		/************************************************************************
		*	The shape's filter category, as a string representing a four-digit hexadecimal number.
		*	See the Box2D AS3 manual for more information on filtering.
		*	@default 0x0001
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Filtering
		************************************************************************/
		[Inspectable(defaultValue="0x0001",type="String",name="filter category bits")]
		public function set filterCategoryBits( s:String ):void {
			var n:int = parseInt( s, 16 );
			if (isNaN(n) || (n<0)) { throw new ArgumentError( "Bad filter category bits: "+n ); }
			_filterCategoryBits = uint(n);
		}

		/************************************************************************
		*	The shape's filter mask, as a string representing a four-digit hexadecimal number.
		*	See the Box2D AS3 manual for more information on filtering.
		*	@default 0xFFFF
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Filtering
		************************************************************************/
		[Inspectable(defaultValue="0xFFFF",type="String",name="filter mask bits")]
		public function set filterMaskBits( s:String ):void {
			var n:int = parseInt( s, 16 );
			if (isNaN(n) || (n<0)) { throw new ArgumentError( "Bad filter mask bits: "+n ); }
			_filterMaskBits = uint(n);
		}

		/************************************************************************
		*	The shape's filter group, a positive or negative integer.
		*	See the Box2D AS3 manual for more information on filtering.
		*	@default 0
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Filtering
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="filter  group index")]
		public function set filterGroupIndex( n:Number ):void {
			if (isNaN(n)) { throw new ArgumentError( "Bad filter group index: "+n ); }
			_filterGroupIndex = int(n);
		}

		
	} // class
	
} // package