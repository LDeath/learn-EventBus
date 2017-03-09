//
//  EventBus.h
//  EventBus
//
//  Created by 张小刚 on 14-2-13.
//  Copyright (c) 2014年 duohuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventPublisher.h"
#import "EventSubscriber.h"

extern NSString * const EventBusLogNotification;
extern NSString * const EventBusLogUserInfoKey;
/**
 * 订阅者需要 标记自己为EventAsyncSubscriber 或 EventSyncSubscriber
 *  AsyncSubscriber: 标记自己为异步事件订阅者，表明自己会主动读取 事件。
 *  SyncSubscriber: 标记自己为同步事件订阅者， 表明自己只会被动接受通知。
 
 * 发布者需要 标记自己为EventAsyncPublisher 或 EventSyncPublisher
 *  AsyncPublisher:  表明发布的事件为 <异步事件>
 *  SyncPublisher: 表明发布的发布的事件为 同步事件即通知
 
 * 目前对于 异步订阅者来说，在哪个线程上检查事件(EVENT_CHECK)，回调就在哪个线程上。
 *    对于 同步订阅者来说，在哪个线程上发布事件(EVENT_PUBLISH)，回调就在哪个线程上。
 */

/**
 * 订阅事件
 */
#define EVENT_SUBSCRIBE(subscriber,eventName) ([[EventBus busManager] addSubscriber:(subscriber) event: (eventName)])

/**
 * 取消订阅
 */
#define EVENT_UNSUBSCRIBE(subscriber,eventName) ([[EventBus busManager] removeSubscriber:(subscriber) event: (eventName)])

/**
 * 读取事件
 * 使用者: 仅异步订阅者可以检查（id<EventAsyncSubscriber>）
 */
#define EVENT_CHECK(subscriber,eventName) ([[EventBus busManager] checkEvent:(eventName) forSubscriber:(subscriber)])
//OR
#define EVENT_CHECK_ANY(subscriber,eventNames_array) ([[EventBus busManager] checkEvents_OR:(eventNames_array) forSubscriber:(subscriber)])
//AND
#define EVENT_CHECK_ALL(subscriber,eventNames_array) ([[EventBus busManager] checkEvents_AND:(eventNames_array) forSubscriber:(subscriber)])

/**
 * 发布事件
 * @p   publisher           发布者
 * @p   eventName           事件名
 * @p   eventData_obj       事件相关data            可选
 * @p   life                事件生命长度(异步事件)    可选
 */
#define EVENT_PUBLISH_WITHDATA_LIFE(publisher,eventName,eventData_obj,lifeLength) ([[EventBus busManager] publish:(eventName) eventData:(eventData_obj) by:(publisher) life:(lifeLength)])
#define EVENT_PUBLISH_WITHDATA(publisher,eventName,eventData_obj) EVENT_PUBLISH_WITHDATA_LIFE(publisher,eventName,eventData_obj,0)
#define EVENT_PUBLISH(publisher,eventName) EVENT_PUBLISH_WITHDATA_LIFE(publisher,eventName,nil,0)

/**
 * @class EventBus
 */
@interface EventBus : NSObject

+ (EventBus *)busManager;
- (void)addSubscriber: (id<EventSubscriber>)subscriber event: (NSString *)eventName;
- (void)removeSubscriber: (id<EventSubscriber>)subscriber event: (NSString *)eventName;
- (void)publish:(NSString *)eventName eventData: (id)eventData by:(id<EventPublisher>)publisher life: (int)life;
- (void)checkEvent: (NSString *)eventName forSubscriber: (id<EventAsyncSubscriber>)subscriber;
- (void)checkEvents_OR: (NSArray*)eventNames forSubscriber: (id<EventAsyncSubscriber>)subscriber;
- (void)checkEvents_AND: (NSArray *)eventNames forSubscriber: (id<EventAsyncSubscriber>)subscriber;

//actually , only async event can be retrieved
- (Event *)event: (NSString *)eventName;
//force remove
- (void)remove: (NSString *)eventName;
- (NSArray *)allEvent;

@end

/**
 * @class Event
 * 事件基类
 */
@interface Event : NSObject

@property (nonatomic, assign) int life;
@property (nonatomic, retain) NSString * eventName;
@property (nonatomic, assign) id <EventPublisher> publisher;
@property (nonatomic, retain) id eventData;

@end
/**
 * @class SyncEvent
 * 同步事件类，类似于NSNotification
 */
@interface SyncEvent : Event

@end

/**
 * @class AsyncEvent
 * 异步事件类，可以存储在EventBus中，具有一定的生命时长
 */
@protocol EventAsyncSubscriber;
@interface AsyncEvent : Event

//添加已读订阅者
- (void)markSubscriber: (id<EventAsyncSubscriber>)subscriber;
//注销已读订阅者
- (void)unmarkSubscriber: (id<EventAsyncSubscriber>)subscriber;
//订阅者是否已经阅读过该事件
- (BOOL)hasMarked: (id<EventAsyncSubscriber>)subscriber;

@end



























