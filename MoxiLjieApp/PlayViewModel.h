//
//  PlayViewModel.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/8.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewModel.h"

@interface PlayViewModel : BaseViewModel

@property (nonatomic, strong) Player *play;

- (void)getPlayDataWithID:(NSString *)playID success:(void(^)(BOOL result))success failture:(void(^)(NSString *error))failture;

@end
