package b2IDE.Joints {
	
	import flash.display.*;
	import flash.geom.*
	import flash.events.*;
	import flash.utils.*;
	import b2IDE.*;
	import b2IDE.Shapes.*;
	import b2IDE.Joints.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Common.Math.*;
	
	/****************************************************************************
	*	
	*	An abstract base class for all author-time classes representing joints in the physics engine.
	*	This class' purpose is to define properties common to all joints, to be inherited.
	*	Do not extend this directly unless you're implementing a new kind of Joint. 
	*	Extend one of the child classes instead.
	*	
	****************************************************************************/
	
	public class AbstractJointMC extends AbstractWorldObject {
		
		/**
		* Reference to the Box2D.Dynamics.Joints.b2Joint representing this shape.
		*/
		public var joint:b2Joint;
		
		// set in IDE
		private var _collideConnected:Boolean = false;
		private var _updateDisplay:Boolean = false;
		
		
		/************************************************************************
		*	Constructs the instance.
		************************************************************************/
		public function AbstractJointMC() {
			//
		}
		
		
		
		/************************************************************************
		*	Create a joint definition based on this MC - overriden by child classes.
		*	May return null when a joint cannot be made (i.e. because attachments weren't found.)
		*	@private
		************************************************************************/
		public virtual function makeJointDefFromMC( w:WorldMC, pixelsPerMeter:Number ):b2JointDef {
			return null;
		}
		
		/************************************************************************
		*	<p>Update the joint's display - this is not implemented in any of the 
		*	default joints, since the details will depend on the joint's graphics.
		*	To make a joint that redraws itself, extend the joint class you want and 
		*	implement this method.
		*	</p><p>
		*	If your world has WorldMC.autoRender set to true, then each
		*	joint's #draw method will be called after each timestep; otherwise don't
		*	forget to call it yourself.
		*	</p>
		*	@param ppm Pixels per meter - the world scaling constant.
		************************************************************************/
		public virtual function draw( ppm:Number ):void {
			//
		}
		
		/************************************************************************
		*	Initialize the joint's display - this is not implemented in any of the 
		*	default joints, since the details will depend on the joint's graphics.
		*	This method will be called right after the joint's engine counterpart
		*	has been created, to allow the joint to do any initialization required
		*	for updating its display.
		*	@param ppm Pixels per meter - the world scaling constant.
		************************************************************************/
		public virtual function initDraw( ppm:Number ):void {
			//
		}
		
		/************************************************************************
		*	Set the base properties common to all shape definitions
		*	@private
		************************************************************************/
		public function setJointDefProperties( def:b2JointDef ):void {
			def.collideConnected = _collideConnected;
			def.userData = this;
		}
		
		
		
		
		
		/************************************************************************
		*	Get a list of all AnchorMCs in the joint (used for specifying geometry)
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
		
		
		
		/************************************************************************
		*	Attempt to find a JointMC of type Prismatic or Revolute 
		* 	at the given (global stage coord) point (for attaching to a gear joint).
		*	@private
		************************************************************************/
		protected function getAttachableJoint( w:WorldMC, p:Point ):AbstractJointMC {
			var queue:Vector.<AbstractJointMC> = new Vector.<AbstractJointMC>();
			var disp:Vector.<DisplayObject> = getInstancesUnderPoint( w, p, AbstractJointMC );
			for (var i:int=0; i<disp.length; i++) {
				var d:DisplayObject = disp[i];
				// only keep prismatic or revolute joints; only they are attachable
				if ( ! (d is PrismaticJointMC || d is RevoluteJointMC) ) {
					disp.splice( i, 1 );
					i--;
				}
			}
			if (disp.length==0) { return null; }
			if (disp.length==1) { return disp[0] as AbstractJointMC; }
			disp = sortQueueUnderDisplayObject( w, this, disp, 1 );
			return disp[0] as AbstractJointMC;
		}
		
		
		
		/************************************************************************
		*	Attempt to find a given number of bodies at the given (global stage coord) point
		*	to attach to a joint anchor.
		*	@private
		************************************************************************/
		internal function getAttachableBodies( w:WorldMC, 
											  p:Point, 
											  count:int,
											  dynamicOnly:Boolean=false, 
											  staticOnly:Boolean=false ):Vector.<BodyMC> {
			var queue:Vector.<BodyMC> = new Vector.<BodyMC>();
			if (staticOnly && dynamicOnly) { return queue; } // doh!
			var disp:Vector.<DisplayObject> = getInstancesUnderPoint( w, p, BodyMC );
			while( disp.length ) {
				var bmc:BodyMC = disp.pop() as BodyMC;
				var ok:Boolean = (bmc.body.IsStatic()) ? !dynamicOnly : !staticOnly;
				if (ok) { queue.push(bmc); }
			}
			var doQueue:Vector.<DisplayObject> = Vector.<DisplayObject>( queue );
			var ret:Vector.<DisplayObject> = sortQueueUnderDisplayObject( w, this, doQueue, count );
			return Vector.<BodyMC>( ret );
		}
		
		
		
		
		/************************************************************************
		*	Helper - return DisplayObjects that are under the given (global stage coord) point,
		*	and instances of the given class, and direct children of given container
		*	TODO: typing in here is messy, and makes assumptions about classRef. 
		*		If I find a way to make implicity typed vectors, clean it up so 
		*		that ret is of type classRef.
		*	@private
		************************************************************************/
		private function getInstancesUnderPoint( container:DisplayObjectContainer, 
											  p:Point, 
											  classRef:Class ):Vector.<DisplayObject> {
			var ret:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			var objects:Array = container.getObjectsUnderPoint(p);
			objectLoop: while( objects.length ) {
				var obj:DisplayObject = objects.pop() as DisplayObject;
				// getObjectsUnderPoint will return multiple objects in the same parent, so if 
				// classRef is a container, check whether obj is a child of a previous hit:
				for (var i:int=0; i<ret.length; i++) {
					if ((ret[i] as DisplayObjectContainer).contains(obj)) {
						continue objectLoop;
					}
				}
				// see helper below
				var d:DisplayObject = findClassesInParentage( obj, classRef ) as DisplayObject;
				try {
					if (container.getChildIndex(d) > -1) {
						ret.push( d );
					}
				} catch(e:Error) { /* ignore error when d is not direct child of container */ }
			}
			return ret;
		}
		
		/************************************************************************
		*	helper - find instance of classRef in d's display-list parentage
		*	@private
		************************************************************************/
		private function findClassesInParentage( d:DisplayObject, classRef:Class ):Object {
			if (d is classRef) { return d; }
			while( d.parent ) {
				if (d.parent is classRef) { return d.parent; }
				d = d.parent;
			}
			return null;
		}
		
		
		/************************************************************************
		*	Another helper. Given a parent, a queue of children, and a swing object, 
		*	sort the queue such that children more immediately below the swing object 
		*	are first, followed by those above it.
		*	If the swing is not a child of the parent, pretend it's on top.
		*	Limit length of return vector to "count".
		*	@private
		************************************************************************/
		private function sortQueueUnderDisplayObject( container:DisplayObjectContainer, 
													 swing:DisplayObject, 
													 queue:Vector.<DisplayObject>,
													 count:int ):Vector.<DisplayObject> {
			var swingIndex:int = container.numChildren + 1;
			try {
				swingIndex = container.getChildIndex( swing );
			} catch(e:Error) { /* throws ignorable error if not direct child of container */ }
			// make an array of ad-hoc object to sort: obj = { index:indexInQueue, depth:indexInContainer }
			var arr:Array = new Array(); // of objects
			for (var i:int=0; i<queue.length; i++) {
				var d:int = container.getChildIndex( queue[i] );
				if ( d > swingIndex ) { d -= container.numChildren; }
				arr.push( { index:i, depth:d } );
			}
			arr.sortOn( "depth", Array.NUMERIC | Array.DESCENDING );
			var ret:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			for (i=0; i<count && i<arr.length; i++) {
				ret.push( queue[ arr[i].index ] );
			}
			return ret;
		}



		//	Parameters inspectable from the IDE
		
		
		
		/************************************************************************
		*	Whether to allow the collision of the two bodies joined by this joint.
		*	@default false
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#The_Joint_Definition
		************************************************************************/
		[Inspectable(defaultValue=false,type="Boolean",name="collide connected")]
		public function set collideConnected( b:Boolean ):void {
			_collideConnected = b;
		}
		
		
	} // class
	
} // package