//
//  Player.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/8.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, copy) NSString *newid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *speak;
@property (nonatomic, copy) NSString *favnum;
@property (nonatomic, copy) NSString *viewnum;
@property (nonatomic, copy) NSString *is_teacher;
@property (nonatomic, copy) NSString *absolute_url;
@property (nonatomic, copy) NSArray *url_list;
@property (nonatomic, copy) NSString *object_id;
@property (nonatomic, strong) Diantai *diantai;
@property (nonatomic, copy) NSString *commentnum;
@property (nonatomic, copy) NSString *range;
@property (nonatomic, copy) NSString *duration;
@property (nonatomic, strong) NSArray *user_gift_list;

@end
