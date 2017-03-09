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

注意点:

EVENT_CHECK_ANY与EVENT_CHECK_ALL的区别
EVENT_CHECK_ANY:当事件名称数组中有任意一个事件发生时,即立刻调用回调方法
EVENT_CHECK_ALL:当事件名称数组中所有的事件发生时,才会调用回调方法,所以使用EVENT_CHECK_ALL时,需要将事件名称数组清空

事件线总容量:EventBus.m中 //事件线容量  int const EVENT_COUNT = 20;控制EventBus的事件总容量,超过后所有的事件都无法读取
