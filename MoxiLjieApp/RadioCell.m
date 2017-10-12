//
//  RadioCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/6.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "RadioCell.h"

@interface RadioCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *descLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;

@end

@implementation RadioCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"RadioCell";
    RadioCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"RadioCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setDataWithModel:(Author *)model {
    if (model) {
        [self.headerImg sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
        self.nameLab.text = model.title;
        self.descLab.text = model.content;
        self.numLab.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"jiemu", nil),model.fmnum];
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
