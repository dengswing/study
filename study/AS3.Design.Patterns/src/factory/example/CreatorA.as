package factory.example
{
	public class CreatorA extends Creator
	{
		override protected function factoryMethod( ):IProduct
		{
			trace("Creating product 1");
			return new Product1( ); // returns concrete product			
		}
	}
}