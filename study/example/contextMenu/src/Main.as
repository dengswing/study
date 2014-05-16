package {
    import flash.ui.ContextMenu;
    import flash.events.ContextMenuEvent;
    import flash.display.Sprite;

    public class Main extends Sprite {
        public function Main() {
            var myContextMenu:ContextMenu = new ContextMenu();
            myContextMenu.clipboardMenu = true;
            myContextMenu.addEventListener(ContextMenuEvent.MENU_SELECT, menuSelectHandler);
            var rc:Sprite = new Sprite();
            rc.graphics.beginFill(0xDDDDDD);
            rc.graphics.drawRect(0,0,100,30);
            addChild(rc);
            rc.contextMenu = myContextMenu;
			
			trace("向城路29号爵士大夏A31A!");
        }
		
        private function menuSelectHandler(event:ContextMenuEvent):void {
            event.contextMenuOwner.contextMenu.clipboardItems.copy = true;
            event.contextMenuOwner.contextMenu.clipboardItems.paste = true;
			event.contextMenuOwner.contextMenu.clipboardItems.clear = true;			
        }
    }
}