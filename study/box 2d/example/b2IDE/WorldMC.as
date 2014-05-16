package b2IDE {
	
	import flash.display.*;
	import flash.geom.*
	import flash.events.*;
	import flash.utils.*;
	import b2IDE.*;
	import b2IDE.Shapes.*;
	import b2IDE.Joints.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	/****************************************************************************
	*	
	*	<p>b2IDE's top-level author-time component.
	*	</p><p>
	*	To use, make a MovieClip in the IDE, give it this as a Base class, and then put other 
	*	b2IDE-extending MovieClips inside. 
	*	</p><p>
	*	b2IDE is designed to be used with the Flash AS3 port of 
	*	<a href="http://box2dflash.sourceforge.net/" target="_blank">Box2D</a>, an open-source
	*	physics engine.</p>
	*	
	*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#The_World
	*	
	****************************************************************************/
	
	public class WorldMC extends MovieClip {
		
		
		/**
		* Reference to the Box2D.Dynamics.b2World representing this world. 
		*/
		public var world:b2World;
		
		// set in IDE - docs at end of file
		private var _pixelsPerMeter:Number = 100;
		private var _timestep:Number = 0; // 0-> determine from framerate
		private var _iterations:int = 10;
		private var _baseLinearDamping:Number = 0; // for child MCs to inherit
		private var _baseAngularDamping:Number = 0; // for child MCs to inherit
		private var _gravityX:Number = 0;
		private var _gravityY:Number = 9.8;
		private var _doSleep:Boolean = true;
		
		// involved with auto rendering every frame
		private var _autoRender:Boolean = true;
		private var isOnStage:Boolean = false;
		private var lastRender:int = -10000;
		private var lastFrame:int = 0;
		
		// involved with auto mouse joints
		private var mouseJointsInitted:Boolean = false;
		private var mouseJointMC:MouseJointMC;
		private var updateMouseJointOnRender:Boolean = false;
		
		// other variables
		private var groundBodyMC:BodyMC = null;
		
		
		/************************************************************************
		*	<p> When the WorldMC initializes (at first render),
		*	it will create a b2World to represent itself, and then spider through its children 
		*	looking for other b2IDE objects. As it finds them, it will similarly create Box2D
		*	shapes and joints to represent them.
		*	</p><p>
		*	If you then set the #autoRender flag, this class will listen to "enter frame" events,
		*	execute timesteps in the Box2D world, and render the results by moving about its
		*	child b2IDE objects. Alternately, you can set #autoRender to false and manage
		*	your own timesteps and rendering. </p>
		************************************************************************/
		public function WorldMC() {
			if (parent != null) {
				// on exiting the initial frame, initialize the world
				// exit_frame  - 
				addEventListener( Event.EXIT_FRAME, initialFrameHandler, false, 0, true );
				addEventListener( Event.ADDED_TO_STAGE, stageAddHandler, false, 0, true );
				addEventListener( Event.REMOVED_FROM_STAGE, stageAddHandler, false, 0, true );
				stage.invalidate();
			} else {
				throw new Error( getQualifiedClassName + 
					": do not instantiate this class directly, make stage objects " +
					"in the IDE that extend it and add them to the stage.");
			}
		}
		
		/************************************************************************
		*	Initialize world (after variables are set from authoring)
		*	This is called on EXIT_FRAME, which seems to be the first event usable.
		*	It falls after children have been constructed and had their component 
		*	parameters set, but before they have entered their second frame.
		************************************************************************/
		private function initialFrameHandler(e:Event):void {
			this.removeEventListener( Event.EXIT_FRAME, initialFrameHandler );
			init();
		}
		/************************************************************************
		*	Avoid auto-rendering when worldMC is not in the stage hierarchy
		************************************************************************/
		private function stageAddHandler(e:Event):void {
			if (e.type==Event.ADDED_TO_STAGE) { isOnStage = true; }
			if (e.type==Event.REMOVED_FROM_STAGE) { isOnStage = false; }
		}
		
		
		/************************************************************************
		*	The grand lovely init function
		************************************************************************/
		private function init():void {
			// if timestep is zero, set it from framerate (once)
			if (_timestep <= 0) { _timestep = 1 / stage.frameRate; }
			// create the b2World object to correspond to this MC
			world = createWorld();
			// recursively look for ContainerMCs, and reparent their contents into their place
			removeContainerMCs();
			// look for transformed BodyMCs and unscale them if necessary
			unscaleBodyMCs();
			// look through children for ShapeMCs to be reparented inside BodyMCs
			reparentShapesToBodyMCs();
			// Find all child BodyMCs, and process them into the world
			// Contained shapeMCs are also processed. Receive a queue of them for post-processing.
			var shapeQueue:Vector.<AbstractShapeMC> = addBodyMCsToWorld();
			// And do the same for JointMCs - add them to the world and receive a queue
			var jointQueue:Vector.<AbstractJointMC> = addJointMCsToWorld();
			// Post-process shapes and joints
			postProcessShapesAndJoints( shapeQueue, jointQueue );
			// if autoRender is set, start rendering every frame
			if (_autoRender) {
				addEventListener( Event.ENTER_FRAME, onFrame, false, 0, true );
			}
		}


		
		
		/************************************************************************
		*	Enter frame handler for stepping
		************************************************************************/
		private function createWorld():b2World {
			// estimate world bounding box to be 100 times the size at authoring time
			var r:Rectangle = getBounds(this);
			r.x /= _pixelsPerMeter;
			r.y /= _pixelsPerMeter;
			r.width /= _pixelsPerMeter;
			r.height /= _pixelsPerMeter;
			r.inflate(100,100);
			var worldAABB:b2AABB = new b2AABB();
			// note that lower bound is r.top, since flash's Y-axis is inverted
			worldAABB.lowerBound.Set( r.left, r.top );
			worldAABB.upperBound.Set( r.right, r.bottom );
			var grav:b2Vec2 = new b2Vec2( _gravityX, _gravityY );
			return new b2World(worldAABB, grav, _doSleep);
		}
		
		
		
		/************************************************************************
		*	Recurse through child WorldObjects for ContainerMCs.
		*	When one is found, have tell it to remove itself, and put its children 
		*	where it was (retaining transformation and depth). 
		*	Structure the loop so that the newly reparented objects will then be processed, 
		*	to catch any containers that were previously nested.
		*	Afterwards, recursively do the same in all child WorldObjects.
		************************************************************************/
		private function removeContainerMCs():void {
			recurseForContainers( this );
		}
		private function recurseForContainers( obj:DisplayObjectContainer ):void {
			var i:int = 0;
			while(i<obj.numChildren) {
				var c:DisplayObject = obj.getChildAt(i);
				if (c is ContainerMC) {
					(c as ContainerMC).replaceSelfWithChildren();
				} else {
					i++;
					if (c is AbstractWorldObject) {
						recurseForContainers( c as AbstractWorldObject );
					}
				}
			}
		}
		
		
		/************************************************************************
		*	The physics engine doesn't consider a body to take any transformations
		*	except translation and rotation. Look for BodyMCs, and if one is found
		*	that seems to be skewed or scaled, tell it to unscale itself, applying 
		*	the transformation to its children instead.
		************************************************************************/
		private function unscaleBodyMCs():void {
			for (var i:int=0; i<numChildren; i++) {
				var c:DisplayObject = getChildAt(i);
				if (c is BodyMC) {
					(c as BodyMC).unscaleSelf();
				}
			}
		}
		
		
		/************************************************************************
		*	Add ShapeMCs to the world - 
		*	Look through child MCs for ShapeMCs. For each, if it is dynamic, 
		*	reparent it into a BodyMC container. Otherwise, add to groundBodyMC
		************************************************************************/
		private function reparentShapesToBodyMCs():void {
			// find all ShapeMCs
			var shapeQueue:Vector.<AbstractShapeMC> = new Vector.<AbstractShapeMC>;
			for (var i:int=0; i<numChildren; i++) {
				var d:DisplayObject = getChildAt(i);
				if (d is AbstractShapeMC) { shapeQueue.push(d as AbstractShapeMC); }
			}
			// reparent each ShapeMC into a BodyMC
			while (shapeQueue.length) {
				var s:AbstractShapeMC = shapeQueue.pop();
				if (s.density > 0) {
					var b:BodyMC = new BodyMC();
					addChild(b);
					// so that reparented shape's body will be at same depth as shape was
					swapChildren(b,s); 
					// for now, untranslate the shape and translate the Body. May revisit.
					b.x = s.x;
					b.y = s.y;
					s.x = s.y = 0;
					//b.rotation = s.rotation;
					//s.rotation = 0;
					b.addChild(s);
				} else {
					var gb:BodyMC = getGroundBodyMC();
					swapChildren(gb,s); 
					gb.addChild(s);
				}
			}
		}
		
		
		
		/************************************************************************
		*	Add BodyMCs to the world - 
		*	Look through child MCs for BodyMC, and for each, make an appropriate 
		*	body definition, create a body, and add it to the world.
		*	Inside each BodyMC, also look inside for child shapes and add them. 
		*	Return a queue of all ShapeMCs for post-processing.
		************************************************************************/
		private function addBodyMCsToWorld():Vector.<AbstractShapeMC> {
			// find all BodyMCs
			var bodyQueue:Vector.<BodyMC> = new Vector.<BodyMC>();
			for (var i:int=0; i<numChildren; i++) {
				var d:DisplayObject = getChildAt(i);
				if (d is BodyMC) { bodyQueue.push(d as BodyMC); }
			}
			var shapeQueue:Vector.<AbstractShapeMC> = new Vector.<AbstractShapeMC>();
			// for each BodyMC, create a b2Body and add it to the world
			while (bodyQueue.length) {
				var bmc:BodyMC = bodyQueue.pop();
				var bodyDef:b2BodyDef = bmc.makeBodyDefFromMC( _pixelsPerMeter, 
											_baseLinearDamping, 
											_baseAngularDamping );
				var body:b2Body = world.CreateBody( bodyDef );
				bmc.body = body;
				// spider BodyMC's children for ShapeMCs, and add them to the body
				var nc:int = bmc.numChildren;
				for (i=0; i<nc; i++) {
					var c:DisplayObject = bmc.getChildAt(i);
					if (c is AbstractShapeMC) {
						var shapeMC:AbstractShapeMC = c as AbstractShapeMC;
						var shapeDef:b2ShapeDef = shapeMC.makeShapeDefFromMC( _pixelsPerMeter );
						var shape:b2Shape = body.CreateShape(shapeDef);
						shapeMC.shape = shape;
						shapeQueue.push( shapeMC );
					}
				}
				// finish the body
				body.SetMassFromShapes();
			}
			return shapeQueue;
		}
		
		
		
		
		/************************************************************************
		*	Add JointMCs to the world - 
		*	Look through child MCs for JointMC, and for each, make an appropriate 
		*	definition, create a joint, and add it to the world.
		*	Return a queue of all joints for post-processing.
		************************************************************************/
		private function addJointMCsToWorld():Vector.<AbstractJointMC> {
			// find all joints
			var jointQueue:Vector.<AbstractJointMC> = new Vector.<AbstractJointMC>;
			for (var i:int=0; i<numChildren; i++) {
				var d:DisplayObject = getChildAt(i);
				if (d is AbstractJointMC) { jointQueue.push(d as AbstractJointMC); }
			}
			// for each JointMC, create a joint and add it to the world
			// gears will be put in a queue for later, since they join other joints
			var gears:Vector.<GearJointMC> = new Vector.<GearJointMC>();
			for (i=0; i<jointQueue.length; i++) {
				var jmc:AbstractJointMC = jointQueue[i];
				if (jmc is MouseJointMC) { // handle separately
					setUpMouseJoints( jmc as MouseJointMC );
				} else if (jmc is GearJointMC) { // do these later
					gears.push( jmc as GearJointMC );
				} else {
					var jointDef:b2JointDef = jmc.makeJointDefFromMC( this, _pixelsPerMeter );
					if (jointDef != null) { 
						var jt:b2Joint = world.CreateJoint( jointDef );
						jmc.joint = jt;
					}
				}
			}
			// do gear joints last, to make sure the joints they attach to are already added
			while (gears.length) {
				var gmc:GearJointMC = gears.pop();
				var gearjointDef:b2JointDef = gmc.makeJointDefFromMC( this, _pixelsPerMeter );
				if (gearjointDef != null) { 
					var gjt:b2Joint = world.CreateJoint( gearjointDef );
					gmc.joint = gjt;
				}
			}
			// at this point, all gears are initialized and in jointQueue
			return jointQueue;
		}
		
		
		/************************************************************************
		*	Post-processing routine for joints and shapes. 
		*	This runs through all joints and shapes, removing all AnchorMCs.
		*	It also calls each Joint's initDraw method, for user-extended joints
		*	to initialize any drawing logic they might need.
		*	(Anchors are removed as a post-processing step because joints may  
		*	overlap a shape only by its anchors.)
		************************************************************************/
		private function postProcessShapesAndJoints( 
									shapes:Vector.<AbstractShapeMC>, 
									joints:Vector.<AbstractJointMC> ):void {
			while( joints.length ) {
				var joint:AbstractJointMC = joints.pop();
				joint.removeAnchorMCs();
				joint.initDraw( _pixelsPerMeter );
			}
			while( shapes.length ) {
				shapes.pop().removeAnchorMCs();
			}
		}
		
		
		/************************************************************************
		*	When a MouseJointMC is found, automatically add the joint on click.
		************************************************************************/
		private function setUpMouseJoints( j:MouseJointMC ):void {
			mouseJointMC = j;
			removeChild(mouseJointMC);
			if (mouseJointsInitted) { return; }
			addEventListener( MouseEvent.MOUSE_DOWN, mouseJointHandler, false, 0 , true );
			mouseJointsInitted = true;
		}
		
		private function mouseJointHandler( e:MouseEvent ):void {
			switch (e.type) {
				case MouseEvent.MOUSE_DOWN: 	createMouseJoint(); 	break;
				case MouseEvent.MOUSE_UP: 		destroyMouseJoint(); 	break;
			}
		}
		
		private function createMouseJoint():void {
			var jointDef:b2JointDef = mouseJointMC.makeJointDefFromMC( this, _pixelsPerMeter );
			if (jointDef != null) {
				var jt:b2Joint = world.CreateJoint( jointDef );
				mouseJointMC.joint = jt;
				addChild( mouseJointMC );
				updateMouseJoint();
				updateMouseJointOnRender = true;
				stage.addEventListener( MouseEvent.MOUSE_UP, mouseJointHandler, false, 0 , true );
			}
		}
		private function destroyMouseJoint():void {
			updateMouseJointOnRender = false;
			stage.removeEventListener( MouseEvent.MOUSE_UP, mouseJointHandler );
			removeChild( mouseJointMC );
			world.DestroyJoint( mouseJointMC.joint );
		}
		private function updateMouseJoint():void {
			var tgt:b2Vec2 = new b2Vec2( mouseX/_pixelsPerMeter, mouseY/_pixelsPerMeter );
			(mouseJointMC.joint as b2MouseJoint).SetTarget( tgt );
			mouseJointMC.draw( _pixelsPerMeter );
		}
		
		
		
		/************************************************************************
		*	Enter frame handler for stepping
		************************************************************************/
		private function onFrame(e:Event):void {
			if (_autoRender && isOnStage) {
				var t:int = getTimer();
				var delay:Number = t-lastRender + (t-lastFrame)/2;
				if( delay > _timestep*1000) {
					step(); 	// execute a timestep
					render(); 	// update the display
					lastRender = t;
				}
				lastFrame = t;
			}
		}
		
		/************************************************************************
		*	Executes a timestep in the Box2D world associated with this class, using
		*	the #timestep and #iterations properties. This is called automatically
		*	if you set #autoRender to true.
		************************************************************************/
		public function step():void {
			world.Step(_timestep, _iterations);
		}
		
		/************************************************************************
		*	<p>Updates the positions of all child BodyMC objects, and calls the 
		*	<code>draw()</code> method for all child joints.
		*	objects.
		*	</p><p>
		*	This is called automatically if you set #autoRender to true.</p>
		*	@see #autoRender
		*	@see b2IDE.Joints.AbstractJointMC#draw()
		************************************************************************/
		public function render():void {
			// Go through body list and update sprite positions/rotations
			var b:b2Body = world.m_bodyList;
			for (   ;  b;  b=b.m_next){
				if (b.m_userData is DisplayObject){
					b.m_userData.x = b.GetPosition().x * _pixelsPerMeter;
					b.m_userData.y = b.GetPosition().y * _pixelsPerMeter;
					b.m_userData.rotation = (b.GetAngle() * (180/Math.PI)) % 360;
				}
			}
			var j:b2Joint = world.m_jointList;
			for (   ;  j;  j=j.m_next){
				if (j.m_userData is AbstractJointMC){
					(j.m_userData as AbstractJointMC).draw( _pixelsPerMeter );
				}
			}
			if (updateMouseJointOnRender) {
				updateMouseJoint();
			}
		}
		
		
		
		
		/************************************************************************
		*	<p>Returns a reference to the BodyMC object associated with this Box2D 
		*	engine's ground body (creating it if necessary). All static b2IDE.Shapes.AbstractShape
		*	objects which are not initially contained in a BodyMC will be automatically
		*	reparented as children of this ground BodyMC.</p>
		*	@return A BodyMC representing the Box2D engine's ground body.
		************************************************************************/
		public function getGroundBodyMC(): BodyMC {
			if (groundBodyMC == null) {
				groundBodyMC = new BodyMC();
				addChild(groundBodyMC);
				var gb:b2Body = world.GetGroundBody();
				gb.m_userData = groundBodyMC;
			}
			return groundBodyMC;
		}
		
		
		
		
		
		//	Parameters inspectable from the IDE
		
		
		/************************************************************************
		*	The scaling factor for how many screen pixels represent one meter in the physics engine.
		*	Something between 20 and 100 is recommended.
		* 	@default 30
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Units
		************************************************************************/
		[Inspectable(defaultValue=30,type="Number",name="Pixels per meter")]
		public function set pixelsPerMeter( n:Number ):void {
			if (n<=0) { throw new ArgumentError("WorldMC: Invalid pixels per meter value "+n); }
			_pixelsPerMeter = n;
		}
		
		/************************************************************************
		*	The amount of time the simulation should advance each time <code>step()</code> is called.
		*	If you set this to 0, a timestep will be inferred from the framerate of
		*	your Flash movie.
		* 	@default 0
		*	@see #step()
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="Timestep (0:use FPS)")]
		public function set timestep( n:Number ):void {
			if (n<0) { throw new ArgumentError("WorldMC: Invalid timestep value "+n); }
			_timestep = n;
		}
		/** @private */
		public function get timestep():Number {
			return _timestep;
		}
		
		/************************************************************************
		*	How many iterations to run the physics engine's constraint solver 
		*	each timestep.
		*	@default 10
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Simulating_the_World_.28of_Box2D.29
		************************************************************************/
		[Inspectable(defaultValue=10,type="Number",name="Iterations")]
		public function set iterations( n:Number ):void {
			var i:int = Math.round(n);
			if (i<=0) { throw new ArgumentError("WorldMC: Invalid iterations value "+n); }
			_iterations = i;
		}
		
		/************************************************************************
		*	A world default for linear damping - if the bodies inside this
		*	world use <code>-1</code> for their linear damping, they will inherit this value.
		*	@default 0
		*	@see BodyMC.#linearDamping
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="damping, linear (base)")]
		public function set baseLinearDamping( n:Number ):void {
			if ( isNaN(n) || n<0 ) { throw new ArgumentError("WorldMC: Invalid damping "+n); }
			_baseLinearDamping = n;
		}
		
		/************************************************************************
		*	A world default for angular damping - if the bodies inside this
		*	world use <code>-1</code> for their angular damping, they will inherit this value.
		*	@default 0
		*	@see BodyMC.#angularDamping
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="damping, angular (base)")]
		public function set angularDamping( n:Number ):void {
			if ( isNaN(n) || n<0 ) { throw new ArgumentError("WorldMC: Invalid damping "+n); }
			_baseAngularDamping = n;
		}
		
		
		/************************************************************************
		*	Amount of gravity in the X direction, in meters/second<sup>2</sup>.
		*	@default 0
		************************************************************************/
		[Inspectable(defaultValue=0,type="Number",name="Gravity (X)")]
		public function set gravityX( n:Number ):void {
			if ( isNaN(n) ) { throw new ArgumentError("WorldMC: Invalid gravity "+n); }
			_gravityX = n;
		}
		
		/************************************************************************
		*	Amount of gravity in the Y direction, in meters/second<sup>2</sup>.
		*	@default 9.8
		************************************************************************/
		[Inspectable(defaultValue=9.8,type="Number",name="Gravity (Y)")]
		public function set gravityY( n:Number ):void {
			if ( isNaN(n) ) { throw new ArgumentError("WorldMC: Invalid gravity "+n); }
			_gravityY = n;
		}
		
		/************************************************************************
		*	Whether or not the bodies in this world can go to sleep.
		*	@default true
		*	@see http://www.box2d.org/wiki/index.php?title=Manual/AS3#Sleep_Parameters
		************************************************************************/
		[Inspectable(defaultValue=true,type="Boolean",name="do Sleep")]
		public function set doSleep( b:Boolean ):void {
			_doSleep = b;
		}
		
		/************************************************************************
		*	When true, this WorldMC will create an "enter frame" event listener,
		*	and automatically call the <code>step()</code> and <code>render()</code>
		*	methods each frame (or less frequently, depending on timestep).
		*	@default true
		*	@see #step()
		*	@see #render()
		************************************************************************/
		[Inspectable(defaultValue=true,type="Boolean",name="autoRender")]
		public function set autoRender( b:Boolean ):void {
			_autoRender = b;
		}
		
		
		
	} // class
	
} // package