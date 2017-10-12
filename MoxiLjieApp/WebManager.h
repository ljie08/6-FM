//
//  WebManager.h
//  MyWeather
//
//  Created by lijie on 2017/7/27.
//  Copyright © 2017年 lijie. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

//请求成功回调block
typedef void (^requestSuccessBlock)(NSDictionary *dic);

//请求失败回调block
typedef void (^requestFailureBlock)(NSError *error);

//请求方法define
typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;


@interface WebManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

#pragma mark - Data
//首页
- (void)getHomeFMWithSuccess:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure;
//更多
- (void)getMoreWithType:(NSInteger)type category:(NSString *)category page:(int)page success:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure;

//更多电台
- (void)getMoreDTWithSuccess:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure;
//更多热门主播
- (void)getMoreAuthorWithPage:(int)page success:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure;

//主播详情
- (void)getAuthorDetailWithAuthorId:(NSString *)authorId success:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure;
//主播FM列表
- (void)getAuthorFMWithAuthorId:(NSString *)authorId page:(int)page success:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure;

//播放信息
- (void)getFMPlayDataWithId:(NSString *)playId success:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure;

//发现
- (void)getDiscoverWithSuccess:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure;


#pragma mark - request
- (void)requestWithMethod:(HTTPMethod)method
                 WithUrl:(NSString *)url
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailureBlock:(requestFailureBlock)failure;

@end
