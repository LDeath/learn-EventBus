//
//  NSDictionary+Expand.m
//  ACE
//
//  Created by Eric on 15/6/30.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "NSDictionary+Expand.h"

@implementation NSDictionary (Expand)

// log NSSet with UTF8 (将UTF8编码格式转成字符串)
- (NSString *) toNSString{
    
    if (![self count]) {
        return nil;
    }
    
    NSString *tempStr1 =
    [[self description] stringByReplacingOccurrencesOfString:@"\\u"
                                                  withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    // 该方法已被废弃,用下面的方法代替
//    NSString *str = [NSPropertyListSerialization propertyListFromData:tempData
//                                                     mutabilityOption:NSPropertyListImmutable
//                                                               format:NULL
//                                                     errorDescription:NULL];
    
    NSString *str = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return str;
}

@end
