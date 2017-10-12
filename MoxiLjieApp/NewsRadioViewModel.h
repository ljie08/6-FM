//
//  NewsRadioViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/7.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface NewsRadioViewModel : BaseViewModel

@property (nonatomic, strong) NSMutableArray *authorFMArr;
@property (nonatomic, strong) Author *author;

@property (nonatomic, assign) int page;

- (void)getAuthorWithAuthorID:(NSString *)authorID success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

- (void)getAuthorFMListWithAuthorID:(NSString *)authorID isRefresh:(BOOL)isRefresh success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

@end
