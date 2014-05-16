package factory.shapecreators
{
	public class FilledShapeCreator extends ShapeCreator
	{
		public static const CIRCLE :uint = 0;
		public static const SQUARE :uint = 1;
		override protected function createShape(cType:uint):ShapeWidget
		{
			if (cType == CIRCLE)
			{
				trace("Creating new filled circle shape");
				return new FilledCircleWidget( );
			} else if (cType == SQUARE) {
				trace("Creating new filled square shape");
				return new FilledSquareWidget( );
			} else {
				throw new Error("Invalid kind of shape specified");
				return null;
			}
		}
	}
}