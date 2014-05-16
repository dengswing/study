package  {
	/**
	 * 
	 *by.肖恩  QQ497937948 欢迎交流
	 *
	 */
	
	import flash.display.Sprite;//没有时间轴的舞台才用这个，也就是不参与帧操作的时候用，这样节约资源！
	import flash.utils.setInterval;//定位执行 支持
	import flash.net.URLRequest;//引用外部资源 支持
	import flash.media.Sound;//多媒体音乐支持
	import flash.events.Event;
	import flash.events.MouseEvent;//鼠标件事 支持
	
	public class main extends Sprite {//继承 Sprite
	
		private var paoarr:Array = new Array();//泡泡数组
		private var zakaiarr:Array = new Array(); //泡泡碰撞炸开效果数组
		private var zakai_mousearr:Array = new Array(); //鼠标碰到泡泡炸开效果数组
		private var paiobj:pai = new pai(); //声明画面里的公告牌
				
		public function main() {
			//添画面里的公告牌到舞台中间
			paiobj.x = stage.stageWidth / 2-paiobj.width/2 ;
			paiobj.y = 0;
			this.addChild(paiobj);
			
			//获取外部音乐资源
			var url:URLRequest=new URLRequest("wt.mp3")
			var sound1:Sound = new Sound();
			sound1.load(url);
			sound1.play();

			setInterval(addpaopao, 500);//400ms添加一个泡泡到舞台 调用addpaopao()方法
			addEventListener(Event.ENTER_FRAME, removepaopao)//监听帧频,来源检测泡泡的状态
			addEventListener(MouseEvent.MOUSE_OVER,MouseRemovepaopao)//监听鼠标移动对象上的事件
		}
		
		//添加泡泡到舞台的立法
		function addpaopao() {
			var paoobj = new pao1();//pao1是库里面的影片剪辑，声明他
			paoobj.x = int(Math.random() * 800); //指定泡泡x坐标的位置在800以内的随机范围，舞台宽度为800
			paoobj.y = 550; //指定泡泡y坐标的位置在550像素以内，舞台高度为500，多出50是为了不让新的泡泡直接出现在舞台。
			paoobj.mtype = "paopao" //这个属性在pao1.as里设定的，用来识别是泡泡对象
			paoobj.scaleX = paoobj.scaleY = Math.random() * 0.8; //让泡泡随机生成大小
			addChild(paoobj);
			paoarr.push(paoobj);//把泡泡加入到数组，留给后面检测状态时使用
		}
		
		//自动移除泡泡的方法,按帧频速度执行
		function removepaopao(e:Event) {
			//遍历舞台上所有的泡泡，如果飘出水面就自动移除,或者撞到公告牌，也会移除泡泡
			for (var i:int = 0; i < paoarr.length; i++) { 
			    //撞到公告牌、飘出水面 移除泡泡
				if (paiobj.hitTestObject(paoarr[i]) || paoarr[i].y<-50) {
					removeChild(paoarr[i]); //移除泡泡
					
					//创建一个泡泡自然炸开的效果
					var zakaiobj = new zakai();
					zakaiobj.x = paoarr[i].x; //效果显示在泡泡的原来位置
					zakaiobj.y = paoarr[i].y;
					zakaiobj.scaleX=zakaiobj.scaleY= paoarr[i].width*0.01 //让效果和泡泡的大小一致
					addChild(zakaiobj)
					
					zakaiarr.push(zakaiobj) //把效果加入数组，后台方便移动过期的效果
					paoarr.splice(i,1) //从泡泡数组中删除这个已经从后台移除的对象
				}
			}
			
			//遍历舞台上所有自然炸开的泡泡效果 ，如果过期就删除
			for (var k:int = 0; k < zakaiarr.length; k++ ) { 
				if (zakaiarr[k].currentFrame ==11) { //因为自动炸开效果影片剪辑里只有11帧，所以认中已经效果展示完成！
					removeChild(zakaiarr[k]);//舞台中移除满足条件的效果
					zakaiarr.splice(k,1)//数组中移除同样的效果
				}
			}
			
			//遍历舞台上所有鼠标碰撞炸开的泡泡效果 ，如果过期就删除，原理同上
			for (k=0; k < zakai_mousearr.length; k++ ) { 
				if (zakai_mousearr[k].currentFrame ==18) {
					removeChild(zakai_mousearr[k]);
					zakai_mousearr.splice(k,1)
				}
			}
			
		}
		
		//鼠标移到泡泡上时，炸开泡泡 方法
		function MouseRemovepaopao(e:Event) {
			//识别出这个鼠标当前对对象是泡泡
			if (e.target.mtype == "paopao") {
				var thispao:pao1 = e.target as pao1;//方法调用，把Event传来的触发对象存到变量里 ，这里等于触发对象本身。(注意 as pao1，否则不能移移)
			    if(contains(thispao)){
			       if (thispao.mtype == "paopao") {
			          removeChild(thispao); //移除泡泡

                      //显示鼠标碰撞炸开效果
			          var zakaiobj = new zakai_mouse();
			          zakaiobj.x = thispao.x;
			          zakaiobj.y = thispao.y;
			          zakaiobj.scaleX = zakaiobj.scaleY = thispao.width * 0.0095 //让效果的大水和泡泡一致
			          addChild(zakaiobj);
					  
			          zakai_mousearr.push(zakaiobj);//把鼠标碰撞炸开效果加到数组，方便检测是否展示完
					  
			          paoarr.splice(paoarr.indexOf(thispao), 1);//删除把当前泡泡从泡泡数组中删除
			       }
			    }
			}
		}
		
		
	}
	
}
