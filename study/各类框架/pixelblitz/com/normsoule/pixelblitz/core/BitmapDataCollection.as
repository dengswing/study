package com.normsoule.pixelblitz.core
{
	import flash.display.BitmapData;
	
	/**
	 * The BitmapDataCollection class creates a collection object that stores and manages all BitmapData objects.
	 * <p>
	 * The methods of this class can be used to enforce that no duplicate BitmapData objects will be created. 
	 * This class is used internally to ensure that no matter how many instances of a renderable object 
	 * exist there will be only one BitmapData object.
	 * </p>
	 */
	public final class BitmapDataCollection
	{
		/**
		 * @private
		 */
		public static var instance:BitmapDataCollection;
		/**
		 * @private
		 */
		public static var allowInstance:Boolean;
		
		/**
		 * The object that stores the BitmapData objects that are added to the collection.
		 */
		public var collection:Object = {};
		
		/**
		 * @private
		 */
		public function BitmapDataCollection()
		{
			// singleton
			if ( !allowInstance )
			{
				throw new Error( "BitmapDataCollection is a singleton. " + 
								 "Use the getInstance method to create an instance."
								);
			}
		}
		
		/**
		 * Creates the singleton BitmapDataCollection instance.
		 * 
		 * @return The singleton instance of BitmapDataCollection. 
		 */
		public static function getInstance():BitmapDataCollection
		{
			if ( !instance )
			{
				allowInstance = true;
				instance = new BitmapDataCollection();
				allowInstance = false;
			}
			return instance;
		}
		
		/**
		 * Adds a BitmapData object to the collection with the supplied String identifier.
		 * 
		 * @param id The unique identifier to assign to the BitmapData object once added to the collection.
		 * @param bitmapData The BitmapData object to add to the collection.
		 * @return A reference to the BitmapData object within the collection.
		 */
		public function addBitmapData( id:String, bitmapData:BitmapData ):BitmapData
		{	
			collection[ id ] = bitmapData;
			return collection[ id ];
		}
		
		/**
		 * Searches the collection for the supplied String identifier.
		 * 
		 * @param item The String identifier to search for within the collection.
		 * @return A boolean value indicating if the item exists within the collection.
		 */
		public function search( item:String ):Boolean
		{
			if ( collection[ item ] )
			{
				return true;
			}
			return false;
		}
		
		/**
		 * Removes all BitmapData objects within the collection.
		 * <p>
		 * <b>Note: </b>Every BitmapData object becomes <code>null</code> once removed and is no longer available in memory.
		 * </p>
		 */
		public function dispose():void
		{
			for each ( var p:BitmapData in collection )
			{
				p.dispose();
				p = null;
			}
			collection = {};
		}
		
		/**
		 * Removes the suplied BitmapData object from the collection.
		 * <p>
		 * <b>Note: </b>The BitmapData object becomes <code>null</code> once removed and is no longer available in memory.
		 * </p>
		 * @param bitmapData The BitmapData object to remove from the collection.
		 * @return A boolean value indicating if the BitmapData object was removed from the collection.
		 */
		public function removeBitmapData( bitmapData:BitmapData ):Boolean
		{
			for each ( var p:BitmapData in collection )
			{
				if ( p === bitmapData )
				{
					p.dispose();
					p = null;
					return true;
				}
			}
			// It is not available to remove.
			return false;
		}

	}
}