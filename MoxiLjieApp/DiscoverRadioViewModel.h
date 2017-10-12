//
//  DiscoverRadioViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/7.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface DiscoverRadioViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *hotListArr;
@property (nonatomic, strong) NSMutableArray *newlistArr;

@property (nonatomic, strong) NSArray *headerArr;

@property (nonatomic, assign) int page;

- (void)getMoreDTDataWithSuccess:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

- (void)getAuthorListWithRefresh:(BOOL)isRefresh success:(void(^)(BOOL result))success failure:(void(^)(NSString *errorStr))failure;

@end
