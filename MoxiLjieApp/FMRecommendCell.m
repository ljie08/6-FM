//
//  FMRecommendCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/5.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "FMRecommendCell.h"
#import "FMCell.h"

@implementation FMRecommendCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview fmArr:(NSArray *)fmArr {
    static NSString *cellid = @"FMRecommendCell";
    FMRecommendCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FMRecommendCell" owner:nil options:nil].firstObject;
        
        [cell setCollectionviewLayout];//有数据且cell不存在时调用，否则会重复添加collectioncell，导致重复
    }
    cell.fmArr = fmArr;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSArray *)fmArr {
    if (_fmArr == nil) {
        _fmArr = [NSArray array];
    }
    return _fmArr;
}

//collectionview相关
- (void)setCollectionviewLayout {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    
    CGFloat width = Screen_Width/4;
    flow.itemSize = CGSizeMake(width, 100);
    
    self.fmCollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100) collectionViewLayout:flow];
    self.fmCollectionview.backgroundColor = [UIColor clearColor];
    self.fmCollectionview.delegate = self;
    self.fmCollectionview.dataSource = self;
    self.fmCollectionview.showsHorizontalScrollIndicator = NO;
    [self.fmCollectionview registerNib:[UINib nibWithNibName:@"FMCell" bundle:nil] forCellWithReuseIdentifier:@"FMCell"];
    [self.contentView addSubview:self.fmCollectionview];
}

#pragma mark - collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FMCell" forIndexPath:indexPath];
    if (self.fmArr.count) {
        [cell setDataWithModel:self.fmArr[indexPath.row]];
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.fmDelegate respondsToSelector:@selector(didSelectFMItemAtIndexPath:)]) {
        [self.fmDelegate didSelectFMItemAtIndexPath:indexPath];
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
