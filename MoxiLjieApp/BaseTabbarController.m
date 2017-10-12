//
//  BaseTabbarController.m
//  IOSFrame
//
//  Created by lijie on 2017/7/17.
//  Copyright © 2017年 lijie. All rights reserved.
//

#import "BaseTabbarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "FMPlayViewController.h"

#import "SimpleTabbar.h"

@interface BaseTabbarController ()<SimpleTabbarDelegate>

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"userid"];
    
    SimpleTabbar *tabbar = [[SimpleTabbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49)];
    tabbar.playDelegate = self;
    [self setValue:tabbar forKey:@"tabBar"];
    [[UITabBar appearance] setBarTintColor:MyColor];
    [UITabBar appearance].translucent = NO;
    
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    [self setChildVCWithViewController:homeVc title:@"home" image:[UIImage imageNamed:@"home_normal"] selectedImg:[UIImage imageNamed:@"home_gold"]];
    
    DiscoverViewController *disVc = [[DiscoverViewController alloc] init];
    [self setChildVCWithViewController:disVc title:@"me" image:[UIImage imageNamed:@"me_normal"] selectedImg:[UIImage imageNamed:@"me_gold"]];
    
}

- (void)setChildVCWithViewController:(UIViewController *)controller title:(NSString *)title image:(UIImage *)image selectedImg:(UIImage *)selectedImg {
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
    self.tabBar.tintColor = FontColor;

    nav.title = title;
    nav.tabBarItem.image = image;
    nav.tabBarItem.selectedImage = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

#pragma mark - tabbar
- (void)presentPlayVC {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSString *string = [defaults objectForKey:@"userid"];
    if (string.length) {

        FMPlayViewController *play = [FMPlayViewController shareFMPlay];
        play.type = 2;
        [play setFMPlay];
        [self presentViewController:play animated:YES completion:nil];
        
    } else {
        [self showMassage:@"请选择要播放的电台"];
    }
}

- (void)showMassage:(NSString *)massage {//提示消息
    if (massage) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = massage;
        hud.label.font = [UIFont systemFontOfSize:13];
        hud.margin = 10.f;
        [hud setOffset:CGPointMake(0, 0)];
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:1.0f];
    }
}

@end
