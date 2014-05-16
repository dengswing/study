package factory.printcenters
{
	public class LowVolPrintCenter extends PrintCenter
	{
		override protected function createPrintjob( ):IPrintjob
		{
			trace("Creating new printjob for the inkjet printer");
			return new InkjetPrintjob( );
		}
	}
}