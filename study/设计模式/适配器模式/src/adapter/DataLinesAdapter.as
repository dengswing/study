package  adapter
{
	import inf.IDataLines;
	import lines.DataLines;
	
	/**
	 * @author dengswing
	 * @date 2012-2-17 13:51
	 */
	public class DataLinesAdapter extends DataLines implements IDataLines
	{
		
		/**
		 * 数据线适配器
		 */
		public function DataLinesAdapter() 
		{
			
			
		}
		
		/* INTERFACE IDataLines */
		
		public function linesTwoPointFive():void
		{
			//处理
			
			super.linesThreePointFive();
		}
		
	}

}