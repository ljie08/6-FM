//
//  RecomendCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/5.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "RecomendCell.h"

@interface RecomendCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *decLab;

@end

@implementation RecomendCell

- (void)setDataWithModel:(FM *)model {
    if (model) {        
        [self.picView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
        self.decLab.text = model.title;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
