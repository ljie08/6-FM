//
//  BaseViewController.m
//  MyWeather
//
//  Created by lijie on 2017/7/27.
//  Copyright © 2017年 lijie. All rights reserved.
//

#import "BaseViewController.h"
#import "MoreViewController.h"
#import "FMPlayViewController.h"
#import "NewsRadioViewController.h"
#import "DiscoverRadioViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barTintColor = MyColor;
    self.navigationController.navigationBar.translucent = NO;
        
    [self initViewModelBinding];
    [self initUIView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}


#pragma mark - 页面UI初始化搭建
- (void)initUIView {
}

#pragma mark - 设置背景图
- (void)setThemeImgWithPicture:(NSString *)name {
    UIImage *image = [[UIImage alloc] init];
    if (name == nil) {
        image = [UIImage imageNamed:@"bg"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    } else {
        image = [UIImage imageNamed:name];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:name]];
    }
    self.view.layer.contents = (id) image.CGImage;// 如果需要背景透明加上下面这句
    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
}

#pragma mark - 创建ViewModel，viewModel的参数初始化工作等

- (void)initViewModelBinding {
    
}

/**
 * @brief  设置导航的标题 左右item
 *
 * @param
 *
 * @return
 */

/**
 设置导航栏
 
 @param title 标题
 @param left 左item
 @param right 右item
 @param view 标题view
 */
- (void)addNavigationWithTitle:(NSString *)title leftItem:(UIBarButtonItem  *)left rightItem:(UIBarButtonItem *)right titleView:(UIView *)view {
    if (title) {
        // 设置导航的标题
        self.navigationItem.title = title;
    }
    
    if (left) {
        // 设置左边的item
        self.navigationItem.leftBarButtonItem = left;
    }
    
    if (right) {
        // 设置右边的item
        self.navigationItem.rightBarButtonItem = right;
    }
    
    if (view) {
        // 设置标题view
        self.navigationItem.titleView = view;
    }
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@""];
}

//设置返回按钮是否显示
- (void)setBackButton:(BOOL)isShown {
    if (isShown) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 12, 18);
        [backBtn setImage:[UIImage imageNamed:@"black_back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        self.navigationItem.leftBarButtonItem = leftItem;//[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Goback"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

#pragma mark - 跳转

/**
 更多vc

 @param tag 点击了首页的8个按钮和发现页的按钮的某一个 拼接url用
 @param type 确定加载什么类型的数据
 */
- (void)gotoMoreVCWithTag:(NSInteger)tag type:(NSInteger)type {
    MoreViewController *more = [[MoreViewController alloc] init];
    more.type = type;
    if (type == 1) {
        more.catagory = [NSString stringWithFormat:@"%ld", tag+1];
    }
    more.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:more animated:YES];
}

- (void)gotoPlayVCWithUserID:(NSString *)userID {
    FMPlayViewController *play = [FMPlayViewController shareFMPlay];
//    play.user_id = userID;
    play.type = 1;
    [play setFMPlayWithID:userID];
    play.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:play animated:YES];
    
}

- (void)gotoNewsRadioWithModel:(Author *)model {
    NewsRadioViewController *radio = [[NewsRadioViewController alloc] init];
    radio.author = model;
    radio.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:radio animated:YES];
}

- (void)gotoDiscoverRadioWithTitle:(NSString *)title {
    DiscoverRadioViewController *radio = [[DiscoverRadioViewController alloc] init];
    radio.name = title;
    radio.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:radio animated:YES];
}

//返回
- (void)goBack {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        if (self.navigationController) {
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
        } else {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }
}

//返回到根视图控制器
- (void)goRootBack {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - 网络小菊花
//网络请求等待
- (MBProgressHUD *)showWaiting {
    return [self showWaitingOnView:self.view];
}

//停止网络请求等待
- (void)hideWaiting {
    [self hidewaitingOnView:self.view];
}

- (MBProgressHUD *)showWaitingOnView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (hud) {
        return hud;
    }
    hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = @"加载中...";
    return hud;
}

- (void)hidewaitingOnView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
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
