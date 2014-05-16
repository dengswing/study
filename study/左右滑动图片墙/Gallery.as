package 
{
	import fl.lang.Locale;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author winky
	 */
	public class Gallery extends BasicGallery
	{

		public function Gallery()
		{
			super();
			loadXML("wordHouse/all.xml");
			this.rightBtn.addEventListener(MouseEvent.CLICK, leftHandler);
			this.leftBtn.addEventListener(MouseEvent.CLICK, rightHandler);
			this.rightBtn.buttonMode = true;
			this.leftBtn.buttonMode = true;
		}
		
			
		override protected function parseXML(xml:XML):XMLList
		{
			var imageXmlList:XMLList = xml.menu;
			for (var i:int = 0; i <imageXmlList.length(); i++)
			{
				var imageVo:ImageVo = new ImageVo();
				imageVo.imageUrl = imageXmlList[i]. @imageUrl;
				imageVo.imageLink = imageXmlList[i]. @url;
				imageVo.title =imageXmlList[i]. @title;
				imageVo.imageName = imageXmlList[i].imageName;
				imageVoAry.push(imageVo);
			}
			return imageXmlList;
		}
		
		override public function showTitleTxt(_title:String):void
		{
			trace("-------------------------",_title)
			titleTxt.text = _title;
		}
		
		override protected function showContentTxt(obj:Object):void
		{
			showTxt.text = obj.imageLink;
		}
	}

}

class ImageVo
{
	public var title:String;
	
	public var imageUrl:String;

	public var imageLink:String;

	public var imageName:String;
}