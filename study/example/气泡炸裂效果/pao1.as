package  {
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 
	 *by.肖恩  QQ497937948 欢迎交流
	 *
	 */
	
	public class pao1 extends Sprite {
		private var tempn:int;//存放泡泡转动角度的初值
		private var fangxiang:String = "right";//泡转动的方向
        private var speed:int;//泡泡转动的速度
		public var mtype:String;//对像类型为泡泡,能从所有对象中区分开这个对象是泡泡
		
		public function pao1() {
			addEventListener(Event.ENTER_FRAME, xz); //监听帧频，用于转动泡泡、泡泡上升
			tempn = Math.random() * 360 + 1; //初始一个泡泡的角度
			this.rotation = tempn; //转到指定角度
			speed = Math.random() * 4+1 //初始一个转动的速度
		}
		
		//转动泡泡\泡泡上升 的 方法
		function xz(e:Event) {
			if (fangxiang == "right") { this.rotation += Math.random() * 0.9; }//该向右转时，以0-0.9内的范围随机速度向右转动
			if (fangxiang == "left") { this.rotation -= Math.random() * 0.9; }//该向左转时，以0-0.9内的范围随机速度向左转动
			if (this.rotation >= tempn + 10) { fangxiang = "left"; }//如果超出初始角度+10的角度，就反方向转
			if (this.rotation <= tempn - 10) { fangxiang = "right"; }//如果超出初始角度-10的角度，就反方向转
			
			this.y -=speed;//泡泡上升
		}
	}
	
}
