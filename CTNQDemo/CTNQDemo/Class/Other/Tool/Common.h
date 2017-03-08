//
//  Common.h
//  CreditBank
//
//  Created by Eric on 15/4/9.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class UIViewController;
@class UIImage;

@interface Common : NSObject
/**
 *  根据参数列表返回加密串
 */
+ (NSString *)paramsSign:(NSArray *)arr;
/**
 *  获取用户ID

 */
+ (NSString *)token;
/**
 *  获取广告的唯一标示符
 *
 */
+ (NSString *)AdvertisingIdentifier;

/**
 *  调用登录窗口
 */
+ (void)userLogin:(UIViewController *)controller;

/**
 *  加载网络图片
 */
+ (UIImage *)getImageFromURL:(NSString *)fileURL;

/**
 *  自动补全URL
 */
+ (NSURL *)autoCompleteURL:(NSString *) strUrl;
/**
 * WebView 设置Cookie
 *
 */
+ (void)setCookie:(NSURL *)url;

/**
 *  根据文本计算宽高
 *
 *  @param text    字符串对象
 *  @param font    使用的字体
 *  @param maxSize 最大的区域
 *
 *  @return CGSize
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
/**
 *  用户登录后保存用户token，并发送通知更改用户状态
 *
 *  @param userId     token
 *  @param rememberMe <#rememberMe description#>
 */
+ (void)userLoginSaveInfo:(NSString *)token remeberMe:(NSString *)remberMe;
/**
 *  在当前字典中是否存在当前Key
 *
 *  @param key   搜索的key
 *  @param dict  字典
 */
+(BOOL)isKeyDictionary:(NSString *)key dict:(NSDictionary *)dict;
/**
 *  获取URL中的Title
 *
 *  @param  NSString   url
 *  @return NSString
 */
+(NSString *)getURLTitle:(NSString *)url;
@end
