//
//  NSDate+Expand.h
//  
//
//  Created by Eric on 15/7/7.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (Expand)

/**
 *  获取当前时间戳
 */
+ (NSString *)getTime;

/**
 *  获取当前的时间 不带时间戳
 */
+ (NSString *)getTimeNotSp;

/**
 *  按正常日期格式返回
 */
- (NSString *)getDateTime;

/**
 *  按正常日期 只返回年月日
 */
- (NSString *)getDate;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

/**
 *  获得时间串 如: 周五 08月07日 14:30
 */
- (NSString *)getDateTimeString;

/**
 *  获取当地时间
 */
+ (NSDate *)getLocalTimeDate;

/**
 *  获取时间 YYYY-MM-dd HH:mm
 */
- (NSString *)getDateYYYYMMddHHmm;

/**
 *  获取距离当前时间的任意一段时间的日期
 */
+ (NSDate *)beforeTime:(NSTimeInterval)seconds;

/**
 *  将时间戳转换成时间
 *
 *  @param strTime   时间戳
 *  @param formatter 所需格式
 *
 *  @return 时间
 */
+ (NSString *)timeStamp:(NSString *)strTime formatter:(NSString *)formatter;

+ (NSString *)createdAtTime:(NSString *)time;

+ (NSDate *)dateFromString:(NSString *)timeStr format:(NSString *)format;

@end
