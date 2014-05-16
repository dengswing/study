package classes
{
	import flash.display.*;
	import flash.utils.*;
	import DemoEvent.*
	import util.*;
	
	public class llkDoc extends MovieClip
	{
		private var arrMap		:Array	= new Array(); 	// 存放地图数据的数组
		private var arrBlock	:Array	= new Array(); 	// 存放实心墙对象的数组
		private var _indexArr	:Array	= new Array();
		private var _linePoint	:Array 	= new Array(); 	//记录连接成功后的 拐点
		private var _lineArr	:Array 	= new Array(); 	//记录画的线段
		private var _pairArr	:Array  = new Array();
		
		public static var mapUnit	:int   = 70; 		// 设定单元格的边长
		public static var mapLength    	:int   = 8;  		// 设定地图的边长
		
		
		private var _activeCount 	:int   = 0;
		private var _id				:int   = 0;
		private var _delayId		:int   = 0;	
		private var _count			:int   = 0;
		
		private var _blockNum		:int   = 0;
		
		private var _sameString     :String   = ''; 	//相同的标示
		private var _currentString	:String	  = '';
		
		private var comblock		:ComBlock;
		private var comDrawLine		:ComDrawLine
		private var comCheckBarrier	:ComCheckBarrier;
		private var _disp			:PickEventDispatcher;
		
		public function llkDoc()
		{
			initEvent();
			initGame();
		}
		
		//////////////////////////////////////////////////
		// init Game 
		/////////////////////////////////////////////////
		
	    /**
		 * 游戏初始化函数
		 * @ init  Game 
		 * @ return void
 		 */ 
		private function initGame():void
		{
			initMission();
			
		}
		private function initEvent():void
		{
			_disp = new PickEventDispatcher();
			_disp.addEventListener(PickEvent.M_DOWN, onMouseDowmBallHandler);
		}
		
	   /**
		 *读取关卡数据，初始化关卡
		 * @ initMission
		 * @ return void
 		 */
		private function initMission():void 
		{
			// 读取地图数据
			_pairArr = RandomNumber.getPair(20, (mapLength - 2) * (mapLength - 2)); //配对好的数据
			
			trace("_pairArr",_pairArr);
			arrMap = MissionSet.GetMission("M" + 1); //地图
			
			setMap();
			comCheckBarrier = new ComCheckBarrier(arrBlock,_linePoint);
			comDrawLine		= new ComDrawLine(arrBlock,_linePoint,_lineArr);
			addChild(comDrawLine);
		}
		
	    /**
		 * 设置地图的数据
		 * @ setMap
		 * @ return void
		 */
		private function setMap():void 
		{
			var row:int;
			var col:int;
			for(var i:int=0; i<arrMap.length; i++) 
			{
				// 判断地图数组的数据对应的位置
				row = int(i/mapLength);
				col = i - row * mapLength;
				addComBlock(col, row,arrMap[i]);						
			}	
		}
		
		/**
		 * 添加Block
		 * @param  col   		横坐标
		 * @param  row  	 	纵坐标
		 * @param  _blak   		是否是障碍物体 0：不是 1：是
		 */
        private function addComBlock(col:int, row:int,_blank:int):void
		{
			
			if(_blank==1)
			{
				comblock= new ComBlock(_id,_disp,_blank,_pairArr[_blockNum]);
				_blockNum++;
			}
			else
			{
				comblock= new ComBlock(_id,_disp,_blank,0);
			}
			
			comblock.x = col * llkDoc.mapUnit+200;
			comblock.y = row * llkDoc.mapUnit+60;
			arrBlock.push(comblock);
			addChild(comblock);
			_id++;
		}
		
		 /**
		  * 删除line
		  * @ 
		  * @ 
		  */
		 private function clearLine():void
		 {
			 for(var i:int =0;i<_lineArr.length;i++)
			 {
				Clear.removeChild(_lineArr[i]);
			 }
			 
		 }
		 
		/**
		 * 延时1秒钟后图形消失 
		 * @
		 * @
		 */
		private function delayTimer():void
		{
			clearTimeout(_delayId);
			trace('***2个可以连接的点***：'+_indexArr);
			for(var i:int = 0;i< _indexArr.length;i++)
		  	{
				//arrBlock[_indexArr[i]].visible       	= false;
				
				arrBlock[_indexArr[i]]._blank			= 0;
				//arrBlock[_indexArr[i]].blanktxt.text	= arrBlock[_indexArr[i]]._blank;
				Clear.removeChild(arrBlock[_indexArr[i]]);
			}
			clearLine();
			_indexArr	 = [];
			_linePoint.splice(0);
			_sameString = '';
			_activeCount =0;
		}
		
		/**
		 * 点击的2个点 
		 * @param 		a0,b0  点击点的坐标
		 * @param		a1,b1  点击点的坐标
		 * @return 		void
		 */
		private function checkTwoBlock(a0:int,b0:int,a1:int,b1:int):void
		{
			trace("_sameString",_sameString,"|| >>",a0, b0, a1, b1);
			
			if (_sameString.substring(0, _sameString.length / 2) == _sameString.substring(_sameString.length / 2, _sameString.length))			
			{	//2物品相同的
				
				var checktemp	:Boolean;
				
				//检测， 是否有可以连接的线
				checktemp = comCheckBarrier.checkBarrier(a0,b0,a1,b1);
				
				if(checktemp)
				{
					// 画线
					comDrawLine.drawLine(a0,b0,a1,b1);
					
					_delayId = setTimeout(delayTimer,100);
					_count++;
				}
				else
				{
					for(var k:int = 0;k<_indexArr.length-1;k++)
					{
						arrBlock[_indexArr[k]].alpha = 1.0;
						arrBlock[_indexArr[k]].clearRect();
						arrBlock[_indexArr[k]].flag = -1;
						arrBlock[_indexArr[k]].currentNum = 0;
					}
					
					_indexArr.splice(0,1);
					_linePoint.splice(0);
					_sameString = _currentString;
					_activeCount=1;
				}
			}
			else
			{
				//trace('delete',_indexArr,_sameString);

				for(var j:int = 0;j<_indexArr.length-1;j++)
				{
					arrBlock[_indexArr[j]].alpha = 1.0;
					arrBlock[_indexArr[k]].clearRect();
					arrBlock[_indexArr[j]].flag = -1;
					arrBlock[_indexArr[j]].currentNum = 0;
				}
				
				_indexArr.splice(0,1);
				_linePoint.splice(0);
				_sameString = _currentString;
				_activeCount=1;
				//trace('delete',_indexArr,_sameString);
			}
			
			
		}
		
		/////////////////////////////////////////////////////////
		//  Event
		////////////////////////////////////////////////////////
		
		/**
		 * 鼠标点击事件
		 * @param		evt 
		 * @return 		void
		 */
		private function onMouseDowmBallHandler(evt:PickEvent):void
		{
		   trace('evt:',evt.params.index,evt.params.eventFlag);
		   _currentString = evt.params.index;
		   if(evt.params.eventFlag==1)
		   {
			   _sameString += evt.params.index;
			   _activeCount++; 
			   _indexArr.push(evt.params.id);
		    }
			else if(evt.params.eventFlag==-1&&_activeCount>0)
			{
				_sameString = '';
				_activeCount--;
				_indexArr = [];
			}
			
			
			if(_activeCount==2)
			{
				trace('index:' + _indexArr, "===>", _sameString);
				checkTwoBlock(_indexArr[0]/mapLength, _indexArr[0]%mapLength,
							  _indexArr[1]/mapLength, _indexArr[1]%mapLength);
			}
			
		 }
	}
}