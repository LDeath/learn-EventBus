//
//  NetWorkTools.h
//  iOS-监测网络变化
//
//  Created by 王德康 on 15/6/14.
//  Copyright (c) 2015年 王德康. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UITabBarController;

@interface NetWorkTools : NSObject
@property(nonatomic, weak) UITabBarController *currentController;

/**
 *  是否WIFI
 */
+ (BOOL)isEnableWIFI;

/**
 *  是否3G
 */
+ (BOOL)isEnable3G;

/**
 *  是否禁用网络
 */
+ (BOOL)isDisabledNetWork;

/**
 *  开始检测网络状态
 */
- (void)checkNetworkState;


@end
