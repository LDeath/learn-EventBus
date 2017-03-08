//
//  UIBarButtonItem+AN.m
//  ACE
//
//  Created by Eric on 15/7/2.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "UIBarButtonItem+AN.h"

@implementation UIBarButtonItem (AN)

/**
 *  快速创建一个显示图片的item
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon higIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    button.bounds = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

@end
