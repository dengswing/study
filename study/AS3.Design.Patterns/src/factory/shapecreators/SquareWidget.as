package factory.shapecreators {
	
	internal class SquareWidget extends ShapeWidget {
		override internal function drawWidget( ):void
		{
			graphics.lineStyle(3, 0xFF00FF);
			graphics.drawRect(-10, -10, 20, 20);
		}
	}
}