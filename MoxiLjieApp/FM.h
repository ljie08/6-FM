//
//  FM.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/6.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FM : NSObject

@property (nonatomic, copy) NSString *newid;//
@property (nonatomic, copy) NSString *object_id;//
@property (nonatomic, copy) NSString *title;//
@property (nonatomic, copy) NSString *cover;//
@property (nonatomic, copy) NSString *url;//
@property (nonatomic, copy) NSString *speak;//
@property (nonatomic, copy) NSString *favnum;
@property (nonatomic, copy) NSString *viewnum;
@property (nonatomic, assign) BOOL is_teacher;
@property (nonatomic, copy) NSString *absolute_url;
@property (nonatomic, strong) Diantai *diantai;

@end
