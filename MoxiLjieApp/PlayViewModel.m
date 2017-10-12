//
//  PlayViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/8.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "PlayViewModel.h"

@implementation PlayViewModel

- (instancetype)init {
    if (self = [super init]) {
        _play = [[Player alloc] init];
    }
    return self;
}

- (void)getPlayDataWithID:(NSString *)playID success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture {
    @weakSelf(self);
    [[WebManager sharedManager] getFMPlayDataWithId:playID success:^(NSDictionary *dic) {
        weakSelf.play = [Player mj_objectWithKeyValues:[dic objectForKey:@"data"]];
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

@end
