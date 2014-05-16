package factory.printcenters
{
	public class HighVolPrintCenter extends PrintCenter
	{
		override protected function createPrintjob( ):IPrintjob
		{
			trace("Creating new printjob for the workgropup printer");
			return new WorkgroupPrintjob( );
		}
	}
}