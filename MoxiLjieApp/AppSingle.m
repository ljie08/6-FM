//
//  AppSingle.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/8.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "AppSingle.h"

@implementation AppSingle

+ (AppSingle *)shareInstance {
    static AppSingle *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[AppSingle alloc] init];
        
    });
    return _instance;
}

- (void)setAuthor:(Author *)author {
    _author = author;
}

- (void)setFm:(FM *)fm {
    _fm = fm;
}

- (void)setFmID:(NSString *)fmID {
    _fmID = fmID;
}

@end
