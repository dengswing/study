package factory.shapecreators {
	internal class FilledCircleWidget extends ShapeWidget {
		override internal function drawWidget( ):void
		{
			graphics.beginFill(0xFFFF00);
			graphics.drawCircle(0, 0, 10);
			graphics.endFill( );
		}
	}
}