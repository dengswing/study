package b2IDE.Shapes {
	
	import flash.display.*;
	
	/****************************************************************************
	*	
	*	<p>MCs extending this class should be placed into ShapeMCs or JointMCs to define 
	*	their geometry. See each shape or joint for the details of how many AnchorMCs to use,
	*	and what they signify.
	*	</p><p>
	*	AnchorMC has no significance to the Box2D engine itself. After the shape and joint 
	*	MCs are processed, b2IDE will remove the anchor MCs extending or implementing this class 
	*	from the display list.</p>
	*	
	****************************************************************************/
	
	public class AnchorMC extends MovieClip {
		
		
		
		/************************************************************************
		*	This class exists for type reasons, and contains no code.
		************************************************************************/
		public function AnchorMC() {
			//
		}
		
		
		
	} // class
	
} // package