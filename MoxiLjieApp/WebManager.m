//
//  WebManager.m
//  MyWeather
//
//  Created by lijie on 2017/7/27.
//  Copyright © 2017年 lijie. All rights reserved.
//

#import "WebManager.h"

@implementation WebManager

+ (instancetype)sharedManager {
    static WebManager *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://httpbin.org/"]];
    });
    return manager;
}

-(instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 5;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

#pragma mark - Data
//首页
- (void)getHomeFMWithSuccess:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure {
    NSString *url = HomeURL;
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        
        success([dic objectForKey:@"data"]);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

//更多
- (void)getMoreWithType:(NSInteger)type category:(NSString *)category page:(int)page success:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure {
    NSString *url;// = [NSString stringWithFormat:MoreLessonURL, 0, page];
    switch (type) {
        case 1:
            url = [NSString stringWithFormat:CatagoryURL, category, 0, page];
            NSLog(@"CatagoryURL -- \n%@", url);
            break;
        case 2:
            url = [NSString stringWithFormat:MoreLessonURL, 0, page];
            NSLog(@"MoreLessonURL -- \n%@", url);
            break;
        case 3:
            url = [NSString stringWithFormat:MoreFMURL, 0, page];
            NSLog(@"MoreFMURL -- \n%@", url);
            break;
        case 4:
            url = [NSString stringWithFormat:DisCoverChooseURL, category, page, 0];
            NSLog(@"DisCoverChooseURL -- \n%@", url);
            break;
            
        default:
            break;
    }
    //将url种汉字转换成UTF-8
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"final URL -- \n%@", url);
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        
        success(dic);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

//更多电台
- (void)getMoreDTWithSuccess:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure {
    [self requestWithMethod:GET WithUrl:MoreDianTaiURL WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        
        success([dic objectForKey:@"data"]);
        
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}
//更多热门主播
- (void)getMoreAuthorWithPage:(int)page success:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure {
    NSString *url = [NSString stringWithFormat:MoreAnchorURL, 0, page];
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        
        success(dic);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

//主播详情
- (void)getAuthorDetailWithAuthorId:(NSString *)authorId success:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure {
    NSString *url = [NSString stringWithFormat:AnchorDetailURL, authorId];
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        
        success(dic);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}
//主播FM列表
- (void)getAuthorFMWithAuthorId:(NSString *)authorId page:(int)page success:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure {
    
    NSString *url = [NSString stringWithFormat:AnchorJieMuURL, 0, authorId, page];
    
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        
        success(dic);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

//播放信息
- (void)getFMPlayDataWithId:(NSString *)playId success:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure {
    NSString *url = [NSString stringWithFormat:PlayerURL, playId];
    [self requestWithMethod:GET WithUrl:url WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        
        success(dic);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

//发现
- (void)getDiscoverWithSuccess:(void(^)(NSDictionary *dic))success failure:(void(^)(NSString *errorStr))failure {
    [self requestWithMethod:GET WithUrl:DiscoverURL WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        
        success(dic);
    } WithFailureBlock:^(NSError *error) {
        failure(error.localizedDescription);
    }];
}

#pragma mark - request
- (void)requestWithMethod:(HTTPMethod)method
                  WithUrl:(NSString *)url
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
         WithFailureBlock:(requestFailureBlock)failure {
    
    NSLog(@"url --> %@", url);
    
    switch (method) {
        case GET:{
            [self GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);

                failure(error);
            }];
            break;
        }
        case POST:{
            [self POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);

                failure(error);
            }];
            break;
        }
        default:
            break;
    }
}

@end
