//
//  PlayCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/6.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlayCellDelegate <NSObject>

- (void)playFMOrStopWithBtn:(UIButton *)button;

@end

@interface PlayCell : UITableViewCell

@property (nonatomic, assign) id<PlayCellDelegate> playDelegate;
+ (instancetype)myCellWithTableview:(UITableView *)tableview;

@end
