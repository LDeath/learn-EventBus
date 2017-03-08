//
//  ANCommon.m
//  ACE
//
//  Created by Eric on 15/7/7.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "ANCommon.h"
#import "NSDate+Expand.h"
#import "NSDictionary+Expand.h"

@interface ANCommon()

/**
 *  不带确认按钮的提示框
 */
@property (nonatomic, strong) UIAlertView *myAlert;

@end

@implementation ANCommon

/**
 *  网络请求参数构造(包括加密）
 *
 *  @param dic 原始字典数据
 *
 *  @return dic 组合完成的字典数据
 */
+ (NSDictionary *)dicToSign:(NSDictionary *)dic {
    
    // 组合参数
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
//    if (![ANCommon token]) {
//         [mutableDic setObject:PLATFORMID forKey:@"source"];
//        [mutableDic setObject:[NSDate getTime] forKey:@"time"];
//        [mutableDic setObject:PLATFORMKEY forKey:@"key"];
//    } else {
//        [mutableDic setObject:PLATFORMID forKey:@"source"];
//        [mutableDic setObject:[NSDate getTime] forKey:@"time"];
//        [mutableDic setObject:PLATFORMKEY forKey:@"key"];
//        [mutableDic setObject:[ANCommon token] forKey:@"token"];
//    }
    
    // 排序
    NSArray *paramsKeys = [self stringSort:mutableDic];
    
    if (paramsKeys) {
        for (NSString *key in paramsKeys) {
            NSString *val = [NSString stringWithFormat:@"%@", [mutableDic objectForKey:key]];
            // 过滤每个值中的空格
            val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            [mutableDic setObject:val forKey:key];
        }
    }
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSString *key in [mutableDic allKeys]) {
        NSString *valur = [mutableDic valueForKey:key];
        NSString *strSpac = [[NSString encodeString:valur] stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
        
        NSString *encodeKey = key;
        if ([key containsString:@"images["]) {
             encodeKey = [NSString encodeString:key];
        }
        NSString *str = [NSString stringWithFormat:@"%@=%@", encodeKey, strSpac];
        [tempArr addObject:str];
    }
//    [self arrSort:tempArr];
    
    // 参数用&拼接起来
    NSString *strWithComponent = [[self arrSort:tempArr] componentsJoinedByString:@"&"];
    
    // 最后面拼接token
//    NSString *strWithToken = [strWithComponent stringByAppendingString:TOKEN];
 
    // 将参数转URLencode
//    ANLog(@"1----%@", strWithToken);
//    strWithToken = [strWithToken stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPasswordAllowedCharacterSet]];
    
//    strWithToken = [NSString encodeString:strWithToken];
//    ANLog(@"2----%@", strWithToken);

    // 加密
//    [mutableDic setObject:[strWithToken md5] forKey:@"sign"];
    
//    ANLog(@"sing: %@", mutableDic);
    // appid不参与加密
//    [mutableDic setValue:APPID forKey:@"appid"];

    // 加密
    return mutableDic;
        
}



/**
 *  字典按照字母排序(升序)
 *
 *  @param dic 需要排序的字典
 *
 *  @return 返回排序完成的字典
 */
+ (NSArray *)stringSort:(NSDictionary *)dic{
    
    NSComparator cmptr = ^(id obj1, id obj2){
        if([[NSString stringWithFormat:@"%@",obj1] compare:[NSString stringWithFormat:@"%@",obj2] options:NSNumericSearch] > 0) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if([[NSString stringWithFormat:@"%@",obj1] compare:[NSString stringWithFormat:@"%@",obj2] options:NSNumericSearch] < 0) {
                return (NSComparisonResult)NSOrderedAscending;
            }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    NSMutableArray *arrKeys = (NSMutableArray *)[dic allKeys];
    
    NSArray *array = [arrKeys sortedArrayUsingComparator:cmptr];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSString *str in array) {
        
        
        
        [arr addObject:[dic objectForKey:str]];
    }
    
    return array;
}

+ (NSArray *)arrSort:(NSArray *)arr{
    
    NSComparator cmptr = ^(id obj1, id obj2){
        if([[NSString stringWithFormat:@"%@",obj1] compare:[NSString stringWithFormat:@"%@",obj2] options:NSNumericSearch] > 0) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if([[NSString stringWithFormat:@"%@",obj1] compare:[NSString stringWithFormat:@"%@",obj2] options:NSNumericSearch] < 0) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    NSArray *array = [arr sortedArrayUsingComparator:cmptr];
    
    return array;
}

/**
 *  获取用户token
 */
+ (NSString *)token
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}
/**
 *  根据城市id获取城市名称
 */
+ (NSString *)returnCityNameWithCityID:(NSString *)cityID
{
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"cityName" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:pathStr];
    NSString *cityName = dict[cityID];
    return cityName;
}
/**
 *  弹出带标题的提示框
 */
+ (void)setAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message andVC:(UIViewController *)viewController
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:viewController cancelButtonTitle:@"呼叫" otherButtonTitles:@"取消", nil];
    [alertView show];
}
/**
 *  弹出提示框
 *
 *  @param message 提示信息
 */
+ (void)setAlertViewWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}
/**
 *  弹出提示框(不带确认按钮)
 *
 *  @param message 提示信息
 */
- (void)setAlertView:(NSString *)message
{

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
    self.myAlert = alertView;
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
    [alertView show];
    
}

/**
 *  设置Label的圆角与边框
 *
 *  @param btn 要设置的控件
 *
 *  @return 设置好的控件
 */
+ (UILabel *)setRadiusAndBorder:(UILabel *)btn
{
    btn.layer.cornerRadius = 15;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor colorWithRed:235/255 green:240/255 blue:240/255 alpha:0.1].CGColor;
    return btn;
}
- (void)performDismiss:(NSTimer *)timer
{
    [self.myAlert dismissWithClickedButtonIndex:0 animated:YES];
}

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
/**
 *  设置UIButton的圆角与边框
 *
 *  @param btn 要设置的控件
 *
 *  @return 设置好的控件
 */
+ (UIButton *)setBtnRadiusAndBorder:(UIButton *)btn
{
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor colorWithRed:235/255 green:240/255 blue:240/255 alpha:0.1].CGColor;
    return btn;
}
/**
 *  设置控件指定的圆角
 *
 *  @param view       需要设置的控件
 *  @param rectCorner 指定控件某个角
 */
+ (void)setDesignatRound:(UIView *)view rectCorner:(UIRectCorner)rectCorner
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
+ (UIView *)errorViewWithColor:(UIColor *)color Message:(NSString *)message
{
    UIView *errorView = [[UIView alloc] initWithFrame:CGRectMake(0, -84, WIDTH, 64)];
    errorView.backgroundColor = color;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, WIDTH - 40, 44)];
    titleLabel.text = message;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.numberOfLines = 0;
    [errorView addSubview:titleLabel];
    return errorView;
}

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


/**
 *  根据图片url获取图片尺寸
 *
 *  @param imageURL <#imageURL description#>
 *
 *  @return <#return value description#>
 */
+(CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}
//  获取PNG图片的大小
+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取gif图片的大小
+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
//    ANLog(@"--%ld", data.length);
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        
//        ANLog(@"%@", data);
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

/**
 *  手机号码验证
 *
 *  @param mobileNumbel 传入的手机号码
 *
 *  @return 格式正确返回true  错误 返回fals
 */
+ (BOOL)isMobile:(NSString *)mobileNumbel{
    /**
     * 手机号码
     * 虚拟运营: 170
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,178
     * 联通：130,131,132,152,155,156,185,186,176
     * 电信：133,1349,153,180,189,181,177(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|7[06-8]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|78|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|76|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181,177(增加)
     22         */
    NSString * CT = @"^1((33|53|8[019]|77)[0-9]|349)\\d{7}$";
    
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        return YES;
    }
    
    return NO;
}

/**
 *  邮箱验证
 *
 *  @param email 邮件地址
 *
 *  @return 是否为有效邮箱
 */
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *  过滤首尾的空格键
 *
 *  @param string 过滤前
 *
 *  @return 过滤后
 */
+ (NSString *)filtrationSpaceKey:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


+ (NSString *)calculationString:(NSString *)str
{
    if (str.length != 0) {
        NSMutableString *mutableStr = [NSMutableString stringWithString:str];
        NSArray *frontArr = [str componentsSeparatedByString:@"["];
        NSArray *backArr = [str componentsSeparatedByString:@"]"];
        
        NSArray *numFrontArr = [ANCommon calculationPositionWithArray:frontArr withFirstStr:[str substringToIndex:1]];
        NSArray *numBackArr = [ANCommon calculationPositionWithArray:backArr withFirstStr:[str substringToIndex:1]];
        
        for (int i = 0; i < numFrontArr.count; i ++) {
            NSString *frontStr = numFrontArr[i];
            NSString *backStr = numBackArr[i];
            int frontNum = [frontStr intValue];
            int backNum = [backStr intValue];
            NSRange range = NSMakeRange(frontNum, backNum - frontNum + 1);
            //        NSLog(@"%d,%d,%d",frontNum,backNum,backNum - frontNum + 1);
            [mutableStr deleteCharactersInRange:range];
            
            mutableStr = [NSMutableString stringWithFormat:@"%@😄",mutableStr];
        }
        return [NSString stringWithString:mutableStr];
    } else {
        return @" ";
    }
}
+ (NSArray *)calculationPositionWithArray:(NSArray *)arr withFirstStr:(NSString *)str
{
    NSMutableArray *numArr = [NSMutableArray array];
    int num = -1;
    for (int i = 0; i < arr.count; i++) {
        NSString *comStr = arr[i];
        if (i == arr.count - 1) {
            num += comStr.length;
        }else {
            num += comStr.length + 1;
        }
        [numArr addObject:[NSString stringWithFormat:@"%d", num]];
    }
    [numArr removeLastObject];
    return [[numArr reverseObjectEnumerator] allObjects];
}

+ (void)setCookie {
    
    NSMutableDictionary *cookiePropertiesCID = [NSMutableDictionary dictionary];
    [cookiePropertiesCID setObject:@"3017-03-08 08:32:44 +0000" forKey:NSHTTPCookieExpires];
    [cookiePropertiesCID setObject:@"cityId" forKey:NSHTTPCookieName];
//    [cookiePropertiesCID setObject:CITYID forKey:NSHTTPCookieValue];
    [cookiePropertiesCID setObject:@".diandong.com" forKey:NSHTTPCookieDomain];
    [cookiePropertiesCID setObject:@"/" forKey:NSHTTPCookiePath];
    NSHTTPCookie *cookieCID = [NSHTTPCookie cookieWithProperties:cookiePropertiesCID];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieCID];
    
    NSMutableDictionary *cookiePropertiesCNAME = [NSMutableDictionary dictionary];
    [cookiePropertiesCNAME setObject:@"3017-03-08 08:32:44 +0000" forKey:NSHTTPCookieExpires];
    [cookiePropertiesCNAME setObject:@"cityName" forKey:NSHTTPCookieName];
//    [cookiePropertiesCNAME setObject:CITYNAME forKey:NSHTTPCookieValue];
    [cookiePropertiesCNAME setObject:@".diandong.com" forKey:NSHTTPCookieDomain];
    [cookiePropertiesCNAME setObject:@"/" forKey:NSHTTPCookiePath];
    NSHTTPCookie *cookieCNAME= [NSHTTPCookie cookieWithProperties:cookiePropertiesCNAME];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieCNAME];
}

@end
