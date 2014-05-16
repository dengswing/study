package b2IDE {
	
	import flash.display.*;
	import flash.geom.*;
	import b2IDE.*;
	
	/****************************************************************************
	*	
	*	<p>An author-time container for packaging and re-using b2IDE contents.
	*	The container has no physical significance, it merely lets you combine bodies,
	*	shapes, and joints into a single Movie Clip that you can edit sepearately and reuse elsewhere.
	*	</p><p>
	*	At runtime, the ContainerMC itself will be removed, and all its contents will be
	*	moved to where the container was, retaining any transformations (including those of 
	*	the container) and their layering order. Containers can be nested as deeply as
	*	you like. (Flash won't let you put a clip inside itself, so to nest containers you'll
	*	need two or more different clips that extend ContainerMC.)
	*	</p>
	*	
	****************************************************************************/
	
	public class ContainerMC extends AbstractWorldObject {
		
		
		
		/************************************************************************
		*	Constructor
		************************************************************************/
		public function ContainerMC() {
			//
		}
		
		/************************************************************************
		*	Removes the container from its parent, and moves its children into
		*	its parent (retaining their transform and depth order).
		************************************************************************/
		public function replaceSelfWithChildren():void {
			var outerMatrix:Matrix = transform.matrix;
			var loc:int = parent.getChildIndex(this)
			while(numChildren) {
				var child:DisplayObject = getChildAt(numChildren-1);
				removeChild( child );
				var childMatrix:Matrix = child.transform.matrix;
				childMatrix.concat( outerMatrix );
				child.transform.matrix = childMatrix;
				parent.addChildAt( child, loc );
			}
			parent.removeChild( this );
		}
		
		
		
		
		
	} // class
	
} // package