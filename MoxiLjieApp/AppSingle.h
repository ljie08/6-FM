//
//  AppSingle.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/8.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSingle : NSObject

@property (nonatomic, strong) Author *author;
@property (nonatomic, strong) FM *fm;
@property (nonatomic, copy) NSString *fmID;

+ (AppSingle *)shareInstance;

@end
