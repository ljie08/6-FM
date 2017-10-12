//
//  NewClassCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/5.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "NewClassCell.h"

@interface NewClassCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *descLab;

@end

@implementation NewClassCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"NewClassCell";
    NewClassCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewClassCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setDataWithFMModel:(FM *)model {
    if (model) {        
        self.titleLab.text = model.title;
        self.descLab.text = model.speak;
        [self.picView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
    }
}

- (void)setDataWithAuthorModel:(Author *)model {
    if (model) {
        self.titleLab.text = model.title;
        [self.picView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
        self.descLab.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"listen", nil), model.viewnum];
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
