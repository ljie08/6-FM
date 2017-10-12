//
//  HomeTypeCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/5.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "HomeTypeCell.h"
#import "TypeCell.h"

@implementation HomeTypeCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview typeArr:(NSArray *)typeArr {
    static NSString *cellid = @"HomeTypeCell";
    HomeTypeCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HomeTypeCell" owner:nil options:nil].firstObject;
        
        [cell setCollectionviewLayout];//有数据且cell不存在时调用，否则会重复添加collectioncell，导致重复
    }
    cell.typeArr = [NSArray arrayWithArray:typeArr];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSArray *)typeArr {
    if (_typeArr == nil) {
        _typeArr = [NSArray array];
    }
    return _typeArr;
}

//collectionview相关
- (void)setCollectionviewLayout {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    
    CGFloat width = Screen_Width/4;
    flow.itemSize = CGSizeMake(width, 80);

    self.typeCollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 160) collectionViewLayout:flow];
    self.typeCollectionview.backgroundColor = [UIColor clearColor];
    self.typeCollectionview.delegate = self;
    self.typeCollectionview.dataSource = self;
    self.typeCollectionview.showsHorizontalScrollIndicator = NO;
    [self.typeCollectionview registerNib:[UINib nibWithNibName:@"TypeCell" bundle:nil] forCellWithReuseIdentifier:@"TypeCell"];
    [self.contentView addSubview:self.typeCollectionview];
}

#pragma mark - collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.typeArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeCell" forIndexPath:indexPath];
    if (self.typeArr.count) {
        [cell setDataWithModel:self.typeArr[indexPath.row]];
    }
    
    return cell;
}

/**
 item的排列顺序：
 
    0 2 4 6
    1 3 5 7
 
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.typeDelegate respondsToSelector:@selector(didSelectTypeItemAtIndexPath:)]) {
        [self.typeDelegate didSelectTypeItemAtIndexPath:indexPath];
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
