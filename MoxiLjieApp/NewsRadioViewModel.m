//
//  NewsRadioViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/7.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "NewsRadioViewModel.h"

@implementation NewsRadioViewModel

- (instancetype)init {
    if (self = [super init]) {
        _authorFMArr = [NSMutableArray array];
        _page = 10;
    }
    return self;
}

- (void)getAuthorWithAuthorID:(NSString *)authorID success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    @weakSelf(self);
    [[WebManager sharedManager] getAuthorDetailWithAuthorId:authorID success:^(NSDictionary *dic) {
        weakSelf.author = [Author mj_objectWithKeyValues:[dic objectForKey:@"data"]];
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

- (void)getAuthorFMListWithAuthorID:(NSString *)authorID isRefresh:(BOOL)isRefresh success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    @weakSelf(self);
    
    if (isRefresh) {
        self.page = 10;
    } else {
        self.page += 10;
    }
    [[WebManager sharedManager] getAuthorFMWithAuthorId:authorID page:self.page success:^(NSDictionary *dic) {
        if (weakSelf.authorFMArr.count) {
            [weakSelf.authorFMArr removeAllObjects];
        }
        weakSelf.authorFMArr = [Author mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"data"]];
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

@end
