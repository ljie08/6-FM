//
//  DiscoverViewModel.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/7.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "DiscoverViewModel.h"

@implementation DiscoverViewModel

- (instancetype)init {
    if (self = [super init]) {
        _imgDic = @{@"0":@"快乐",@"1":@"悲伤",@"2":@"孤独",@"3":@"已弃疗",@"4":@"减压",@"5":@"无奈",@"6":@"烦躁",@"7":@"感动",@"8":@"迷茫",@"10":@"睡前",@"11":@"旅行",@"12":@"散步",@"13":@"坐车",@"14":@"独处",@"15":@"失恋",@"16":@"失眠",@"17":@"随便",@"18":@"无聊"};
        _zhuboArr = [NSMutableArray array];
        _headerArr = [NSArray arrayWithObjects:NSLocalizedString(@"xinqing", nil), NSLocalizedString(@"changjing", nil), NSLocalizedString(@"zhubo", nil), nil];
    }
    return self;
}

- (void)getDiscoverDataWithSuccess:(void (^)(BOOL))success failture:(void (^)(NSString *))failture {
    [[WebManager sharedManager] getDiscoverWithSuccess:^(NSDictionary *dic) {
        @weakSelf(self);
        weakSelf.zhuboArr = [Author mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"data"]];
        success(YES);
    } failure:^(NSString *errorStr) {
        failture(errorStr);
    }];
}

@end
