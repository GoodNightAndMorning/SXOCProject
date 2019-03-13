//
//  SXRequest.m
//  SXBaseLayer
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019年 zsx. All rights reserved.
//

#import "SXRequest.h"
#import "SXBaseModel.h"
#import <MJExtension/MJExtension.h>
#import <AFNetworking/AFNetworking.h>
@implementation SXRequest

/**
 字典转url路径参数

 @param parameters 参数字典
 @param url 路径
 @return 带参数的路径
 */
+(NSString *)getParametersStr:(NSDictionary *)parameters url:(NSString *)url{
    NSString *str = @"";
    str = [str stringByAppendingString:url];
    for (int i = 0; i < parameters.allKeys.count; i++) {
        if (i == 0) {
            str = [str stringByAppendingString:@"?"];
        }else{
            str = [str stringByAppendingString:@"&"];
        }
        str = [str stringByAppendingString:parameters.allKeys[i]];
        str = [str stringByAppendingString:@"="];
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@",parameters[parameters.allKeys[i]]]];
    }
    return str;
}

/**
 请求成功后的数据处理

 @param task task
 @param responseObject responseObject
 @param block block
 */
+(void)successWithTask:(NSURLSessionDataTask * _Nonnull)task andResponseObject:(id  _Nullable)responseObject andBlock:(SuccessCallBack)block {
    SXBaseModel *model = [SXBaseModel mj_objectWithKeyValues:responseObject];
    NSLog(@"\n-------------请求数据-------------\n%@",model.data);
    if (block) {
        block(model);
    }
}

/**
 请求失败处理

 @param task task
 @param error error
 @param block block
 */
+(void)failureWith:(NSURLSessionDataTask * _Nonnull)task andEorror:(NSError * _Nonnull)error andBlock:(FailureCallBack)block {
    if (block) {
        block(error);
    }
}

/**
 post请求

 @param url url
 @param parameters parameters
 @param successCallBack successCallBack
 @param failureCallBack failureCallBack
 */
+(void)postWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(SuccessCallBack)successCallBack failure:(FailureCallBack)failureCallBack{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    //允许非权威机构颁发的证书
    //    manager.securityPolicy.allowInvalidCertificates = YES;
    //    //也不验证域名一致性
    //    manager.securityPolicy.validatesDomainName = NO;
    //    //关闭缓存避免干扰测试
    //    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    //
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"multipart/form-data", @"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain", nil];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
//    if ([LWUserManager shareInstance].nowUser) {
//        NSString *token = [NSString stringWithFormat:@"Bearer %@", [LWUserManager shareInstance].nowUser.accessToken];
//        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
//    }
    

    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n-------------请求url-------------\n%@",url);
        NSLog(@"\n-------------完整url-------------\n%@",[self getParametersStr:parameters url:url]);
        NSLog(@"\n-------------请求参数-------------\n%@",parameters);
        [self successWithTask:task andResponseObject:responseObject andBlock:successCallBack];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n<<============================>>");
        NSLog(@"\n-------------请求url-------------\n%@",url);
        NSLog(@"\n-------------请求参数-------------\n%@",parameters);
        NSLog(@"\n-------------请求失败-------------\n");
        [self failureWith:task andEorror:error andBlock:failureCallBack];
    }];
}
/**
 put请求
 
 @param url url
 @param parameters parameters
 @param successCallBack successCallBack
 @param failureCallBack failureCallBack
 */
+(void)putWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(SuccessCallBack)successCallBack failure:(FailureCallBack)failureCallBack{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"multipart/form-data", @"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain", nil];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
//    if ([LWUserManager shareInstance].nowUser) {
//        NSString *token = [NSString stringWithFormat:@"Bearer %@", [LWUserManager shareInstance].nowUser.accessToken];
//        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
//    }
    [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n-------------请求url-------------\n%@",url);
        NSLog(@"\n-------------完整url-------------\n%@",[self getParametersStr:parameters url:url]);
        NSLog(@"\n-------------请求参数-------------\n%@",parameters);
        [self successWithTask:task andResponseObject:responseObject andBlock:successCallBack];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n<<============================>>");
        NSLog(@"\n-------------请求url-------------\n%@",url);
        NSLog(@"\n-------------请求参数-------------\n%@",parameters);
        NSLog(@"\n-------------请求失败-------------\n");
        [self failureWith:task andEorror:error andBlock:failureCallBack];
    }];
}
/**
 get请求
 
 @param url url
 @param parameters parameters
 @param successCallBack successCallBack
 @param failureCallBack failureCallBack
 */
+(void)getWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(SuccessCallBack)successCallBack failure:(FailureCallBack)failureCallBack{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"multipart/form-data", @"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain", nil];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
//    if ([LWUserManager shareInstance].nowUser) {
//        NSString *token = [NSString stringWithFormat:@"Bearer %@", [LWUserManager shareInstance].nowUser.accessToken];
//        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
//    }
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n-------------请求url-------------\n%@",url);
        NSLog(@"\n-------------完整url-------------\n%@",[self getParametersStr:parameters url:url]);
        NSLog(@"\n-------------请求参数-------------\n%@",parameters);
        
        [self successWithTask:task andResponseObject:responseObject andBlock:successCallBack];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n<<============================>>");
        NSLog(@"\n-------------请求url-------------\n%@",url);
        NSLog(@"\n-------------请求参数-------------\n%@",parameters);
        NSLog(@"\n-------------请求失败-------------\n");
        [self failureWith:task andEorror:error andBlock:failureCallBack];
    }];
}


//+(void)getShareTaskRedBagRequestWithParams:(NSObject *)params success:(SuccessCallBack)successCallBack failure:(FailureCallBack)failureCallBack{
//    NSDictionary *par = [params mj_keyValues];
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@",AccountUrl,@"api/ShareMarket/GetShareTaskRedBag"];
//    NSString *fullUrl = [self getParametersStr:par url:urlStr];
//    [self getWithUrl:fullUrl parameters:par success:successCallBack failure:failureCallBack];
//}
@end
