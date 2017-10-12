//
//  DiscoverViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/7.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface DiscoverViewModel : BaseViewModel

@property (nonatomic, strong) NSDictionary *imgDic;
@property (nonatomic, strong) NSMutableArray *zhuboArr;
@property (nonatomic, strong) NSArray *headerArr;

- (void)getDiscoverDataWithSuccess:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

@end
