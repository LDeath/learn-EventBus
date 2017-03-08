//
//  NSString+Expand.h
//  ACE
//
//  Created by Eric on 15/6/30.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Expand)

- (NSString *)md5;

/**
 *  URLCode转换
 *
 *  @param unencodedString <#unencodedString description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)encodeString:(NSString *)unencodedString;

+ (NSString *)encodeStringWithPars_string:(NSString *)unencodedString;

/**
 *  随机产生n位字符串
 *
 *  @return <#return value description#>
 */
+ (NSString *)retSizebitString:(NSInteger)size;

- (NSString *)hyb_URLEncode;

@end
