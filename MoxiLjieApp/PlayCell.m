//
//  PlayCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/6.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "PlayCell.h"

@interface PlayCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picView;//图片
@property (weak, nonatomic) IBOutlet UILabel *titleLab;//标题
@property (weak, nonatomic) IBOutlet UILabel *listenerLab;//听众
@property (weak, nonatomic) IBOutlet UIButton *playBtn;//播放按钮
@property (weak, nonatomic) IBOutlet UILabel *timeLab;//播放时间
@property (weak, nonatomic) IBOutlet UIProgressView *playProgress;//播放进度条
@property (weak, nonatomic) IBOutlet UIImageView *authorHeader;//主播头像
@property (weak, nonatomic) IBOutlet UILabel *nameLab;//主播名字
@property (weak, nonatomic) IBOutlet UILabel *descLab;//主播简介

@end

@implementation PlayCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"PlayCell";
    PlayCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PlayCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (IBAction)playOrStop:(UIButton *)sender {
    if ([self.playDelegate respondsToSelector:@selector(playFMOrStopWithBtn:)]) {
        [self.playDelegate playFMOrStopWithBtn:sender];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
