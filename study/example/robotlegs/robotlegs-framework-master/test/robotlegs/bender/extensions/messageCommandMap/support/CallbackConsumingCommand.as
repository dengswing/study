//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.messageCommandMap.support
{

	public class CallbackConsumingCommand
	{

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function execute(message:Object, callback:Function):void
		{
			// note: callback is not called, this halts the flow
		}
	}
}
