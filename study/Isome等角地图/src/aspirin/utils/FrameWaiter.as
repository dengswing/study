package aspirin.utils {
	import flash.display.Sprite;
	import flash.events.Event;

	public class FrameWaiter extends Sprite {
		private var _delayedFrame : int = 0;
		private var _repeatCount : int = 0;
		private var _onUpdate : Function;

		private var count : int = 0;
		private var _currentCount : int = 0;

		private var _onUpdataParams : Array = null;

		public function FrameWaiter(delayedFrame : int = 10, repeatCount : int = 0, onUpdate : Function = null, onUpdateParams : Array = null) : void {
			if (delayedFrame < 1)
				delayedFrame = 1;
			if (repeatCount < 0)
				repeatCount = 0;

			_delayedFrame = delayedFrame;
			_repeatCount = repeatCount;

			_onUpdate = onUpdate;
			_onUpdataParams = onUpdateParams;
		}

		public function start() : void {
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function stop() : void {
			count = _currentCount = 0;
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(evt : Event) : void {
			count++;
			if (count % _delayedFrame == 0) {
				_currentCount++;
				if (_onUpdate != null && _onUpdataParams != null) {
					_onUpdate.call(this, _onUpdataParams);
				}
				else if(_onUpdate != null) {
					_onUpdate.call(this);
				}
			}

			if (_repeatCount != 0 && _currentCount >= _repeatCount) {
				stop();
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}
}