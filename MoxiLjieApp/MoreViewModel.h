//
//  MoreViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/7.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface MoreViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *moreList;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSString *catogry;

- (void)getMoreDataWithRefresh:(BOOL)isRefresh type:(NSInteger)type success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

@end
