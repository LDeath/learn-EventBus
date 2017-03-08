//
//  UIImageView+AN.m
//  DianDongBang
//
//  Created by Eric on 16/10/13.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "UIImageView+AN.h"
#import "AFNetworkReachabilityManager.h"

@implementation UIImageView (AN)

- (void)an_setImageWithUrl:(NSString *)imageUrl placeholderImage:(NSString *)placeholderImage
{
    
    // 占位图片
    UIImage *placeholder = [UIImage imageNamed:@"news_test"];
    // 从内存\沙盒缓存中获得原图
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageUrl];
    if (originalImage) { // 如果内存\沙盒缓存有原图，那么就直接显示原图（不管现在是什么网络状态）
        [self sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholder];
    } else { // 内存\沙盒缓存没有原图
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        if (mgr.isReachableViaWiFi) { // 在使用Wifi, 下载原图
            [self sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholder];
        } else if (mgr.isReachableViaWWAN) { // 在使用手机自带网络
            
#warning 从沙盒中读取用户的配置项：在3G\4G环境是否仍然下载原图
            BOOL alwaysDownloadOriginalImage = [[NSUserDefaults standardUserDefaults] boolForKey:@"alwaysDownloadOriginalImage"];
            //            BOOL alwaysDownloadOriginalImage = YES;
            if (!alwaysDownloadOriginalImage) { // 下载原图
                [self sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholder];
            } else { // 下载小图
                [self setImage:placeholder];
            }
        } else { // 没有网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageUrl];
            if (thumbnailImage) { // 内存\沙盒缓存中有小图
                [self sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholder];
            } else {
                [self sd_setImageWithURL:nil placeholderImage:placeholder];
            }
        }
    }
    
}

@end
