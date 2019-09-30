//
//  Request.m
//  ConverAppOC
//
//  Created by hello on 2019/3/24.
//  Copyright © 2019 Dio. All rights reserved.
//

#import "RequestManager.h"
#import <CommonCrypto/CommonDigest.h>
#import <AFNetworking.h>

static RequestManager *staticInstance = nil;

@implementation RequestManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticInstance = [[super allocWithZone:NULL] init];
    });
    return staticInstance;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [RequestManager sharedManager];
}

-(id)copyWithZone:(struct _NSZone *)zone{
    return [RequestManager sharedManager];
}

//对string进行base64加密
-(NSString *)base64EncodeString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
//对string进行md5加密
- (NSString *)md5:(NSString *)Getmd5string {
    const char *cStr = [Getmd5string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//获取BundleID
-(NSString*) getBundleID {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

#pragma mark - 设置请求的配置
- (void)setRequestWithManager:(AFHTTPSessionManager *)manager {
    manager.requestSerializer.timeoutInterval = 10;//超时
    [manager.securityPolicy setAllowInvalidCertificates:NO];//设置请求证书,来进行ssl验证
    AFJSONResponseSerializer *response=[AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues=YES;
    manager.responseSerializer=response;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
    //设置请求头
    [manager.requestSerializer setValue:[self getBundleID] forHTTPHeaderField:@"d"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"c"];
}

//对请求参数进行加密
-(NSDictionary *)getNewParameter:(id)parameter {
    NSData *jsonData= [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:nil];
    NSString *objectStr=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *object = [self base64EncodeString:objectStr];
    NSString *signstr = [object stringByAppendingString:@"123456"];
    NSString *sign = [self md5:signstr];
    NSDictionary *newparameter = @{@"object":object,@"sign":sign};
    return newparameter;
}

#pragma mark - post请求
- (void)postRequest:(NSString *)url parameters:(id)parameters success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self setRequestWithManager:manager];
    NSDictionary *newparameter = [self getNewParameter:parameters];
//    NSLog(@"%@", newparameter);
    [manager POST:url parameters:newparameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

#pragma mark - get请求
- (void)getRequest:(NSString *)url parameters:(id)parameters success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self setRequestWithManager:manager];
    NSDictionary *newparameter = [self getNewParameter:parameters];
    [manager GET:url parameters:newparameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

@end
