package 
{
	import com.maclema.mysql.events.MySqlEvent;
	import com.maclema.mysql.Field;
	import flash.display.Sprite;
	import flash.events.Event;	
	import com.maclema.mysql.Statement;
	import com.maclema.mysql.Connection;
	import com.maclema.mysql.ResultSet;
	import com.maclema.mysql.MySqlToken;

	/**
	 * ...
	 * @author dengSwing
	 */
	public class Main extends Sprite 
	{
		
		private var con:Connection;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			onCreationComplete();
			
			trace("aa")
		}
		
		private function onCreationComplete():void {
			con = new Connection("192.168.20.24", 3306, "billiards", "billiards", "pets");
			con.addEventListener(Event.CONNECT, handleConnected);
			con.connect();
			
			trace("b")
		}

		private function handleConnected(e:Event):void {
			trace("c")
			var st:Statement = con.createStatement();
			var token:MySqlToken = st.executeQuery("SELECT * FROM p_items");
			token.addEventListener(MySqlEvent.RESULT, function(e:MySqlEvent):void {
																result(e.resultSet);																
														   });
														   
		}		
		private function result(data:Object):void {
			var rs:ResultSet;
			rs = ResultSet(data);			
			trace("Found " + rs.size() + " employees!");
			trace("Found " + 
			Field(rs.getColumns()[1]).getRealName() + " employees!");
			
			var baseShopData:BaseShopData;			
			for (var i:* in rs.getRows()) {		
				var tmpObj:Object = rs.getRows()[i];				
				baseShopData = new BaseShopData(tmpObj[Field(rs.getColumns()[0]).getRealName()],				
												tmpObj[Field(rs.getColumns()[1]).getRealName()],
												tmpObj[Field(rs.getColumns()[2]).getRealName()],
												tmpObj[Field(rs.getColumns()[3]).getRealName()],
												tmpObj[Field(rs.getColumns()[4]).getRealName()],
												tmpObj[Field(rs.getColumns()[5]).getRealName()],
												tmpObj[Field(rs.getColumns()[6]).getRealName()],
												tmpObj[Field(rs.getColumns()[7]).getRealName()],
												tmpObj[Field(rs.getColumns()[8]).getRealName()],
												tmpObj[Field(rs.getColumns()[9]).getRealName()],
												tmpObj[Field(rs.getColumns()[10]).getRealName()],
												tmpObj[Field(rs.getColumns()[11]).getRealName()],
												tmpObj[Field(rs.getColumns()[12]).getRealName()],
												tmpObj[Field(rs.getColumns()[13]).getRealName()]);				
				trace(baseShopData.id, baseShopData.name);
				
			}
			
		}
		

		private function fault(info:Object, token:Object):void {
			trace(token.info + " Error: " + info);
		}
		
	}
	
}