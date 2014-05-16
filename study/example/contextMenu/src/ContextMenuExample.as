package {
	import flash.text.TextFieldAutoSize;
    import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;
    import flash.ui.ContextMenuBuiltInItems;
    import flash.events.ContextMenuEvent;
    import flash.display.Sprite;
    import flash.display.Shape;
    import flash.text.TextField;

    public class ContextMenuExample extends Sprite {
        private var myContextMenu:ContextMenu;
        private var menuLabel:String = "Reverse Colors";
        private var textLabel:String = "Right Click";
        private var redRectangle:Sprite;
        private var label:TextField;
        private var size:uint = 100;
        private var black:uint = 0x000000;
        private var red:uint = 0xFF0000;

        public function ContextMenuExample() {
            myContextMenu = new ContextMenu();
            removeDefaultItems();
            addCustomMenuItems();
            myContextMenu.addEventListener(ContextMenuEvent.MENU_SELECT, menuSelectHandler);

            addChildren();
            redRectangle.contextMenu = myContextMenu;
        }

        private function addChildren():void {
            redRectangle = new Sprite();
            redRectangle.graphics.beginFill(red);
            redRectangle.graphics.drawRect(0, 0, size, size);
            addChild(redRectangle);
            redRectangle.x = size;
            redRectangle.y = size;
            label = createLabel();
            redRectangle.addChild(label);
        }

        private function removeDefaultItems():void {
            myContextMenu.hideBuiltInItems();
            var defaultItems:ContextMenuBuiltInItems = myContextMenu.builtInItems;
            defaultItems.print = true;
        }

        private function addCustomMenuItems():void {
            var item:ContextMenuItem = new ContextMenuItem(menuLabel);
            myContextMenu.customItems.push(item);
            item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
        }

        private function menuSelectHandler(event:ContextMenuEvent):void {
            trace("menuSelectHandler: " + event);
        }

        private function menuItemSelectHandler(event:ContextMenuEvent):void {
            trace("menuItemSelectHandler: " + event);
            var textColor:uint = (label.textColor == black) ? red : black;
            var bgColor:uint = (label.textColor == black) ? black : red;
            redRectangle.graphics.clear();
            redRectangle.graphics.beginFill(bgColor);
            redRectangle.graphics.drawRect(0, 0, size, size);
            label.textColor = textColor;
        }

        private function createLabel():TextField {
            var txtField:TextField = new TextField();
            txtField.text = textLabel;
			txtField.autoSize = TextFieldAutoSize.LEFT;
            return txtField;
        }
    }
}