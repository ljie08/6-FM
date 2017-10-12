//
//  DiscoverItem.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/5.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "DiscoverItem.h"

@interface DiscoverItem ()

@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;

@end

@implementation DiscoverItem

- (void)setImgWithName:(NSString *)name title:(NSString *)title {
    self.picView.image = [UIImage imageNamed:name];
    self.typeLab.text = title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
