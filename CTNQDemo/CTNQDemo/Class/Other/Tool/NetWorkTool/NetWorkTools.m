//
//  NetWorkTools.m
//  iOS-监测网络变化
//
//  Created by 王德康 on 15/6/14.
//  Copyright (c) 2015年 王德康. All rights reserved.
//

#import "NetWorkTools.h"
#import "Reachability.h"
#import "MBProgressHUD+MJ.h"

@interface NetWorkTools()
/**
 *  监控网络类
 */
@property(nonatomic, strong) Reachability *reachability;
@end

@implementation NetWorkTools
// 是否WIFI
+ (BOOL)isEnableWIFI {
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

// 是否3G
+ (BOOL)isEnable3G {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

// 检测是否有网
+ (BOOL)isDisabledNetWork {
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        return YES;
    }
    return  NO;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        
        // 监听网络状态发生改变的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
        
        // 获得Reachability对象
        self.reachability = [Reachability reachabilityForInternetConnection];
        
        // 开始监控网络
        [self.reachability startNotifier];
    }
    
    return self;
}

- (void)networkStateChange
{
    [self checkNetworkState];
}

/**
 *  监测网络状态
 */
- (void)checkNetworkState
{
    if ([NetWorkTools isDisabledNetWork]) {
        ANLog(@"网络被禁用");
    }
    
    if (self.currentController) {
//         ANNavigationController *navController  = (ANNavigationController *)self.currentController.selectedViewController;
//        ANLog(@"%@", navController.viewControllers.lastObject);
    }
    
    
    if ([NetWorkTools isEnableWIFI]) {
//         [MBProgressHUD showSuccess:@"网络切换到WIFI"];
    } else if ([NetWorkTools isEnable3G]) {
//         [MBProgressHUD showSuccess:@"网络切换到3G"];
    } else {
        [MBProgressHUD showError:@"网络连接失败"];
//         [MBProgressHUD showSuccess:@"网络连接失败"];
    }
}



- (void)dealloc
{
    // 停止监控
    [self.reachability stopNotifier];
    self.reachability = nil;
}
@end
