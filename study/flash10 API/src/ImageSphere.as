﻿package
{
	import __AS3__.vec.Vector;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.TriangleCulling;
	import flash.events.Event;
	
	[SWF(backgroundColor = 0x000000, width = 800, height = 800)]
	
	public class ImageSphere extends Sprite
	{
		[Embed(source = "image.jpg")]		
		private var ImageClass:Class;
		
		private var vertices:Vector.<Number> = new Vector.<Number>();
		private var indices:Vector.<int> = new Vector.<int>();
		private var uvtData:Vector.<Number> = new Vector.<Number>();
		private var bitmap:Bitmap;
		private var sprite:Sprite;
		private var centerZ:int = 500;
		private var cols:int = 20;
		private var rows:int = 20;
		private var focalLength:Number = 1000;
		private var radius:Number = 400;
		
		private var offset:Number = 0; 
		
		public function ImageSphere()
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
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			draw();
		}
		
		private function draw():void
		{
			offset -= .02;
			vertices.length = 0;
			uvtData.length = 0;
			
			for(var i:int = 0; i < rows; i++)
			{
				for(var j:int = 0; j < cols; j++)
				{
					var angle:Number = Math.PI * 2 / (cols - 1) * j;
					var angle2:Number = Math.PI * i / (rows - 1) - Math.PI / 2;
					var xpos:Number = Math.cos(angle + offset) * radius * Math.cos(angle2);
					var ypos:Number = Math.sin(angle2) * radius;
					var zpos:Number = Math.sin(angle + offset) * radius * Math.cos(angle2);
					var scale:Number = focalLength / (focalLength + zpos + centerZ);
					vertices.push(xpos * scale,
					ypos * scale);
					uvtData.push(j / (cols - 1), i / (rows - 1));
					uvtData.push(scale);
				}
			}
			
			sprite.graphics.clear();
			sprite.graphics.beginBitmapFill(bitmap.bitmapData);
			sprite.graphics.drawTriangles(vertices, indices, uvtData, TriangleCulling.NEGATIVE);			
			sprite.graphics.endFill();
			// sprite.graphics.lineStyle(0, 0, .4);
			// sprite.graphics.drawTriangles(vertices, indices, uvtData,TriangleCulling.NEGATIVE);			
		}
		
		private function makeTriangles():void
		{
			for(var i:int = 0; i < rows; i++)
			{
				for(var j:int = 0; j < cols; j++)
				{
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