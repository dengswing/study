package  
{
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.utils.ByteArray;
	import nochump.util.zip.ZipEntry;
	import nochump.util.zip.ZipOutput;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class ExportImages extends Sprite
	{
		private var rolePutOn:RolePutOn;
		private var myFileReferenceList:CustomFileReferenceList;
		private var zipOut:ZipOutput;
		
		/**
		 * 导图
		 */
		public function ExportImages() 
		{
			rolePutOn = new RolePutOn();			
			myFileReferenceList = new CustomFileReferenceList();
			zipOut = new ZipOutput();
			
			this.stage.addEventListener(MouseEvent.CLICK,browse);
		}
		
		/**
		 * 浏览图片
		 */
		public function browse(e:Event):void
		{
			myFileReferenceList.browse(myFileReferenceList.getTypes());
			myFileReferenceList.addEventListener(CustomEvent.LOAD_FINISH, completeHandler);
		}

        private function completeHandler(event:Event):void
		{			
			var file:FileReference = event.target as FileReference;
			if (event is CustomEvent) file = CustomEvent(event).params as FileReference;
			var uLoaderSwf:LoaderSwf = new LoaderSwf();
			uLoaderSwf.loadingSwf(file.data, loaderFinish);
			function loaderFinish():void
			{
				var con:Sprite = uLoaderSwf.getContent as Sprite;
				var reg:RegExp = /\.\w+$/;
				var name:String = file.name;
				saveZip(rolePutOn.getAllLink(con), name.replace(reg, ""));
			}			
        }
		
		//压zip
	    private function saveZip(aList:Array,name:String):void
		{
			if (!aList || aList.length <= 0) return;
				
			for (var i:int = 0; i < aList.length; i += 1)
			{
				var con:Sprite = aList[i]["con"] as Sprite;
				var rec:Rectangle = aList[i]["info"] as Rectangle;
				var bitmapdata:BitmapData = drawBitmap(con, rec);
				var bitmapdata2:BitmapData = drawBitmap(con, rec, true);
				
				//打包
				var fileName:String = con.name +name;
				packagedData(fileName + ".png", bitmapdata);
				packagedData(fileName + "-hd.png", bitmapdata2);
			}
			 
			myFileReferenceList.current += 1;
			if (!myFileReferenceList.isLoadAllFinish) return;
			
			zipOut.closeEntry();
			zipOut.finish();
			// access the zip data
			 var zipData:ByteArray = zipOut.byteArray;
			 var tmpFileReference:FileReference = new FileReference();
			 tmpFileReference.save(zipData, "save.zip");
		}
		
		/**
		 * 打包
		 * @param	fileName
		 * @param	bitmapdata
		 */
		private function packagedData(fileName:String,bitmapdata:BitmapData):void
		{
			var ze:ZipEntry = new ZipEntry(fileName);//这是一个文件
			var pixels:ByteArray = PNGEncoder.encode(bitmapdata);				
			zipOut.putNextEntry(ze);
			zipOut.write(pixels);
		}
		
		/**
		 * 
		 * @param	con
		 * @param	rec
		 * @param	isDoubleSize
		 * @return
		 */
		private function drawBitmap(con:Sprite, rec:Rectangle, isDoubleSize:Boolean = false):BitmapData	
		{
			rec = rec.clone();
			if (isDoubleSize)
			{ 
				con.scaleX = con.scaleY = 2;
				rec.width *= 2;
				rec.height *= 2;
				rec.x *= 2;
				rec.y *= 2;
			}
			
			var rect:Rectangle = con.getBounds(con);
			var bitmapdata:BitmapData = new BitmapData(rec.width, rec.height, true, 0);
			var matrix:Matrix = new Matrix();
			matrix.scale(con.scaleX, con.scaleY);
			matrix.translate(Number((rec.x).toFixed(1)), Number((rec.y).toFixed(1)));
			bitmapdata.draw(con, matrix);
			return bitmapdata;
		}
		
	}

}


import flash.events.*;
import flash.net.FileReference;
import flash.net.FileReferenceList;
import flash.net.FileFilter;
import flash.net.URLRequest;
 
class CustomFileReferenceList extends FileReferenceList 
{	
    private var pendingFiles:Array;
	private var count:int;
	public var current:int;
	
    public function CustomFileReferenceList() 
	{
        initializeListListeners();
    }

    private function initializeListListeners():void 
	{
        addEventListener(Event.SELECT, selectHandler);
    }

    public function getTypes():Array {
        var allTypes:Array = new Array();
        allTypes.push(getImageTypeFilter());
        return allTypes;
    }
 
    private function getImageTypeFilter():FileFilter 
	{
        return new FileFilter("flash (*.swf)", "*.swf");
    }
 
    private function doOnComplete(file:FileReference):void 
	{
		dispatchEvent(new CustomEvent(CustomEvent.LOAD_FINISH, file));
    }
 
    private function addPendingFile(file:FileReference):void
	{
        pendingFiles.push(file); 
		file.addEventListener(Event.COMPLETE, completeHandler);
		file.load();
    }
 
    private function removePendingFile(file:FileReference):void 
	{
        for (var i:uint; i < pendingFiles.length; i++)
		{
            if (pendingFiles[i].name == file.name)
			{
                pendingFiles.splice(i, 1);
				doOnComplete(file);
                return;
            }
        }
    }
 
    private function selectHandler(event:Event):void
	{
        trace("selectHandler: " + fileList.length + " files");
		count = fileList.length;
		current = 0;
        pendingFiles = new Array();
        var file:FileReference;
        for (var i:uint = 0; i < fileList.length; i++) 
		{
            file = FileReference(fileList[i]);
            addPendingFile(file);
        }
    } 
 
    private function completeHandler(event:Event):void
	{
        var file:FileReference = FileReference(event.target);
        removePendingFile(file);
    } 
	
	/**
	 * 是否加载完所有的
	 */
	public function get isLoadAllFinish():Boolean
	{
		return current >= count;
	}
}

class CustomEvent extends Event
{ 
	public static const LOAD_FINISH:String = "load_finish";
	public var params:*;
	public function CustomEvent(type:String, params:*)	
	{
		this.params = params;
		super(type, false, false);
	};
};