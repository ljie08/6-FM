//
//  FMCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/5.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "FMCell.h"

@interface FMCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation FMCell

- (void)setDataWithModel:(Author *)model {
    if (model) {        
        [self.headerView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
        self.nameLab.text = model.title;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.headerView.layer.masksToBounds = YES;
//    self.headerView.layer.cornerRadius = self.headerView.frame.size.width/2.0;
}

@end
