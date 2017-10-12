//
//  TypeCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/5.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "TypeCell.h"

@interface TypeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation TypeCell

- (void)setDataWithModel:(HomeCategory *)model {
    if (model) {        
        [self.picView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
        self.titleLab.text = model.name;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.picView.layer.masksToBounds = YES;
    self.picView.layer.cornerRadius = self.picView.frame.size.width/2.0;
}

@end
