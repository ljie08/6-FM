//
//  DiscoverRadioCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/6.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "DiscoverRadioCell.h"
#import "DiscoverRadioItem.h"

@implementation DiscoverRadioCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview authorArr:(NSArray *)arr {
    static NSString *cellid = @"DiscoverRadioCell";
    DiscoverRadioCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DiscoverRadioCell" owner:nil options:nil].firstObject;
        
        [cell setCollectionviewLayout];//有数据且cell不存在时调用，否则会重复添加collectioncell，导致重复
    }
    cell.authorArr = arr;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSArray *)authorArr {
    if (_authorArr == nil) {
        _authorArr = [NSArray array];
    }
    return _authorArr;
}

//collectionview相关
- (void)setCollectionviewLayout {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    
    CGFloat width = Screen_Width/2;
    flow.itemSize = CGSizeMake(width, 68);

    self.radioCollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 210) collectionViewLayout:flow];
    self.radioCollectionview.backgroundColor = [UIColor clearColor];
    self.radioCollectionview.delegate = self;
    self.radioCollectionview.dataSource = self;
    self.radioCollectionview.showsHorizontalScrollIndicator = NO;
    [self.radioCollectionview registerNib:[UINib nibWithNibName:@"DiscoverRadioItem" bundle:nil] forCellWithReuseIdentifier:@"DiscoverRadioItem"];
    [self.contentView addSubview:self.radioCollectionview];
}

#pragma mark - collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverRadioItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DiscoverRadioItem" forIndexPath:indexPath];
    [cell setDataWithModel:self.authorArr[indexPath.row]];
    
    return cell;
}



/**
 item的排列顺序：
 
 0 2 4 6
 1 3 5 7
 
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.discoverDelegate respondsToSelector:@selector(didSelectDiscoverRadioItemAtIndexPath:)]) {
        [self.discoverDelegate didSelectDiscoverRadioItemAtIndexPath:indexPath];
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
