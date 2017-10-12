//
//  RadioHeaderCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/6.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "RadioHeaderCell.h"

@interface RadioHeaderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerBgView;
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *listenerLab;
@property (weak, nonatomic) IBOutlet UILabel *attentionLab;

@end

@implementation RadioHeaderCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"RadioHeaderCell";
    RadioHeaderCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"RadioHeaderCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setDataWithModel:(Author *)model {
    if (model) {
        [self.headerBgView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
        [self.headerView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
        self.listenerLab.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"listen", nil), model.viewnum];
        self.attentionLab.text = [NSString stringWithFormat:NSLocalizedString(@"guanzhu", nil), model.favnum];        
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
