//
//  ANHttpTool.m
//  LL
//
//  Created by 高赛 on 16/5/24.
//  Copyright © 2016年 高赛. All rights reserved.
//

#import "ANHttpTool.h"
#import "AFNetworking.h"
#import "NetWorkTools.h"
#import "MBProgressHUD.h"

@interface ANHttpTool ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation ANHttpTool

/**
 *  开始网络请求的状态
 */
+ (void)startNetworkActivity {
    // 打开转菊花
//    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//    hud.mode=MBProgressHUDAnimationFade;//枚举类型不同的效果
//    hud.labelText= netStr
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

/**
 *  关闭网络请求的状态
 */
+ (void)stopNetworkActivity {
//    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

/**
 *  post 请求 (带成功/失败/错误回调)
 *
 *  @param url        请求的URL
 *  @param paramsDic  请求的参数
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock
{
    NetWorkTools *netWorkTools = [[NetWorkTools alloc] init];
    
    [netWorkTools checkNetworkState];
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 网络请求开始
    [self startNetworkActivity];
    
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    // 2.发送请求
//        NSString *urlStr = @"";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", HOSTURL, url];

    [mgr POST:urlStr parameters:paramsDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        if ([responseObject[@"success"] boolValue]) {
            // 数据正常
            succBlock(task,responseObject);
        } else {
            // 错误处理
            errorBlock(task,responseObject);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 网络请求结束
        [self stopNetworkActivity];
        //        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
        
        failBlock(task,error);
        ANLog( @"接口错误信息: %@" , error);
        ANLog( @"接口原装数据: %@" , task.response);
    }];
}
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
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)paramsDic image:(UIImage *)image compression:(CGFloat)compression successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock
{
    // 网络被禁用
    if ([NetWorkTools isDisabledNetWork]) {
        return;
    }
    
    // 网络请求开始
    [self startNetworkActivity];
    
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    
    // 2.发送请求
//    NSString *urlStr = @"";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", HOSTURL, url];
    
    // 3.发送请求
    [mgr POST:urlStr parameters:paramsDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {  // 在发送请求之前调用这个block
        // 必须在这里说明要上传哪些文件
        NSData *data = UIImageJPEGRepresentation(image, compression);
        [formData appendPartWithFileData:data name:@"invoice" fileName:paramsDic[@"invoice"] mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        NSString *status = [responseObject objectForKey:@"code"];
        
        if ([status integerValue] == 0) {
            // 数据正常
            succBlock(task,responseObject);
        } else {
            // 错误处理
            errorBlock(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 网络请求结束
        [self stopNetworkActivity];
//        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        failBlock(task,error);
        ANLog( @"接口错误信息: %@" , error);
        ANLog( @"接口原装数据: %@" , task.response);
    }];
}

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
+ (void)postWithHost:(NSString *)host url:(NSString *)url params:(NSDictionary *)paramsDic image:(UIImage *)image compression:(CGFloat)compression successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock
{
    // 网络被禁用
    if ([NetWorkTools isDisabledNetWork]) {
        return;
    }
    
    // 网络请求开始
    [self startNetworkActivity];
    
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    
    // 2.发送请求
    //    NSString *urlStr = @"";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", host, url];
    
    // 3.发送请求
    [mgr POST:urlStr parameters:paramsDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {  // 在发送请求之前调用这个block
        // 必须在这里说明要上传哪些文件
        NSData *data = UIImageJPEGRepresentation(image, compression);
        [formData appendPartWithFileData:data name:@"invoice" fileName:@"" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        NSString *status = [responseObject objectForKey:@"code"];
        
        if ([status integerValue] == 0) {
            // 数据正常
            succBlock(task,responseObject);
        } else {
            // 错误处理
            errorBlock(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 网络请求结束
        [self stopNetworkActivity];
//        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        failBlock(task,error);
        ANLog( @"接口错误信息: %@" , error);
        ANLog( @"接口原装数据: %@" , task.response);
    }];
}
/**
 *  get 请求 (带成功/失败/错误回调)
 *
 *  @param url        请求的URL
 *  @param paramsDic  请求的参数
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success) succBlock errorBlock:(Error) errorBlock failBlock:(Fail) failBlock
{
    // 网络被禁用
    if ([NetWorkTools isDisabledNetWork]) {
        return;
    }
    
    // 网络请求开始
    [self startNetworkActivity];
    
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    
    // 2.发送请求
//    NSString *urlStr = @"";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", HOSTURL, url];
    
    // 3.发送请求
    [mgr GET:urlStr parameters:paramsDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 网络请求结束
        [self stopNetworkActivity];
        NSString *status = [responseObject objectForKey:@"code"];
        
        if ([status integerValue] == 0) {
            // 数据正常
            succBlock(task,responseObject);
        } else {
            // 错误处理
            errorBlock(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        failBlock(task,error);
        ANLog( @"接口错误信息: %@" , error);
        ANLog( @"接口原装数据: %@" , task.response);
    }];
    
}

/**
 *  get 请求 (带成功/失败/错误回调)
 *
 *  @param url        请求的URL
 *  @param paramsDic  请求的参数
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
+ (void)getWithHost:(NSString *)host url:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success) succBlock errorBlock:(Error) errorBlock failBlock:(Fail) failBlock
{
  
    // 网络被禁用
    if ([NetWorkTools isDisabledNetWork]) {
        return;
    }
    
    // 网络请求开始
//    [self startNetworkActivity];
    
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    
   
    // 2.发送请求
    //    NSString *urlStr = @"";
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", host, url];
    
    
    
    NSString *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsCookie];
    [mgr.requestSerializer setValue:cookiesdata forHTTPHeaderField:@"Cookie"];
    
    // 3.发送请求
    [mgr GET:urlStr parameters:paramsDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 网络请求结束
        [self stopNetworkActivity];
        NSString *status = [responseObject objectForKey:@"code"];
        
        if ([status integerValue] == 0) {
            // 数据正常
            succBlock(task,responseObject);
        } else {
            // 错误处理
            errorBlock(task,responseObject);
        }
//        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 网络请求结束
        [self stopNetworkActivity];
//        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
        failBlock(task,error);
        ANLog( @"接口错误信息: %@" , error);
        ANLog( @"接口原装数据: %@" , task.response);
    }];
    
}

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
+ (void)postWithHost:(NSString *)host url:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock
{
    NetWorkTools *netWorkTools = [[NetWorkTools alloc] init];
    
    [netWorkTools checkNetworkState];
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 网络请求开始
//    [self startNetworkActivity];
    
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/javascript", nil];
    // 2.发送请求
    //        NSString *urlStr = @"";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", host, url];
    
    [mgr POST:urlStr parameters:paramsDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        NSString *status = [responseObject objectForKey:@"code"];
        if ([status integerValue] == 0) {
            // 数据正常
            succBlock(task,responseObject);
        } else {
            // 错误处理
            errorBlock(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 网络请求结束
        [self stopNetworkActivity];
        //        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
        
        failBlock(task,error);
        ANLog( @"接口错误信息: %@" , error);
        ANLog( @"接口原装数据: %@" , task.response);
    }];
}



@end
