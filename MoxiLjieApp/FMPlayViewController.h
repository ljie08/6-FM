//
//  FMPlayViewController.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/8.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "BaseViewController.h"
#import "FMPlayer.h"

@interface FMPlayViewController : BaseViewController

@property (nonatomic,copy)NSString *user_id;//fm的id
@property (nonatomic,strong) FMPlayer *file;
@property (nonatomic,assign) NSInteger type;

+ (instancetype)shareFMPlay;

- (void)setFMPlay;

- (void)setFMPlayWithID:(NSString *)fmID;

@end
