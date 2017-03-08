//
//  Common.m
//  CreditBank
//
//  Created by Eric on 15/4/9.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "Common.h"
#import "NSString+Expand.h"
#import <AdSupport/ASIdentifierManager.h>
//#import "SSKeychain.h"

//#import "IndexViewController.h"
//#import "NavigationController.h"

@implementation Common

/**
 *  网络请求参数加密
 */
//+ (NSString *)paramsSign:(NSArray *)arr {
//    NSString *paramString = [arr componentsJoinedByString:nil];
//    NSString *joinParamString = [NSString stringWithFormat:@"%@%@%@",PLATFORMID,paramString,PLATFORMKEY];
//    return [joinParamString md5];
//}

/**
 *  获取用户token
 */
+ (NSString *)token
{
    // return [SSKeychain passwordForService:SSKEYAPPID account:@"token"];
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}

/**
 *  获取广告标示符
 *
 *  @return <#return value description#>
 */
+ (NSString *)AdvertisingIdentifier {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];

}

/**
 *  用户登录
 *
 *  @param controller 当前登录控制器
 */
+ (void)userLogin:(UIViewController *)controller {
    
//    IndexViewController *indexVc = [[IndexViewController alloc] init];
//    NavigationController *indexNVC = [[NavigationController alloc] initWithRootViewController:indexVc];
//    [controller presentViewController:indexNVC animated:YES completion:nil];
}

/**
 *  获取一个网络图片
 *
 *  @param fileURL 网络图片URL
 *
 *  @return UIImage
 */
+ (UIImage *) getImageFromURL:(NSString *)fileURL {

    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}

/**
 *  自动补全后缀
 *
 *  @param strUrL url字符串
 *
 *  @return 补全后的字符串
 */
+ (NSString *)addSuffix:(NSString *)strUrl {
    
    NSString *url;
    
    // 站内链接增加&src=iOS
    if ([strUrl rangeOfString:HOSTURL].location != NSNotFound) {
        url = [NSString stringWithFormat:@"%@&src=iOS", strUrl];
        
        return url;
    }
    
    return strUrl;
}

/**
 *  自动补全域名
 *
 *  @param strUrl 要补全的URL字符串
 *
 *  @return URL object
 */
+ (NSURL *)autoCompleteURL:(NSString *) strUrl {
    
    
    NSString *allStrUrl;

    // 自动补全域名
    if ([strUrl rangeOfString:@"http://"].location == NSNotFound ) {
        
        allStrUrl = [NSString stringWithFormat:@"%@%@", HOSTURL, strUrl];
    } else {
        allStrUrl = [NSString stringWithFormat:@"%@", strUrl];
    }
    
    // 自动补全后缀,对可能存在中文的字符进行编码
    NSURL *url = [NSURL URLWithString:[Common addSuffix:[allStrUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    return url;
}

/**
 *  设置webView的Cookie
 *  注意web端就不要设置cookie了，否则冲突
 *
 *  @param url 要设置的URL对象
 */
+ (void)setCookie:(NSURL *)url {
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    // 处理cookie
    NSString *encodeCookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"remember_me"];
    if (encodeCookie != nil) {
        
        // Cookie属性数据
        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
        // Cookie 名称
        [cookieProperties setObject:@"remember_me" forKey:NSHTTPCookieName];
        // Cookie 值
        [cookieProperties setObject:encodeCookie forKey:NSHTTPCookieValue];
        // Cookie 域
//        [cookieProperties setObject:[NSString stringWithFormat:@".%@", COOKIEDOMAIN] forKey:NSHTTPCookieDomain];
        // Cookie 要设置的URL
        [cookieProperties setObject:url forKey:NSHTTPCookieOriginURL];
        // Cookie 有效范围
        [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
        // Cookie 的过期时间
        [cookieProperties setObject:[[NSDate alloc] initWithTimeIntervalSinceNow:1463300057] forKey:NSHTTPCookieExpires];
        // 生成Cookie对象
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
        
        //保存相关cookie至进程
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];

    } else {
        // 先清除先前cookie
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        // 删除 remember_me
        for (NSHTTPCookie *tmpCookie in [storage cookies]) {
            if ([tmpCookie.name isEqualToString:@"remember_me"]) {
                [storage deleteCookie:tmpCookie];
            }
        }
    }
}

/**
 *  用户登录后保存用户的token Cookie
 *
 *  @param userId     token
 *  @param rememberMe <#rememberMe description#>
 */
+ (void)saveUserInfo:(NSString *)token rememberMe:(NSString *)rememberMe  {
    
    // 用户ID存储KeyChain
    if (token) {
        // [SSKeychain setPassword:[NSString stringWithFormat:@"%@", token] forService:SSKEYAPPID account:@"token"];
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    }
    
    if (rememberMe) {
        // 保存WebView Cookie
        [[NSUserDefaults standardUserDefaults] setObject:rememberMe forKey:@"remember_me"];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];


}

/**
 *  用户登录后保存用户token，并发送通知更改用户状态
 *
 *  @param userId     token
 *  @param rememberMe <#rememberMe description#>
 */
+ (void)userLoginSaveInfo:(NSString *)token remeberMe:(NSString *)remberMe {
    
    [Common saveUserInfo:token rememberMe:remberMe];
    
    // 通知登录成功
    NSDictionary *tokenDictionary = [NSDictionary dictionaryWithObject:token forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeToken" object:nil userInfo:tokenDictionary];
}

/**
 *  计算文本的高度
 *
 *  @param text    需要计算的尺寸文字
 *  @param maxSize 文字的字体
 *  @param maxSize 文字的最大尺寸
 *
 *  @return <#return value description#>
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    // 需要字体
    NSDictionary *attr = @{NSFontAttributeName : font};
    // 返回实际尺寸
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    
}

/**
 *  在当前字典中是否存在当前Key
 *
 *  @param key   搜索的key
 *  @param dict  字典
 */
+ (BOOL)isKeyDictionary:(NSString *)key dict:(NSDictionary *)dict {
    NSArray *allKey = [dict allKeys];
    return [allKey containsObject:key]; 
 }

/**
 *  获取URL中的Title
 *
 *  @param  NSString   url &title=商城首页
 *  @return NSString
 */
+(NSString *) getURLTitle:(NSString *)url {
     NSMutableArray *urlParamsArray =  (NSMutableArray *)[url componentsSeparatedByString:@"&"];
    if (urlParamsArray.count) {
        for (NSString *params in urlParamsArray) {
            if ([params rangeOfString:@"title"].length > 0) {
                NSMutableArray *paramsArray = (NSMutableArray *)[params componentsSeparatedByString:@"="];
                if (paramsArray.count == 2) {
                    return paramsArray[1];
                }
            }
            
        }
    }
    
    return @"";
}

+ (void)saveCookies
{
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"sessionCookies"];
    [defaults synchronize];
    
}
+ (void)loadCookies
{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
}
@end
