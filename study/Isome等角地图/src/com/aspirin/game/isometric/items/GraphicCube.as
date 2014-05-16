package com.aspirin.game.isometric.items {
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;		

	/**
	 * @author ashi
	 */
	public class GraphicCube extends Item {
		private var graphicClass : Class;
		
		public function GraphicCube(symbol : String) {
			switch(symbol)
			{
				case "1":
				cols = 1;
				rows = 3;
				graphicClass = getDefinitionByName("Main_BlueCube_1") as Class;
				break;
				
				case "2":
				cols = 3;
				rows = 1;
				graphicClass = getDefinitionByName("Main_BlueCube_2") as Class;
				break;
				
				case "3":
				cols = 1;
				rows = 1;
				graphicClass = getDefinitionByName("Main_BlueCube_3") as Class;
				//graphicClass = ItemAssets.BlueCube_3 as Class;
				//graphicClass = getDefinitionByName("ItemAssets_BlueCube_3") as Class;
				break;
				
				case "4":
				cols = 1;
				rows = 1;
				graphicClass = getDefinitionByName("Main_Flower_1") as Class;
				break;
				
				case "5":
				cols = 1;
				rows = 1;
				graphicClass = getDefinitionByName("Main_Flower_2") as Class;
				break;
			}
			
			super(symbol, cols, rows);
		}
		
		public override function draw() : void
		{
			var graphic : Sprite = new graphicClass() as Sprite;
			addChild(graphic);
		}
		
	}
}
