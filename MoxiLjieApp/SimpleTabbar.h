//
//  SimpleTabbar.h
//  TabbarDemo
//
//  Created by lee on 2017/2/15.
//  Copyright © 2017年 仿佛若有光. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SimpleTabbarDelegate <NSObject>

- (void)presentPlayVC;

@end

@interface SimpleTabbar : UITabBar

@property (nonatomic, assign) id <SimpleTabbarDelegate> playDelegate;

@end
