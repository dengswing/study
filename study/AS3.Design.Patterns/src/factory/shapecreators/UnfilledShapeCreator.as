package factory.shapecreators
{
	public class UnfilledShapeCreator extends ShapeCreator
	{
		public static const CIRCLE :uint = 0;
		public static const SQUARE :uint = 1;
		
		override protected function createShape(cType:uint):ShapeWidget
		{
			if (cType == CIRCLE)
			{
				trace("Creating new circle shape");
				return new CircleWidget( );
			} else if (cType == SQUARE) {
				trace("Creating new square shape");
				return new SquareWidget( );
			} else {
				throw new Error("Invalid kind of shape specified");
				return null;
			}
			}
		}
}
