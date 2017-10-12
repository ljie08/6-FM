//
//  DiscoverRadioItem.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/6.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "DiscoverRadioItem.h"

@interface DiscoverRadioItem ()

@property (weak, nonatomic) IBOutlet UIImageView *headerVIew;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *jiemuLab;

@end

@implementation DiscoverRadioItem

- (void)setDataWithModel:(Author *)model {
    if (model) {
        [self.headerVIew sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
        self.nameLab.text = model.title;
        self.jiemuLab.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"jiemu", nil), model.fmnum];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
