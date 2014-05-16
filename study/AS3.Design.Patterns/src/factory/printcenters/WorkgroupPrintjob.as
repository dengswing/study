package factory.printcenters
{
	internal class WorkgroupPrintjob implements IPrintjob
	{
		public function start(fn:String):void
		{
			trace("Printing '" + fn + "' to workgroup printer");
		}
	}
}