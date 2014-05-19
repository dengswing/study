class com.ycccc.PuzzleGame.MovieClipDrag extends MovieClip {
	public function MovieClipDrag(mc:MovieClip) {
		mc.onPress = this.onPress;
		mc.onRelease = mc.onReleaseOutside=this.onRelease;
	}
	private function onPress() {
		this.startDrag();
		this.swapDepths(this._parent.getNextHighestDepth());
	}
	private function onRelease() {
		this.stopDrag();
	}
}
