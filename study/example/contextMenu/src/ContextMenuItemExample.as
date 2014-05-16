package  
{
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class ContextMenuItemExample extends Sprite
	{
		
		public function ContextMenuItemExample() 
		{
			init();
		}
		
	    private function init():void {
			var myContextMenu:ContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			
			var menuItem_1:ContextMenuItem = new ContextMenuItem("deng", false);
			var menuItem_2:ContextMenuItem = new ContextMenuItem("swing", false);
			var menuItem_3:ContextMenuItem = new ContextMenuItem("water", true);
			
			myContextMenu.customItems = [menuItem_1, menuItem_2, menuItem_3];
		
			menuItem_1.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuHandler);
			menuItem_2.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuHandler);
			menuItem_3.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuHandler);
			
			this.contextMenu = myContextMenu;
			
			myContextMenu.addEventListener(ContextMenuEvent.MENU_SELECT, menuHandler_1);
		}
		
		private function menuHandler(contextMenuEvt:ContextMenuEvent):void {			
			var menuItem:ContextMenuItem = contextMenuEvt.currentTarget as ContextMenuItem;			
			
			trace(menuItem.caption);
		}
		
		private function menuHandler_1(contextMenuEvt:ContextMenuEvent):void {			
			var menu:ContextMenu= contextMenuEvt.currentTarget as ContextMenu;			
			
			trace(menu.link);
		}
		
	}

}