package cn.riahome.guestbook.puremvc.model.vo
{
	[Bindable]
	public class TopicVO
	{
		public var id:uint;
		public var addTime:String;
		public var username:String;
		public var content:String;
		
		public function TopicVO( id:uint, addTime:String, username:String, content:String)
		{
			this.id = id;
			this.addTime = addTime;
			this.username = username;
			this.content = content;
		}

	}
}