//
//  SimpleTabbar.m
//  TabbarDemo
//
//  Created by lee on 2017/2/15.
//  Copyright © 2017年 仿佛若有光. All rights reserved.
//

#import "SimpleTabbar.h"

@interface SimpleTabbar ()

@property (nonatomic, strong) UIButton *scanBtn;

@end

@implementation SimpleTabbar

+ (void)initialize {
    [[UITabBar appearance] setTintColor:[UIColor orangeColor]];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setScanBtnWifhFrame:frame];
    return self;
}

//设置扫码按钮
- (void)setScanBtnWifhFrame:(CGRect)frame {
    self.scanBtn = [[UIButton alloc] init];
    self.scanBtn.frame = CGRectMake(frame.size.width/2.0-25, -25, 50, 50);
    [self.scanBtn setBackgroundImage:[UIImage imageNamed:@"hear"] forState:UIControlStateNormal];
    [self.scanBtn addTarget:self action:@selector(scanClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.scanBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.selectedItem = self.items.firstObject;默认选中的是第一个按钮 可以在tabbarVC里调整代码位置，也可以在这里设置
    Class class = NSClassFromString(@"UITabBarButton");
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {//遍历tabbar的子控件 修改原生item的x坐标 给中间按钮留出一个位置 （这里中间的按钮相当于叠加在底下两个barItem上，所以用不到）
        //有时候会出现个问题 就是你点击的时候容易把事件传递到下一层 就是点击中间的按钮，会触发下边被盖住的那层的事件
        if ([btn isKindOfClass:class]) {
            CGRect frame = btn.frame;
            frame.size.width = self.frame.size.width / 2;//有两个item，除以2
            frame.origin.x = frame.size.width * btnIndex;
            btn.frame = frame;
            btnIndex++;
            //如果中间的按钮占用的tabbar的位置 index要再加1，如下
            if (btnIndex == 0) {
                btnIndex++;
            }
        }
    }
    [self bringSubviewToFront:self.scanBtn];
}

- (void)scanClick {
    NSLog(@"111");
    if ([self.playDelegate respondsToSelector:@selector(presentPlayVC)]) {
        [self.playDelegate presentPlayVC];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.isHidden == NO) {
        CGPoint newP = [self convertPoint:point toView:self.scanBtn];
        if ([self.scanBtn pointInside:newP withEvent:event]) {
            return self.scanBtn;
        } else {
            return [super hitTest:point withEvent:event];
        }
    } else {
        return [super hitTest:point withEvent:event];
    }
}

@end
