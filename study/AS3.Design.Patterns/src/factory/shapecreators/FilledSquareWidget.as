package factory.shapecreators {
	internal class FilledSquareWidget extends ShapeWidget {
		override internal function drawWidget( ):void
		{
			graphics.beginFill(0xFF00FF);
			graphics.drawRect(-10, -10, 20, 20);
			graphics.endFill( );
		}
	}
}