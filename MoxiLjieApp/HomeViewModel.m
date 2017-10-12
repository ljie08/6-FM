//
//  HomeViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/6.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (instancetype)init {
    if (self = [super init]) {
        _bannerArr = [NSMutableArray array];
        _categoryArr = [NSMutableArray array];
        _hotFMArr = [NSMutableArray array];
        _newfmArr = [NSMutableArray array];
        _newlessonArr = [NSMutableArray array];
        _diantaiArr = [NSMutableArray array];
        
        _bannerImgArr = [NSMutableArray array];
        _headerArr = [NSArray arrayWithObjects:@"", NSLocalizedString(@"hottuijian", nil), NSLocalizedString(@"newlesson", nil), NSLocalizedString(@"newfm", nil), NSLocalizedString(@"diantaituijian", nil), nil];
        _footerArr = [NSArray arrayWithObjects:@"", @"", NSLocalizedString(@"morelesson", nil), NSLocalizedString(@"morefm", nil), NSLocalizedString(@"morediantai", nil), nil];
    }
    return self;
}

- (void)getHomeFMDataWithSuccess:(void (^)(BOOL))success failture:(void (^)(NSString *))failture {
    @weakSelf(self);
    [[WebManager sharedManager] getHomeFMWithSuccess:^(NSDictionary *dic) {
        weakSelf.bannerArr = [Banner mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"tuijian"]];
        weakSelf.categoryArr = [HomeCategory mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"category"]];
        weakSelf.hotFMArr = [FM mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"hotfm"]];
        weakSelf.newfmArr = [FM mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"newfm"]];
        weakSelf.newlessonArr = [FM mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"newlesson"]];
        weakSelf.diantaiArr = [Author mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"diantai"]];
        
        for (Banner *banner in weakSelf.bannerArr) {
            [weakSelf.bannerImgArr addObject:banner.cover];
        }
        
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

@end
