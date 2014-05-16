package factory.printcenters
{
	internal class InkjetPrintjob implements IPrintjob
	{
		public function start(fn:String):void
		{
			trace("Printing '" + fn + "' to inkjet printer");
		}
	}
}