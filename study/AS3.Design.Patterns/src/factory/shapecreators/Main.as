package factory.shapecreators 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Main extends Sprite
	{
		
		public function Main() 
		{
			// instantiate concrete shape creators
			var unfilledShapeCreator:ShapeCreator = new UnfilledShapeCreator( );
			var filledShapeCreator:ShapeCreator = new FilledShapeCreator( );
			
			
			// draw unfilled shapes
			unfilledShapeCreator.draw(UnfilledShapeCreator.CIRCLE, this.stage, 50, 75);
			unfilledShapeCreator.draw(UnfilledShapeCreator.SQUARE, this.stage, 150, 75);
			
			// draw filled shapes
			filledShapeCreator.draw(FilledShapeCreator.CIRCLE, this.stage, 50, 200);
			filledShapeCreator.draw(FilledShapeCreator.SQUARE, this.stage, 150, 200);
		}
		
	}

}