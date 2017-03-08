//
//  UIBarButtonItem+AN.h
//  ACE
//
//  Created by Eric on 15/7/2.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (AN)

/**
 *  快速创建一个显示图片的item
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon higIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

@end
