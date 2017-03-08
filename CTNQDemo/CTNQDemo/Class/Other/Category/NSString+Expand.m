//
//  NSString+Expand.m
//  ACE
//
//  Created by Eric on 15/6/30.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "NSString+Expand.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Expand)

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


+ (NSString *)encodeString:(NSString *)unencodedString
{
    
    NSString *encodedString = [unencodedString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@" :!$'@,`#%^{}\"()（）[]=&|\\<>/;~#"].invertedSet];
    [encodedString stringByRemovingPercentEncoding];
    
    return encodedString;
}



+ (NSString *)retSizebitString:(NSInteger)size
{
    
    char data[size];
    
    for (int x = 0; x < size; data[x++] = (char)('a' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:size encoding:NSUTF8StringEncoding];
    
}

- (NSString *)hyb_URLEncode {
    NSString *newString =
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    return self;
}

@end
