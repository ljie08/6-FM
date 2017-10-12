//
//  HotRecommendCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/5.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "HotRecommendCell.h"
#import "RecomendCell.h"

@implementation HotRecommendCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview hotArr:(NSArray *)hotArr {
    static NSString *cellid = @"HotRecommendCell";
    HotRecommendCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HotRecommendCell" owner:nil options:nil].firstObject;
        
        [cell setCollectionviewLayout];//有数据且cell不存在时调用，否则会重复添加collectioncell，导致重复
    }
    cell.hotArr = hotArr;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSArray *)hotArr {
    if (_hotArr == nil) {
        _hotArr = [NSArray array];
    }
    return _hotArr;
}

//collectionview相关
- (void)setCollectionviewLayout {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    
    CGFloat width = Screen_Width/3.0;
    flow.itemSize = CGSizeMake(width, 150);
    
    self.recommendCollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 150) collectionViewLayout:flow];
    self.recommendCollectionview.backgroundColor = [UIColor clearColor];
    self.recommendCollectionview.delegate = self;
    self.recommendCollectionview.dataSource = self;
    self.recommendCollectionview.showsHorizontalScrollIndicator = NO;
    [self.recommendCollectionview registerNib:[UINib nibWithNibName:@"RecomendCell" bundle:nil] forCellWithReuseIdentifier:@"RecomendCell"];
    [self.contentView addSubview:self.recommendCollectionview];
}

#pragma mark - collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RecomendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecomendCell" forIndexPath:indexPath];
    if (self.hotArr.count) {
        [cell setDataWithModel:self.hotArr[indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.hotDelegate respondsToSelector:@selector(didSelectHotItemAtIndexPath:)]) {
        [self.hotDelegate didSelectHotItemAtIndexPath:indexPath];
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
