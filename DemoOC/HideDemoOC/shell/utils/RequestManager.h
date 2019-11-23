//
//  Request.h
//  ConverAppOC
//
//  Created by hello on 2019/3/24.
//  Copyright © 2019 Dio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestManager : NSObject

+ (instancetype)sharedManager;
//-(void)judgeNetworking;//网络监听 方法
/**get请求*/
- (void)getRequest:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
/**post请求*/
- (void)postRequest:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
