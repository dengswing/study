package invoke 
{
	import inf.IBook;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class RsProxy implements IBook
	{
		private var rs:RealSubject;
		
		/**
		 * 代理
		 */
		public function RsProxy() 
		{
			
		}
		
		/* INTERFACE inf.IBook */
		
		public function saleBooks():void 
		{
			discount();
			if (!rs) rs = new RealSubject();
			rs.saleBooks();
			invoice();
		}
		
		private function discount():void 
		{
			trace("打折");
		}
		
		private function invoice():void
		{
			trace("发票");
		}
	}

}