//
//  DiscoverRadioViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/7.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "DiscoverRadioViewModel.h"

@implementation DiscoverRadioViewModel

- (instancetype)init {
    if (self = [super init]) {
        _hotListArr = [NSMutableArray array];
        _newlistArr = [NSMutableArray array];
        _headerArr = [NSArray arrayWithObjects:NSLocalizedString(@"newzhubo", nil), NSLocalizedString(@"hotzhubo", nil), nil];
        self.page = 10;
    }
    return self;
}

- (void)getMoreDTDataWithSuccess:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    @weakSelf(self);
    [[WebManager sharedManager] getMoreDTWithSuccess:^(NSDictionary *dic) {
        weakSelf.newlistArr = [Author mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"newlist"]];
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

//更多热门主播
- (void)getAuthorListWithRefresh:(BOOL)isRefresh success:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure {
    @weakSelf(self);
    
    if (isRefresh) {
        self.page = 10;
    } else {
        self.page += 10;
    }
    
    [[WebManager sharedManager] getMoreAuthorWithPage:self.page success:^(NSDictionary *dic) {
        if (weakSelf.hotListArr.count) {
            [weakSelf.hotListArr removeAllObjects];
        }
        weakSelf.hotListArr = [Author mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"data"]];
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failure(errorStr);
    }];
}

@end
