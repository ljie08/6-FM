//
//  MoreViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/7.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "MoreViewModel.h"

@implementation MoreViewModel

- (instancetype)init {
    if (self = [super init]) {
        _moreList = [NSMutableArray array];
        _page = 10;
    }
    return self;
}

- (void)getMoreDataWithRefresh:(BOOL)isRefresh type:(NSInteger)type success:(void (^)(BOOL))success failture:(void (^)(NSString *))failture {
    if (isRefresh) {
        self.page = 10;
    } else {
        self.page += 10;
    }
    self.catogry = [self.catogry stringByRemovingPercentEncoding];
    @weakSelf(self);
    [[WebManager sharedManager] getMoreWithType:type category:self.catogry page:self.page success:^(NSDictionary *dic) {
        weakSelf.moreList = [FM mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"data"]];
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

@end
