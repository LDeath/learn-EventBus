# learn-EventBus
对EventBus的学习
原作者地址https://github.com/github-xiaogang/EventBus-iOS.git

同步方式:

发布者:遵循<EventSyncPublisher>接口,使用EVENT_PUBLISH(self,eventName)或EVENT_PUBLISH_WITHDATA(self,eventName,eventData)发布事件.

订阅者:遵循<EventSyncSubscriber>接口,使用EVENT_SUBSCRIBE(self,eventName)来订阅eventName事件,并实现- (void)eventOccurred: (NSString *)eventName event:(Event *)event接口方法对事件进行处理.

异步方式:

发布者:遵循<EventAsyncPublisher>接口,使用EVENT_PUBLISH(self,eventName)或EVENT_PUBLISH_WITHDATA(self,eventName,eventData)发布事件.

订阅者:遵循<EventAsyncSubscriber>接口,在适当的位置先使用EVENT_SUBSCRIBE(self,eventName)订阅事件,然后在需要的时候使用EVENT_CHECK(self,eventName)读取事件,如果有事件则会回调- (void)eventOccurred: (NSString *)eventName event:(Event *)event方法处理事件.

区别:

相同点:都必须使用EVENT_SUBSCRIBE(self,eventName)订阅事件

不同点:异步的方式,在发布者发布事件后并不会立刻回调处理事件,而是在需要的时候通过EVENT_CHECK(self,eventName)读取事件后回调;
      同时,异步的方式,由于不会立刻读取发布者发布的事件,所以事件会有一定的生命周期(life),存储在eventBus(具有一定的容量)上.
