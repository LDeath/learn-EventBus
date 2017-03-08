//
//  ANHttpTool.h
//  LL
//
//  Created by 高赛 on 16/5/24.
//  Copyright © 2016年 高赛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  接口请求成功回调
 *
 *  @param obj  回调的字典对象
 */
typedef void (^Success)(NSURLSessionDataTask *operation, id responseObject);
/**
 *  接口请求失败回调
 *
 *  @param obj  回调的字典对象
 */
typedef void (^Error)(NSURLSessionDataTask *operation, id responseObject);
/**
 *  接口请求错误回调
 *
 *  @param obj  回调的字典对象
 */
typedef void (^Fail)(NSURLSessionDataTask *operation, NSError *error);

@interface ANHttpTool : NSObject

/**
 *  post 请求 (带成功/失败/错误回调)
 *
 *  @param url        请求的URL
 *  @param paramsDic  请求的参数
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success) succBlock errorBlock:(Error) errorBlock failBlock:(Fail) failBlock;
/**
 *  post 请求 (带成功/失败/错误回调)
 *
 *  @param host       域名
 *  @param url        请求的URL
 *  @param paramsDic  请求的参数
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
+ (void)postWithHost:(NSString *)host url:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock;
/**
 *  上传图片 (带成功/失败/错误回调)
 *
 *  @param url         请求的URL
 *  @param paramsDic   提交的参数
 *  @param image       上传的图片
 *  @param compression 图片的压缩质量
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)paramsDic image:(UIImage *)image compression:(CGFloat)compression successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock;

/**
 *  上传图片(host) (带成功/失败/错误回调)
 *
 *  @param host        请求的host
 *  @param url         请求的URL
 *  @param paramsDic   提交的参数
 *  @param image       上传的图片
 *  @param compression 图片的压缩质量
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
+ (void)postWithHost:(NSString *)host url:(NSString *)url params:(NSDictionary *)paramsDic image:(UIImage *)image compression:(CGFloat)compression successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock;

/**
 *  get 请求 (带成功/失败/错误回调)
 *
 *  @param url        请求的URL
 *  @param paramsDic  请求的参数
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success) succBlock errorBlock:(Error) errorBlock failBlock:(Fail) failBlock;

+ (void)getWithHost:(NSString *)host url:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success) succBlock errorBlock:(Error) errorBlock failBlock:(Fail) failBlock;

@end

/**
 *  用来封装文件数据的模型
 */
@interface ANFormData : NSObject

/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end
