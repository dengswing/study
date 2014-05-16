package
{
	import com.adobe.images.JPGEncoder;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import nochump.util.zip.ZipEntry;
	import nochump.util.zip.ZipFile;
	import nochump.util.zip.ZipOutput;

	public class Main extends Sprite
	{
	   private var myFileReference:FileReference;
	   public function Main() {
		 init();
		}
	  
	   private function init():void 
	   {
		   var open_btn:Sprite = new Sprite();
		   open_btn.graphics.beginFill(0x333333, .5);
		   open_btn.graphics.drawRect(0, 0, 100, 30);
		   open_btn.graphics.endFill();
		   open_btn.x = 100;
		   open_btn.y = 100;
		   
		   
		   var save_btn:Sprite = new Sprite();
		   save_btn.graphics.beginFill(0x333333, .5);
		   save_btn.graphics.drawRect(0, 0, 100, 30);
		   save_btn.graphics.endFill();
		   save_btn.x = 500;
		   save_btn.y = 100;
		   
		   addChild(open_btn);
		   addChild(save_btn);
			 open_btn.addEventListener(MouseEvent.CLICK, openHandler);
			 save_btn.addEventListener(MouseEvent.CLICK, saveHandler);
		   
		}
	  
	   private function saveHandler(e:MouseEvent):void {
		 saveZip();
		}
	  
	   private function openHandler(e:MouseEvent):void {
		 readZip();
		}
	   //压zip
	   private function saveZip():void {
		 var fileName:String = "helloworld.txt";
		 var fileName2:String = "image.jpg";
		 var fileData:ByteArray = new ByteArray();
		 fileData.writeUTFBytes("Hello World!中文");
		 var zipOut:ZipOutput = new ZipOutput();
		// Add entry to zip
		 var ze:ZipEntry = new ZipEntry(fileName);//这是一个文件
		 var ze2:ZipEntry = new ZipEntry(fileName2);//这是一个文件
		//
		//var jpg = new bmd(100, 100);
		 var jpg:BitmapData = new BitmapData(stage.width, stage.height);
		 jpg.draw(stage);
		 var je:JPGEncoder = new JPGEncoder();
		 var pixels:ByteArray = je.encode(jpg);
		 zipOut.putNextEntry(ze2);
		 zipOut.write(pixels);
		//zipOut.closeEntry();
		//
		 zipOut.putNextEntry(ze);
		 zipOut.write(fileData);
		 zipOut.closeEntry();
		// end the zip
		 zipOut.finish();
		// access the zip data
		 var zipData:ByteArray = zipOut.byteArray;
		 myFileReference = new FileReference();
		 myFileReference.save(zipData, "qq.zip");
	   
		}
	  
	   private function onCom(e:Event):void {
		
		}
	   //解zip
	   private function readZip():void{
		 var urlStream:URLStream = new URLStream();
		 urlStream.addEventListener(Event.COMPLETE, completeHandler);
		 urlStream.load(new URLRequest( "bin.zip" ));
		}
	  
	   private function completeHandler(event:Event):void {
		 var datastream:URLStream = URLStream(event.target);
		 var kmzFile:ZipFile = new ZipFile(datastream);
		//totalMaterials = kmzFile.entries.join("@").split(".jpg").length;
		
		for(var i:int = 0; i < kmzFile.entries.length; i++) {
		  var entry:ZipEntry = kmzFile.entries[i];
		  var data:ByteArray = kmzFile.getInput(entry);
		  
		  trace("entry.name",entry.name);
		 if((entry.name.indexOf(".jpg")>-1 || entry.name.indexOf(".png")>-1)) {
		   var _loader : Loader = new Loader();
		   _loader.name = entry.name.split("/").reverse()[0].split(".")[0];
		   _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadBitmapCompleteHandler);
		   _loader.loadBytes(data);
		  }else if (entry.name.indexOf(".txt") > -1) {
			
		  }
		 };
		};
	  
	   private function loadBitmapCompleteHandler(e:Event):void {
		 var loader:Loader = Loader(e.target.loader);
		 var bitmap:Bitmap = Bitmap(loader.content);
		 addChild(bitmap);
		
		}
	}
}