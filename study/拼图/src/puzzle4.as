package 
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class puzzle4 extends BaseSprite
	{
		private var chipWidth				:int			=	0;
		private var chipHeight				:int			=	0;
		private var rowNum					:int			=	8;
		private var colNum					:int			=	8;
		private var checkGap				:int			=	15;
		private var sourceImage				:Bitmap			=	null;
		
		private var _pieceW:Number;
		private var _pieceH:Number;
		private var _pieceMinWH:Number;
		private var _pieceD:Number;
		///////////内切矩形宽高(通过矩形画近似椭圆)///////////
		private var _pieceOW:Number;
		private var _pieceOH:Number;
		///////////////比例系数///////////////
		private var _pieceD_k:Number = 10;
		private var _pieceO_k:Number = 4;
		private var _pieceOWH_k:Number = 3/4;
		
		
		private var currentChip				:Item_Chip		=	null;
		private var finishFun				:Function		=	null;
		
		public function puzzle4()			{}
		
		override public function removeFromStage(...rest):void
		{
			super.removeFromStage();
			this.sourceImage				=	null;
			this.currentChip				=	null;
			
			this.stage.removeEventListener(MouseEvent.MOUSE_UP,			stopChip);
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,		moveChip);
		}
		
		/** 开始游戏
		 * 
		 * @param sourceBitmap			要拼的原图，该图的大小直接决定了后面的碎片的大小
		 * @param _finishFun			拼图完成后的处理函数
		 * @param opwidth				操作区域的宽度
		 * @param opheight				操作区域的高度
		 * @param _rowNum				行数
		 * @param _colNum				列数
		 * @param _checkGap				检测像素级范围
		 * 
		 */		
		public final function startPuzzle(sourceBitmap:Bitmap, _finishFun:Function, opwidth:Number, opheight:Number, 
										  _rowNum:int = 8, _colNum:int = 8, _checkGap:int = 15):void
		{
			while(this.numChildren)				this.removeChildAt(0);
			this.graphics.clear();
			this.graphics.lineStyle(1, 0, 0.5);
			this.graphics.beginFill(0xeeeeee, 0.2);
			this.graphics.drawRect(0, 0, opwidth, opheight);
			this.graphics.endFill();
			this.scrollRect					=	new Rectangle(0, 0, opwidth + 1, opheight + 1);
			
			this.sourceImage				=	sourceBitmap;
			this.finishFun					=	_finishFun;
			this.rowNum						=	(_rowNum > 15) ? 15 : _rowNum;
			this.colNum						=	(_colNum > 15) ? 15 : _colNum;
			this.checkGap					=	(_checkGap > 20) ? 20 : _checkGap;
			
			var i				:int		=	0;
			var j				:int		=	0;
			var k				:int		=	0;
			//定义每个碎片的宽高
			this.chipWidth					=	int(sourceImage.height / rowNum);
			this.chipHeight					=	int(sourceImage.width / colNum);
			
			_pieceW = chipHeight;
			_pieceH = chipWidth;
			_pieceMinWH = Math.min(_pieceW, _pieceH);
			_pieceD = _pieceMinWH/_pieceD_k;
			_pieceOW = _pieceMinWH/_pieceO_k;
			_pieceOH = _pieceOW/_pieceOWH_k;
	
	
			//trace("chipWidth", chipWidth, "chipHeight", chipHeight);
			
			var chip:Item_Chip;
			var pArray:Array;
			for(i = 0; i < rowNum; i ++)
			{
				for(j = 0; j < colNum; j ++)
				{
					chip					=	new Item_Chip;
					chip.ID					=	new Point(i, j);
					chip.Group				=	[chip];
					chip.Key				=	rowNum * i + j;
					chip.name				=	i + '_' + j;
					
					pArray					=	this.configPoint(chip);
					
					chip.graphics.beginBitmapFill
					(this.sourceImage.bitmapData.clone(),
					new Matrix(1, 0, 0, 1, -j * this._pieceW, -i * this._pieceH) , false, true);					
					
					chip.graphics.lineStyle(0, 0, 0);
					chip.graphics.moveTo(0, 0);
					
					trace("start",pArray.length);
					for (k = 0; k < pArray.length; k++)
					{
						if (pArray[k] is Point) {
							chip.graphics.lineTo(pArray[k].x, pArray[k].y);
							trace("11k"+"-->"+pArray[k].x+"-->"+pArray[k].y);
						} else {
							chip.graphics.curveTo(pArray[k][0].x, pArray[k][0].y, pArray[k][1].x, pArray[k][1].y);
							trace("00k"+"-->"+pArray[k][0].x+"-->"+ pArray[k][0].y+"-->"+ pArray[k][1].x+"-->"+ pArray[k][1].y);
						}
					}
					
					//chip.moveTo(i * this.chipWidth, j * this.chipHeight);
					chip.addEventListener(MouseEvent.MOUSE_DOWN,dragChip);
					this.addChild(chip);
				}
			}
			this.doSplit();
		}
		
		/** 平铺图片，将图片从上到下，靠左排列 **/
		public final function order():void
		{
			if(!this.numChildren)				return;
			var index			:int		=	0;
			var rowCount		:int		=	int(this.scrollRect.height / this._pieceW);
			var chip			:Item_Chip;
			for(var i:int = 0; i < this.numChildren; i ++)
			{
				chip						=	this.getChildAt(i) as Item_Chip;
				if(chip.Group && chip.Group.length == 1)
				{
					chip.x					=	int(index / rowCount) * this._pieceH + 10;
					chip.y					=	(index % rowCount) * this._pieceW + 10;
					index					++;
				}
			}
		}
		
		private final function doSplit(...rest):void
		{
			this.visible					=	false;
			var i				:int		=	0;
			var chip			:Object;
			for(i = 0; i < this.numChildren; i ++)
			{
				chip						=	this.getChildAt(i);
				this.randomPosition(chip);
			}
			for(i = 0; i < this.numChildren; i ++)
			{
				chip						=	this.getChildAt(i);
				this['setChildIndex'](chip, int(Math.random() * this.numChildren));
			}
			this.visible					=	true;
		}
		
		private final function getRndSize():int
		{
			var val				:Number		=	(this._pieceH > this._pieceW) ? this._pieceW : this._pieceH;
			return int(val * 0.25 + Math.random() * val * 0.2);
			//return int(val * 0.5);
		}
		
		private function getRndD():Number 
		{
			//返回与边界错开的高度
			return _pieceD - Math.random() * 2 * _pieceD;
		}
	
		private function getOvalDotArray(position:String):Array
		{
			//var rnd:Number = Math.random()*2 ? 1 : -1;
			var rnd:Number = 1;
			var circleDotArr:Array = [];
			switch (position)
			{
				case "right" :
					var a0:Point = new Point(_pieceW+getRndD(), (_pieceH-_pieceOW)/2+_pieceOW/4-Math.random()*_pieceOW/2);
					var a1:Array = [new Point(a0.x+rnd*(_pieceOH/2), a0.y-_pieceOW/2), new Point(a0.x+rnd*_pieceOH, a0.y)];
					var a2:Array = [new Point(a0.x+rnd*(_pieceOH+_pieceOW/3), a0.y+_pieceOW/2), new Point(a0.x+rnd*_pieceOH, a0.y+_pieceOW)];
					var a3:Array = [new Point(a0.x+rnd*_pieceOH/2, a0.y+_pieceOW+_pieceOW/2), new Point(a0.x, a0.y+_pieceOW)];
					circleDotArr = [a0, a1, a2, a3];
					break;
				case "down" :
					var a0:Point = new Point(_pieceW-((_pieceW-_pieceOW)/2+_pieceOW/4-Math.random()*_pieceOW/2), _pieceH+getRndD());
					var a1:Array = [new Point(a0.x+_pieceOW/2, a0.y+rnd*(_pieceOH/2)), new Point(a0.x, a0.y+rnd*_pieceOH)];
					var a2:Array = [new Point(a0.x-_pieceOW/2, a0.y+rnd*(_pieceOH+_pieceOW/3)), new Point(a0.x-_pieceOW, a0.y+rnd*_pieceOH)];
					var a3:Array = [new Point(a0.x-_pieceOW-_pieceOW/2, a0.y+rnd*_pieceOH/2), new Point(a0.x-_pieceOW, a0.y)];
					circleDotArr = [a0, a1, a2, a3];
					break;
			}
			return circleDotArr;
		}
	
		private final function configPoint(chip:Item_Chip):Array
		{
			var result			:Array		=	[];
			var tempArray		:Array		=	[];
			var tmp				:Array		=	new Array(4);
			
			trace("chip.ID",chip.ID,rowNum,colNum);
			if(chip.ID.x == 0)
			{ //a
				chip.ALeft					=	[];
			}
			else
			{
				tmp							=	new Array(4);
				tempArray					=	(this.getChildByName((chip.ID.x - 1) +  '_' + chip.ID.y) as Item_Chip).ARight;
				
				tmp[0] = new Point(tempArray[3][1].x, tempArray[3][1].y-_pieceH);
				tmp[1] = [new Point(tempArray[3][0].x, tempArray[3][0].y-_pieceH), new Point(tempArray[2][1].x, tempArray[2][1].y-_pieceH)];
				tmp[2] = [new Point(tempArray[2][0].x, tempArray[2][0].y-_pieceH), new Point(tempArray[1][1].x, tempArray[1][1].y-_pieceH)];
				tmp[3] = [new Point(tempArray[1][0].x, tempArray[1][0].y - _pieceH), new Point(tempArray[0].x, tempArray[0].y - _pieceH)];
				
				chip.ALeft					=	tmp.slice();
			}
			
			if(chip.ID.x == this.rowNum - 1)
			{//c
				chip.ARight					=	[];
			}
			else
			{				
				tmp = getOvalDotArray("down");
				chip.ARight					=	tmp.slice();
			}
			
			if(chip.ID.y == 0)
			{//d
				chip.ATop					=	[];
			}
			else
			{
				tmp							=	new Array(4);
				tempArray					=	(this.getChildByName(chip.ID.x +  '_' + (chip.ID.y - 1)) as Item_Chip).AFeet;
				
				tmp[0] = new Point(tempArray[3][1].x-_pieceW, tempArray[3][1].y);
				tmp[1] = [new Point(tempArray[3][0].x-_pieceW, tempArray[3][0].y), new Point(tempArray[2][1].x-_pieceW, tempArray[2][1].y)];
				tmp[2] = [new Point(tempArray[2][0].x-_pieceW, tempArray[2][0].y), new Point(tempArray[1][1].x-_pieceW, tempArray[1][1].y)];
				tmp[3] = [new Point(tempArray[1][0].x - _pieceW, tempArray[1][0].y), new Point(tempArray[0].x - _pieceW, tempArray[0].y)];
				
				chip.ATop					=	tmp.slice();
			}
			
			if(chip.ID.y == this.colNum - 1)
			{//b
				chip.AFeet					=	[];
			}
			else
			{
				tmp = getOvalDotArray("right");
				chip.AFeet					=	tmp.slice();
			}	
			
			result							=	result.concat(chip.ALeft);
			result.push(new Point(_pieceW, 0));
			
			result							=	result.concat(chip.AFeet);
			result.push(new Point(_pieceW, _pieceH));
			
			result							=	result.concat(chip.ARight);
			result.push(new Point(0, _pieceH));
			
			result							=	result.concat(chip.ATop);			
			
			return result;
		}
		
		private final function randomPosition(target:Object):void
		{
			target.x						=	Math.random() * (this.scrollRect.width - this._pieceH);
			target.y						=	Math.random() * (this.scrollRect.height - this._pieceW);
		}
		
		private final function dragChip(e:MouseEvent):void
		{
			this.currentChip				=	e.currentTarget as Item_Chip;
			
			/** 记录要移动的集合内的所有偏移量 **/
			var chip		:Item_Chip;
			var total		:int			=	this.currentChip.Group.length;
			for(var i:int = 0; i < total; i ++)
			{
				chip						=	this.currentChip.Group[i];
				chip.MoveGap				=	new Point(this.mouseX - chip.x, this.mouseY - chip.y);				
				this.setChildIndex(chip, this.numChildren - 1);
			}
			
			this.stage.removeEventListener(MouseEvent.MOUSE_UP,			stopChip);
			this.stage.addEventListener(MouseEvent.MOUSE_UP,			stopChip);
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,		moveChip);
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE,			moveChip);
			
			e.updateAfterEvent();
		}
		
		private final function moveChip(e:MouseEvent):void
		{
			if(!this.currentChip)				return;
			if(this.scrollRect.contains(this.mouseX, this.mouseY))
			{
				var chip		:Item_Chip;
				if(!this.currentChip.Group)		return;
				var total		:int		=	this.currentChip.Group.length;
				for(var i:int = 0; i < total; i ++)
				{
					chip					=	this.currentChip.Group[i];
					chip.x					=	this.mouseX - chip.MoveGap.x;
					chip.y					=	this.mouseY - chip.MoveGap.y;
				}
		 	}
    		e.updateAfterEvent();
		}
		
		private final function stopChip(e:MouseEvent):void
		{
			this.stage.removeEventListener(MouseEvent.MOUSE_UP,			stopChip);
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,		moveChip);
			
			if(!this.currentChip)				return;
			if(!this.currentChip.Group)			return;
			
			var i			:int			=	0;
			var j			:int			=	0;
			var chip		:Item_Chip;
			var checkChip	:Item_Chip;
			var sourceGroup	:Array			=	this.currentChip.Group.slice();
			var total		:int			=	sourceGroup.length;
			
			//trace("sourceGroup",sourceGroup);
			for(i = 0; i < this.numChildren; i ++)
			{
				chip						=	this.getChildAt(i) as Item_Chip;
				if(sourceGroup.indexOf(chip) > -1)
				{
					continue;
				}
				else
				{
					/** 在sourceGroup中检测当前被检测碎片与sourceGroup中某个碎片属于相邻的 **/
					for(j = 0; j < sourceGroup.length; j ++)
					{
						checkChip		=	sourceGroup[j];
						if(!checkChip.Group)						return;
						if(checkChip.Group.indexOf(chip) > -1)		continue;
						/** 同列，检测相隔距离是否为一个单位 **/
						
						if(checkChip.ID.x == chip.ID.x)
						{
							/** 纵向编号差1，横坐标差距小于设定差距 **/
							if( (this.getNonnegative(checkChip.ID.y - chip.ID.y) == 1) && 
								(this.getNonnegative(checkChip.x - chip.x) < this.checkGap) )
							{
								//trace("id...x -->site:", checkChip.toString(), chip.toString(), " position:", checkChip.ID, chip.ID, checkChip.x - chip.x);
								if ((checkChip.ID.y > chip.ID.y && checkChip.y > chip.y && 								
									 checkChip.y - chip.y < this.checkGap + this.chipHeight && 
									 checkChip.y - chip.y >= this.chipHeight - this.checkGap)
									||
									(checkChip.ID.y < chip.ID.y && checkChip.y < chip.y && 
									 chip.y - checkChip.y < this.checkGap + this.chipHeight && 
									 chip.y - checkChip.y >= this.chipHeight - this.checkGap))						 
								{
									//trace("x ok..");
									this.updateGroup(this.currentChip.Group.slice(), chip.Group.slice());
								}
							}
						}
						/** 同行，检测相隔距离是否为一个单位 **/
						else if(checkChip.ID.y == chip.ID.y)
						{
							/** 横向编号差1，横坐标差距小于设定差距 **/
							if( (this.getNonnegative(checkChip.ID.x - chip.ID.x) == 1) && 
								(this.getNonnegative(checkChip.y - chip.y) < this.checkGap) )
							{
								//trace("id...y -->site:", checkChip.toString(), chip.toString(), " position:", checkChip.ID, chip.ID, checkChip.x - chip.x);
								if ((checkChip.ID.x > chip.ID.x && checkChip.x > chip.x &&
									 checkChip.x - chip.x < this.checkGap + this.chipWidth &&
									 checkChip.x - chip.x >= this.chipWidth - this.checkGap)
									||
									(checkChip.ID.x < chip.ID.x && checkChip.x < chip.x  && 
									 chip.x - checkChip.x < this.checkGap + this.chipWidth &&									
									 chip.x - checkChip.x >= this.chipWidth - this.checkGap))
								{
									//trace("y ok..");
									this.updateGroup(this.currentChip.Group.slice(), chip.Group.slice());
								}
							}
						}
					}
				}
			}
			this.currentChip				=	null;
			e.updateAfterEvent();
		}
		
		private final function updateGroup(sourceGroup:Array, _newGroup:Array):void
		{
			var i				:int		=	0;
			var newGroup		:Array		=	sourceGroup;
			for(i = 0; i < _newGroup.length; i ++)
			{
				if(newGroup.indexOf(_newGroup[i]) == -1)
				{
					newGroup.push(_newGroup[i]);
				}
			}
			newGroup.sortOn('Key');
			
			var dx				:Number		=	int(newGroup[0].x);
			var dy				:Number		=	int(newGroup[0].y);
			newGroup[0].moveTo(dx, dy);
			var idx				:int		=	newGroup[0].ID.x;
			var idy				:int		=	newGroup[0].ID.y;
			var chip			:Item_Chip;
			for(i = 0; i < newGroup.length; i ++)
			{
				chip						=	newGroup[i];
				chip.Group					=	newGroup;
				chip.x						=	dx + this.chipWidth * (chip.ID.x - idx);
				chip.y						=	dy + this.chipHeight * (chip.ID.y - idy);
				this.setChildIndex(chip, this.numChildren - 1);
			}
			
			if(newGroup.length == this.numChildren)
			{
				/** finish **/
				while(this.numChildren)			this.removeChildAt(0);
				this.sourceImage.x			=	(this.scrollRect.width - this.sourceImage.width) * 0.5;
				this.sourceImage.y			=	(this.scrollRect.height - this.sourceImage.height) * 0.5;
				this.addChild(this.sourceImage);
				if(this.finishFun is Function)	this.finishFun();
			}
		}
	}
}
