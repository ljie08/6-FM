//
//  HomeViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/6.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface HomeViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *bannerArr;
@property (nonatomic, strong) NSMutableArray *categoryArr;
@property (nonatomic, strong) NSMutableArray *hotFMArr;
@property (nonatomic, strong) NSMutableArray *newfmArr;
@property (nonatomic, strong) NSMutableArray *newlessonArr;
@property (nonatomic, strong) NSMutableArray *diantaiArr;

@property (nonatomic, strong) NSMutableArray *bannerImgArr;
@property (nonatomic, strong) NSArray *headerArr;
@property (nonatomic, strong) NSArray *footerArr;

- (void)getHomeFMDataWithSuccess:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

@end
