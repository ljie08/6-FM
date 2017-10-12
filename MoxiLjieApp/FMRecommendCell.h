//
//  FMRecommendCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/5.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FMRecommendDelegate <NSObject>

- (void)didSelectFMItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FMRecommendCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *fmCollectionview;
@property (nonatomic, assign) id<FMRecommendDelegate> fmDelegate;

@property (nonatomic, strong) NSArray *fmArr;

//collectionview相关
- (void)setCollectionviewLayout;

+ (instancetype)myCellWithTableview:(UITableView *)tableview fmArr:(NSArray *)fmArr;

@end
