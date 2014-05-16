//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.eventDispatcher
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;

	public class EventDispatcherExtensionTest
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var context:IContext;

		/*============================================================================*/
		/* Test Setup and Teardown                                                    */
		/*============================================================================*/

		[Before]
		public function before():void
		{
			context = new Context();
		}

		/*============================================================================*/
		/* Tests                                                                      */
		/*============================================================================*/

		[Test]
		public function an_EventDispatcher_is_mapped_into_injector():void
		{
			var actual:Object = null;
			context.install(EventDispatcherExtension);
			context.whenInitializing( function():void {
				actual = context.injector.getInstance(IEventDispatcher);
			});
			context.initialize();
			assertThat(actual, instanceOf(IEventDispatcher));
		}

		[Test]
		public function provided_EventDispatcher_is_mapped_into_injector():void
		{
			const expected:IEventDispatcher = new EventDispatcher();
			var actual:Object = null;
			context.install(new EventDispatcherExtension(expected));
			context.whenInitializing( function():void {
				actual = context.injector.getInstance(IEventDispatcher);
			});
			context.initialize();
			assertThat(actual, equalTo(expected));
		}
	}
}
