package factory.printcenters 
{
	import flash.errors.IllegalOperationError;
	
	// ABSTRACT Class (should be subclassed and not instantiated)
	public class PrintCenter
	{
		public function print(fn:String):void
		{
			var printjob:IPrintjob = this.createPrintjob( );
			printjob.start(fn);
		}
		
		// ABSTRACT Method (must be overridden in a subclass)
		protected function createPrintjob( ):IPrintjob
		{
			throw new IllegalOperationError("Abstract method: must be overridden in a subclass");
			return null;
		}
	}
}