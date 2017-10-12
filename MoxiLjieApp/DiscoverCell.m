//
//  DiscoverCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/5.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "DiscoverCell.h"
#import "DiscoverItem.h"

@implementation DiscoverCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"DiscoverCell";
    DiscoverCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DiscoverCell" owner:nil options:nil].firstObject;
        
        [cell setCollectionviewLayout];//有数据且cell不存在时调用，否则会重复添加collectioncell，导致重复
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setDataWithDic:(NSDictionary *)dic currentSection:(NSInteger)section {
    self.imgDic = dic;
    self.currentSection = section;
}

//collectionview相关
- (void)setCollectionviewLayout {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;

    CGFloat width = Screen_Width/3;
    flow.itemSize = CGSizeMake(width, 89);
    
    self.discoverCollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 270) collectionViewLayout:flow];
    self.discoverCollectionview.backgroundColor = [UIColor clearColor];
    self.discoverCollectionview.delegate = self;
    self.discoverCollectionview.dataSource = self;
    self.discoverCollectionview.showsHorizontalScrollIndicator = NO;
    [self.discoverCollectionview registerNib:[UINib nibWithNibName:@"DiscoverItem" bundle:nil] forCellWithReuseIdentifier:@"DiscoverItem"];
    [self.contentView addSubview:self.discoverCollectionview];
}

#pragma mark - collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DiscoverItem" forIndexPath:indexPath];

    NSString *name = [NSString stringWithFormat:@"%ld", indexPath.row];
    if (self.currentSection) {
        name = [NSString stringWithFormat:@"%ld", indexPath.row+10];
    }
    
    [cell setImgWithName:name title:[self.imgDic objectForKey:name]];
    //    [cell setHoursDataWithModel:self.housArr[indexPath.row] index:indexPath.row];
    
    return cell;
}



/**
 item的排列顺序：
 
 0 2 4 6
 1 3 5 7
 
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.discoverDelegate respondsToSelector:@selector(didSelectDiscoverItemAtIndexPath:)]) {
        [self.discoverDelegate didSelectDiscoverItemAtIndexPath:indexPath];
    }
    NSLog(@"---%ld---",indexPath.row);
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
