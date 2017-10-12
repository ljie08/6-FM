//
//  HomeTypeCell.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/5.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypeDelegate <NSObject>

- (void)didSelectTypeItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HomeTypeCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *typeCollectionview;

@property (nonatomic, assign) id <TypeDelegate> typeDelegate;

@property (nonatomic, strong) NSArray *typeArr;

//collectionview相关
- (void)setCollectionviewLayout;

+ (instancetype)myCellWithTableview:(UITableView *)tableview typeArr:(NSArray *)typeArr;

@end
