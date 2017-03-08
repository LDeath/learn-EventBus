//
//  ANCommon.h
//  ACE
//
//  Created by Eric on 15/7/7.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ANCommon : NSObject

/**
 *  弹出提示框
 *
 *  @param message 提示信息
 */
+ (void)setAlertViewWithMessage:(NSString *)message;

/**
 *  弹出提示框(不带确认按钮)
 
 *
 *  @param message 提示信息
 */
- (void)setAlertView:(NSString *)message;

/**
 *  弹出带标题的提示框
 */
+ (void)setAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message andVC:(UIViewController *)viewController;
/**
 *  根据参数列表返回加密串
 */
+ (NSDictionary *)dicToSign:(NSDictionary *)dic;

+ (NSDictionary *)dicToSignWithPars_string:(NSDictionary *)dic;

/**
 *  获取用户token
 */
+ (NSString *)token;
/**
 *  根据城市id获取城市名称
 */
+ (NSString *)returnCityNameWithCityID:(NSString *)cityID;
/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
/**
 *  设置UIButton的圆角与边框
 *
 *  @param view 要设置的控件
 *
 *  @return 设置好的控件
 */
+ (UIButton *)setBtnRadiusAndBorder:(UIButton *)btn;

/**
 *  设置Label的圆角与边框
 *
 *  @param view 要设置的控件
 *
 *  @return 设置好的控件
 */
+ (UILabel *)setRadiusAndBorder:(UILabel *)btn;

/**
 *  设置控件指定的圆角
 *
 *  @param view       需要设置的控件
 *  @param rectCorner 指定控件某个角
 */
+ (void)setDesignatRound:(UIView *)view rectCorner:(UIRectCorner)rectCorner;
+ (UIView *)errorViewWithColor:(UIColor *)color Message:(NSString *)message;

/**
 *  数组排序
 *
 *  @param arr <#arr description#>
 *
 *  @return <#return value description#>
 */
+ (NSArray *)arrSort:(NSArray *)arr;

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;


/**
 *  根据图片url获取图片尺寸
 *
 *  @param imageURL <#imageURL description#>
 *
 *  @return <#return value description#>
 */
+(CGSize)getImageSizeWithURL:(id)imageURL;

/**
 *  手机号码验证
 *
 *  @param mobileNumbel 传入的手机号码
 *
 *  @return 格式正确返回true  错误 返回fals
 */
+ (BOOL)isMobile:(NSString *)mobileNumbel;

/**
 *  邮箱验证
 *
 *  @param email 邮件地址
 *
 *  @return 是否为有效邮箱
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 *  过滤首尾的空格键
 *
 *  @param string 过滤前
 *
 *  @return 过滤后
 */
+ (NSString *)filtrationSpaceKey:(NSString *)string;

/**
 *  替换还有表情的字符串 用来算高度
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)calculationString:(NSString *)str;

/**
 *  设置cookie
 */
+ (void)setCookie;
@end
