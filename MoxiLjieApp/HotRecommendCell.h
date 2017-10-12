//
//  HotRecommendCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/5.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HotDelegate <NSObject>

- (void)didSelectHotItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HotRecommendCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *recommendCollectionview;

@property (nonatomic, assign) id <HotDelegate> hotDelegate;

@property (nonatomic, strong) NSArray *hotArr;

//collectionview相关
- (void)setCollectionviewLayout;

+ (instancetype)myCellWithTableview:(UITableView *)tableview hotArr:(NSArray *)hotArr;

@end
