package com.kvc.extend.papervision3d {
	import gs.TweenLite;
	import gs.easing.*;
	
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Cube;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;		

	/**
	 * @author KevinCao
	 */
	public class RubiksCube extends DisplayObject3D {
		public static const LEFT_FACES : Array = [9, 24, 12, 8, 23, 11, 7, 22, 10];
		public static const RIGHT_FACES : Array = [18, 21, 3, 17, 20, 2, 16, 19, 1];
		public static const TOP_FACES : Array = [9, 6, 3, 24, 25, 21, 12, 15, 18];
		public static const BOTTOM_FACES : Array = [1, 4, 7, 19, 26, 22, 16, 13, 10];
		public static const FRONT_FACES : Array = [3, 6, 9, 2, 5, 8, 1, 4, 7];
		public static const BACK_FACES : Array = [12, 15, 18, 11, 14, 17, 10, 13, 16];

		public static const SINGLE_ROTATE_START : String = "single_rotate_start";
		public static const SINGLE_ROTATE_FINISHED : String = "single_rotate_finished";
		public static const SEQUENCE_ROTATE_START : String = "sequence_rotate_start";
		public static const SEQUENCE_ROTATE_FINISHED : String = "sequence_rotate_finished";

		protected var size : Number = 250;
		protected var gap : Number = 8;
		
		private var rcMaterials : Array;

		private var tempDo3D : DisplayObject3D = new DisplayObject3D();

		/*	For sequence rotate	*/
		private var commandArray : Array;
		private var _time : Number;
		private var _reverse : Boolean;

		private var _locked : Boolean;
		
		public function get locked() : Boolean {
			return _locked;
		}

		public function RubiksCube(materials : Array = null, size : Number = 250, gap : Number = 8) {
			rcMaterials = materials ? materials : createMaterialListArray();
			_locked = false;
			this.size = size;
			this.gap = gap;
			init();
		}
		
		private function init():void {
			var cubeGrid : Cube = new Cube(rcMaterials[0], size * 2, size * 2, size * 2, 2, 2, 2);

			for(var i : int = 0;i < cubeGrid.geometry.vertices.length; i++) {
				var size : Number = size - gap;
				var cube : Cube = new Cube(rcMaterials[i], size, size, size, 2, 2, 2);
				cube.x = cubeGrid.geometry.vertices[i].x;
				cube.y = cubeGrid.geometry.vertices[i].y;
				cube.z = cubeGrid.geometry.vertices[i].z;
				cube.name = "cube" + (i + 1);
				addChild(cube);
			} 
		}

		/*
		 * 创建魔方材质
		 */
		public static function createMaterialListArray(frontMat : MaterialObject3D = null, backMat : MaterialObject3D = null, leftMat : MaterialObject3D = null, rightMat : MaterialObject3D = null, topMat : MaterialObject3D = null, bottomMat : MaterialObject3D = null, defaultMat : MaterialObject3D = null) : Array {	
			if(!frontMat) {
				frontMat = new ColorMaterial(0xffffff);
			}
			if(!backMat) {
				backMat = new ColorMaterial(0x0000ff);
			}
			if(!leftMat) {
				leftMat = new ColorMaterial(0xff0000);
			}
			if(!topMat) {
				topMat = new ColorMaterial(0x00ff00);
			}			
			if(!rightMat) {
				rightMat = new ColorMaterial(0xffff00);
			}
			if(!bottomMat) {
				bottomMat = new ColorMaterial(0xff00ff);
			}
			if(!defaultMat) {
				defaultMat = new ColorMaterial(0);
			}
			
			var array : Array = [];
			
			for (var i : uint = 1;i <= 26; i++) {
				var materialsList : MaterialsList = new MaterialsList();
				
				if(FRONT_FACES.indexOf(i) >= 0) {
					materialsList.addMaterial(frontMat, "front");
				} else {
					materialsList.addMaterial(defaultMat, "front");
				}
				if(BACK_FACES.indexOf(i) >= 0) {
					materialsList.addMaterial(backMat, "back");
				} else {
					materialsList.addMaterial(defaultMat, "back");
				}
				if(LEFT_FACES.indexOf(i) >= 0) {
					materialsList.addMaterial(leftMat, "left");
				} else {
					materialsList.addMaterial(defaultMat, "left");
				}
				if(RIGHT_FACES.indexOf(i) >= 0) {
					materialsList.addMaterial(rightMat, "right");
				} else {
					materialsList.addMaterial(defaultMat, "right");
				}
				if(TOP_FACES.indexOf(i) >= 0) {
					materialsList.addMaterial(topMat, "top");
				} else {
					materialsList.addMaterial(defaultMat, "top");
				}
				if(BOTTOM_FACES.indexOf(i) >= 0) {
					materialsList.addMaterial(bottomMat, "bottom");
				} else {
					materialsList.addMaterial(defaultMat, "bottom");
				}
				array.push(materialsList);
			}
			
			return array;
		}

		/*
		 * 替换魔方某个面的贴图
		 * @param	face	:	"front","back","left","right","top","bottom"
		 * @param	bmd		:	贴图
		 */
		public function replaceMaterial(face : String, bmd : BitmapData) : void {
			var array : Array = RubiksCube[face.toUpperCase() + "_FACES"];
			
			var materials : Array = [];
			materials.push(createBitmapMaterial(bmd, 0, 0));
			materials.push(createBitmapMaterial(bmd, 1, 0));
			materials.push(createBitmapMaterial(bmd, 2, 0));
			materials.push(createBitmapMaterial(bmd, 0, 1));
			materials.push(createBitmapMaterial(bmd, 1, 1));
			materials.push(createBitmapMaterial(bmd, 2, 1));
			materials.push(createBitmapMaterial(bmd, 0, 2));
			materials.push(createBitmapMaterial(bmd, 1, 2));
			materials.push(createBitmapMaterial(bmd, 2, 2));
			
			for(var i : uint = 0;i < 9; i++) {
				getChildByName("cube" + array[i]).replaceMaterialByName(materials[i], face);
			}
		}
		
		/*
		 * 把一张贴图映射为九宫格
		 * @param	bmd	:	贴图
		 * @param	i	:	行数
		 * @param	j	:	列数
		 */
		private function createBitmapMaterial(bmd : BitmapData, i : uint, j : uint) : BitmapMaterial {
			var w : Number = bmd.width / 3;
			var h : Number = bmd.height / 3;
			var texture : BitmapData = new BitmapData(int(w), int(h), false);
			var rect : Rectangle = new Rectangle(i * w, j * h, w, h);
			texture.copyPixels(bmd, rect, new Point());
			var bm : BitmapMaterial = new BitmapMaterial(texture, true);
//			bm.smooth = true;
			return bm;
		}		


		/*
		 * 单次旋转
		 * @param	command	:	u,d,r,l,f,b,u',d',r',l',f',b'
		 * @param	reverse	:	是否反转命令
		 * @param	time	:	动画时间，设置为0则直接更新
		 */
		public function singleRotate(command : String, time : Number = 0.5, reverse : Boolean = false) : void {
			if(_locked) {
				trace("ERROR! RubiksCube is locked.");
				return;
			}
			
			var pos : Number;
			var direction : String;
			var s : String = command.slice(0, 1);
			tempDo3D = new DisplayObject3D();
				
			//选择子Cube并加到临时组
			switch (s) {
				case "l":
					pos = -size;
					direction = "x";
					break;
				case "r":
					pos = size;
					direction = "x";
					break;
				case "u":
					pos = size;
					direction = "y";
					break;
				case "d":
					pos = -size;
					direction = "y";
					break;
				case "f":
					pos = -size;
					direction = "z";
					break;
				case "b":
					pos = size;
					direction = "z";
					break;
				default:
					trace("Command Error");
					return;
			}
				
			for(var name:String in children) {
				var cube : Cube = getChildByName(name) as Cube;
				// 用小方块所处的位置来判断选择，误差<10
				if(Math.abs(cube[direction] - pos) < 10) {
					removeChild(cube);
					tempDo3D.addChild(cube, name);
				}
			}
			//临时组作为rubiksCube的子物体
			addChild(tempDo3D);
				
			var degree : Number = command.indexOf("'") == -1 ? 90 : -90;
			if(reverse) {
				degree *= -1;
			}
				
			var rotate : String = "rotation" + direction.toUpperCase();
			if(time > 0) {
				var obj : Object = {};
				obj[rotate] = tempDo3D[rotate] + degree;
				obj["onComplete"] = onRotateFinished;
				obj["ease"] = Quad.easeInOut;
				TweenLite.to(tempDo3D, time, obj);
				_locked = true;
			} else {
				tempDo3D[rotate] += degree;
				removeTempDo3D();
			}
			
			dispatchEvent(new Event(RubiksCube.SINGLE_ROTATE_START));
		}

		/*
		 * 序列旋转
		 * @param command	:	u-d-r...
		 */
		public function comboRotate(command : String, time : Number = 1, reverse : Boolean = false) : void {
			if(_locked) {
				trace("ERROR! RubiksCube is locked.");
				return;
			}
			
			dispatchEvent(new Event(RubiksCube.SEQUENCE_ROTATE_START));
			
			commandArray = command.split('-');
			if(reverse) {
				commandArray = commandArray.reverse();
			}
			_time = time / commandArray.length;
			_reverse = reverse;
			
			singleRotate(commandArray.shift(), _time, reverse);
			
			addEventListener(RubiksCube.SINGLE_ROTATE_FINISHED, onQueueItemFinished);
		}

		protected function onQueueItemFinished(evt : Event) : void {
			if(commandArray.length > 0) {
				singleRotate(commandArray.shift(), _time, _reverse);
			} else {
				// 序列全部完成，移除侦听器
				removeEventListener(RubiksCube.SINGLE_ROTATE_FINISHED, onQueueItemFinished);
				dispatchEvent(new Event(RubiksCube.SEQUENCE_ROTATE_FINISHED));
			}
		}

		/*
		 * 单次旋转完成时触发
		 */
		protected function onRotateFinished() : void {
			removeTempDo3D();
			_locked = false;
			dispatchEvent(new Event(RubiksCube.SINGLE_ROTATE_FINISHED));
		}

		/*
		 * 删除临时组
		 */
		private function removeTempDo3D() : void {
			//在计算位置之前先更新矩阵
			tempDo3D.updateTransform();
			
			for(var name:String in tempDo3D.children) {
				var cube : Cube = tempDo3D.getChildByName(name) as Cube;
				//把空间换算到上一级
				cube.transform.calculateMultiply(tempDo3D.transform, cube.transform);
				tempDo3D.removeChild(cube);
				addChild(cube);
				
				/* use world to caculate */
				
				/*
				var cubeWorldMatrix:Matrix3D = cube.world;
				var inverse:Matrix3D = new Matrix3D();
				var tempParentMatrix:Matrix3D = new Matrix3D();
 
				inverse.calculateInverse(world);
				tempParentMatrix.calculateMultiply(inverse, cubeWorldMatrix);
 
				cube.copyTransform(tempParentMatrix);

				tempDo3D.removeChild(cube);
				addChild(cube);
				 */
			}
			
			removeChild(tempDo3D);
		}
	}
}

