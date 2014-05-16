package com.normsoule.pixelblitz
{
	import com.normsoule.pixelblitz.core.BitmapDataCollection;
	import com.normsoule.pixelblitz.core.Camera2D;
	
	/**
	* The PixelBlitz class contains global properties and settings.
	*/
	public final class PixelBlitz
	{
		/**
		* Enables engine name to be retrieved at runtime or when viewing a decompiled swf.
		*/
		public static var NAME     :String = "PixelBlitz";
	
		/**
		* Enables version to be retrieved at runtime or when viewing a decompiled swf.
		*/
		public static var VERSION  :String = "Public Alpha 1.0";
	
		/**
		* Enables version date to be retrieved at runtime or when viewing a decompiled swf.
		*/
		public static var DATE     :String = "18.08.08";
	
		/**
		* Enables copyright information to be retrieved at runtime or when viewing a decompiled swf.
		*/
		public static var AUTHOR   :String = "(c) 2008 Copyright Norm Soule | www.normsoule.com";
	
	
		/**
		 * @see Camera2D
		 */
		public static var camera2D:Camera2D = Camera2D.getInstance();
		/**
		 * @see BitmapDataCollection
		 */
		public static var bmdCollection:BitmapDataCollection = BitmapDataCollection.getInstance();

	}
}