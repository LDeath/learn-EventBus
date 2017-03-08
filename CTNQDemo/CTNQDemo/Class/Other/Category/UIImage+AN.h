//
//  UIImage+AN.h
//  ACE
//
//  Created by Eric on 15/6/30.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AN)

/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

/**
 *  通过颜色生成纯色图片
 */
+ (UIImage *)imageCreateFromColor:(UIColor *)color;

/**
 *  通过url获取图片
 */
+ (UIImage *)getImageFromURL:(NSString *)fileURL;

+ (UIImage *)originImageWithName:(NSString *)name;

- (UIImage *)circleImage;

@end
