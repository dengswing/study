package factory.shapecreators {
	internal class CircleWidget extends ShapeWidget {
		override internal function drawWidget( ):void
		{
			graphics.lineStyle(3, 0xFFFF00);
			graphics.drawCircle(0, 0, 10);
		}
	}
}