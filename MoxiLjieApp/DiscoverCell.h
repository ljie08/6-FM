//
//  DiscoverCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/5.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DiscoverDelegate <NSObject>

- (void)didSelectDiscoverItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface DiscoverCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *discoverCollectionview;

@property (nonatomic, assign) id <DiscoverDelegate> discoverDelegate;

@property (nonatomic, strong) NSDictionary *imgDic;
@property (nonatomic, assign) NSInteger *currentSection;

- (void)setDataWithDic:(NSDictionary *)dic currentSection:(NSInteger)section;

//collectionview相关
- (void)setCollectionviewLayout;

+ (instancetype)myCellWithTableview:(UITableView *)tableview;


@end
