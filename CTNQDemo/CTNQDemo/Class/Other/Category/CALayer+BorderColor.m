//
//  CALayer+BorderColor.m
//  DianDongBang
//
//  Created by Eric on 16/6/30.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CALayer+BorderColor.h"

@implementation CALayer (BorderColor)

- (void)setBorderColorWithUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

@end
