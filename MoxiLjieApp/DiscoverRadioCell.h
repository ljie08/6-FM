//
//  DiscoverRadioCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/6.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DiscoverRadioDelegate <NSObject>

- (void)didSelectDiscoverRadioItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface DiscoverRadioCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *radioCollectionview;

@property (nonatomic, assign) id <DiscoverRadioDelegate> discoverDelegate;

@property (nonatomic, strong) NSArray *authorArr;

//collectionview相关
- (void)setCollectionviewLayout;

+ (instancetype)myCellWithTableview:(UITableView *)tableview authorArr:(NSArray *)arr;

@end
