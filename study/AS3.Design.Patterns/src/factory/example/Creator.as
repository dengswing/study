package factory.example
{
	import flash.errors.IllegalOperationError;
	// ABSTRACT Class (should be subclassed and not instantiated)
	
	public class Creator
	{
		public function doStuff( ):void
		{
			var product:IProduct = this.factoryMethod( );
			product.manipulate( );
		}
		
		// ABSTRACT Method (must be overridden in a subclass)
		protected function factoryMethod( ):IProduct
		{
			throw new IllegalOperationError("Abstract method:must be overridden in a subclass");
			return null;
		}
	}
}