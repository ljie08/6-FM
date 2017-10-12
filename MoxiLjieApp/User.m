//
//  User.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/6.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "User.h"

@implementation User

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"newid": @"id"};
}

@end
