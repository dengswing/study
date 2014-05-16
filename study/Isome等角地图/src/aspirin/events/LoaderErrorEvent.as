package aspirin.events {
	import flash.events.Event;

	public class LoaderErrorEvent extends Event {

		public static var IO_ERROR : String = "io_error";
		public static var TIME_OUT : String = "time_out";
		public static var SECURITY_ERROR : String = "security_error";

		private var _code : uint;

		public function LoaderErrorEvent( error_name : String ) {
			super( error_name );
			
			switch( error_name ) {
				case IO_ERROR:
					_code = 0;
					break;
				
				case TIME_OUT:
					_code = 1;
					break;
				
				case SECURITY_ERROR:
					_code = 2;
					break;
			}
		}

		public function get code() : uint {
			return _code;
		}
	}
}