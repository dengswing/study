package  adapter
{
	import inf.IDataLines;
	import lines.DataLines;
	
	/**
	 * @author dengswing
	 * @date 2012-2-17 13:52
	 */
	public class DataLinesAdapterB implements IDataLines
	{
		private var _dataLines:DataLines;
		
		/**
		 * 数据线适配器 (注入方法)
		 */
		public function DataLinesAdapterB(dataLines:DataLines) 
		{
			_dataLines = dataLines;
		}
		
		/* INTERFACE IDataLines */
		
		public function linesTwoPointFive():void
		{
			_dataLines.linesThreePointFive();
		}
		
	}

}