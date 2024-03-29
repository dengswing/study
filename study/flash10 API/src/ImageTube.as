﻿package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.TriangleCulling
	[SWF(backgroundColor = 0xffffff)]
	
	public class ImageTube extends Sprite
	{
		[Embed(source="image.jpg")]
		
		private var ImageClass:Class;
		private var vertices:Vector.<Number> = new Vector.<Number>();
		private var indices:Vector.<int> = new Vector.<int>();
		private var uvtData:Vector.<Number> = new Vector.<Number>();
		private var bitmap:Bitmap;
		private var sprite:Sprite;
		private var res:Number = 60;
		private var cols:int = 20;
		private var rows:int = 6;
		private var centerZ:int = 200;
		private var focalLength:Number = 250;
		private var radius:Number = 200;
		
		public function ImageTube()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			sprite = new Sprite();
			sprite.x = 400;
			sprite.y = 400;
			addChild(sprite);
			bitmap= new ImageClass() as Bitmap;
			makeTriangles();
			draw();
		}
		
		private function draw():void
		{
			sprite.graphics.beginBitmapFill(bitmap.bitmapData);
			sprite.graphics.drawTriangles(vertices, indices, uvtData, TriangleCulling.NEGATIVE);
			sprite.graphics.endFill();
			
			sprite.graphics.lineStyle(0, 0, .5);
			sprite.graphics.drawTriangles(vertices, indices, uvtData, TriangleCulling.NEGATIVE);
		}
		
		private function makeTriangles():void
		{
			for(var i:int = 0; i < rows; i++)
			{
				for(var j:int = 0; j < cols; j++)
				{
					var angle:Number = Math.PI * 2 / (cols - 1) * j;
					var xpos:Number = Math.cos(angle) * radius;
					var ypos:Number = (i - rows / 2) * res;
					var zpos:Number = Math.sin(angle) * radius;
					
					var scale:Number = focalLength / (focalLength + zpos +centerZ);
					
					vertices.push(xpos * scale, ypos * scale);
					
					uvtData.push(j / (cols - 1), i / (rows - 1));
					uvtData.push(scale);
					
					if(i < rows - 1 && j < cols - 1)
					{
						indices.push(i * cols + j,
									 i * cols + j + 1,
									 (i + 1) * cols + j);
									 
						indices.push(i * cols + j + 1,
									(i + 1) * cols + j + 1,
									(i + 1) * cols + j);
					}
				}
			}
		}
	}
}