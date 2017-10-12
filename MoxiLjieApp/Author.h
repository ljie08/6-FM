//
//  Author.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/6.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : NSObject

@property (nonatomic, copy) NSString *newid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *fmnum;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *viewnum;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *favnum;
@property (nonatomic, strong) User *user;
@property (nonatomic, copy) NSString *commentnum;
@property (nonatomic, copy) NSString *absolute_url;
@property (nonatomic, copy) NSString *gover;

@end
