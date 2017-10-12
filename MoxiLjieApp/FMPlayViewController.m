//
//  FMPlayViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/8.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "FMPlayViewController.h"
#import "DOUAudioStreamer.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Player.h"
#import "UIView+Extension.h"
#import "PlayViewModel.h"

#import "MyPlayer.h"

#define ZYStatusProp @"status"

@interface FMPlayViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *bgScroll;

@property (weak, nonatomic) IBOutlet UIImageView *picView;//图片
@property (weak, nonatomic) IBOutlet UILabel *titleLab;//标题
@property (weak, nonatomic) IBOutlet UILabel *listenerLab;//听众
@property (weak, nonatomic) IBOutlet UIButton *playBtn;//播放按钮
@property (weak, nonatomic) IBOutlet UILabel *timeLab;//播放时间
@property (weak, nonatomic) IBOutlet UIProgressView *playProgress;//播放进度条
@property (weak, nonatomic) IBOutlet UIImageView *authorHeader;//主播头像
@property (weak, nonatomic) IBOutlet UILabel *nameLab;//主播名字
@property (weak, nonatomic) IBOutlet UILabel *descLab;//主播简介
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerPadding;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerTop;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (nonatomic) Player *model;
@property (nonatomic, strong) DOUAudioStreamer *streamer;

@property (nonatomic,assign) BOOL isPlay;// 是否处于播放状态

@property (nonatomic, strong) PlayViewModel *viewmodel;

/**
 *  播放进度定时器
 */
@property (nonatomic, strong) NSTimer *currentTimeTimer;

@property (nonatomic,assign) double oldProgress;

@end

@implementation FMPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.oldProgress = 0.000;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user_id forKey:@"userid"];
    
    self.file = [[FMPlayer alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.timeLab.text = @"0:00";
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self removeCurrentTimeTimer];
}

+ (instancetype)shareFMPlay {
    static FMPlayViewController *fmPlay = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmPlay = [[FMPlayViewController alloc] init];
    });
    return fmPlay;
}

- (void)setFMPlay {
    [self setFMPlayWithID:self.user_id];
}

- (void)setFMPlayWithID:(NSString *)fmID {
    if (self.type == 1) {
        self.backBtn.hidden = YES;
    }
    //如果换了歌曲
    if (![self.user_id isEqualToString:fmID]) {
        [self resetPlayingMusic];
        self.user_id = fmID;
        [self loadData];
    }else{
        [self startPlayingMusic];
    }
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[PlayViewModel alloc] init];
//    [self loadData];
}

- (void)loadData {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getPlayDataWithID:self.user_id success:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf setUpData];
        [weakSelf startPlayingMusic];
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        [weakSelf showMassage:error];
    }];
}

#pragma mark - 事件
- (IBAction)playOrStop:(UIButton *)sender {
    if (self.playBtn.isSelected) { // 暂停
        self.playBtn.selected = NO;
        [self.streamer pause];
        [self removeCurrentTimeTimer];
    } else { // 继续播放
        self.playBtn.selected = YES;
        [self.streamer play];
        [self addCurrentTimeTimer];
    }
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)goBack {
    [self removeCurrentTimeTimer];
    [super goBack];
}

#pragma mark - 音乐控制
/**
 *  重置正在播放的音乐
 */
- (void)resetPlayingMusic {
    // 1.重置界面数据
    self.picView.image = nil;
    self.titleLab.text = nil;
    self.listenerLab.text = nil;
    self.timeLab.text = nil;
    self.playProgress.progress = 0.0;
    self.authorHeader.image = nil;
    self.nameLab.text = nil;
    self.descLab.text = nil;
    
    [self.streamer removeObserver:self forKeyPath:ZYStatusProp];
    
    // 2.停止播放
    [self.streamer stop];
    self.streamer = nil;
    
    // 3.停止定时器
    [self removeCurrentTimeTimer];
    
    // 4.设置播放按钮状态
    self.playBtn.selected = NO;
}

/**
 *  开始播放音乐
 */
- (void)startPlayingMusic {
    if (self.streamer) {
        [self addCurrentTimeTimer];
        // 播放
        if (self.playBtn.selected) {
            [self.streamer play];
        } else {
            [self.streamer pause];
        }

        return;
    }
    
    // 1.设置界面数据
    [self setUpData];
    // 2.开始播放
    self.file.audioFileURL = [NSURL URLWithString:self.viewmodel.play.url];
    
    // 创建播放器
    self.streamer = [DOUAudioStreamer streamerWithAudioFile:self.file];
    // KVO监听streamer的属性（Key value Observing）
    [self.streamer addObserver:self forKeyPath:ZYStatusProp options:NSKeyValueObservingOptionOld context:nil];
    
    // 播放
    if (self.playBtn.selected) {
        [self.streamer play];
    } else {
        [self.streamer pause];
    }

    [self addCurrentTimeTimer];
    // 设置播放按钮状态
    self.playBtn.selected = YES;
}


#pragma mark - 定时器处理
- (void)addCurrentTimeTimer {
    
    [self removeCurrentTimeTimer];
    
    // 保证定时器的工作是及时的
    [self updateTime];
    
    self.currentTimeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.currentTimeTimer forMode:NSRunLoopCommonModes];
}

- (void)removeCurrentTimeTimer {
    [self.currentTimeTimer invalidate];
    self.currentTimeTimer = nil;
}

/**
 *  更新播放进度
 */
- (void)updateTime {
    
    // 1.计算进度值
    double time = 1;
    if ([self.viewmodel.play.duration floatValue]== 0) {
        time = 1000.0;
    }else {
        time = [self.viewmodel.play.duration floatValue];
    }
    
    double progress = self.streamer.currentTime / time;
    if (progress == self.oldProgress) {
        [self.streamer play];
        
    }
    self.oldProgress = progress;
    if (progress > 0.99) {
        [self.streamer pause];
        self.playBtn.selected = NO;
        self.playProgress.progress = progress;
        
        [self removeCurrentTimeTimer];
        progress = 0.000000;
        NSTimeInterval time = self.streamer.duration * progress;
        self.oldProgress = 0.000000;
        
        self.timeLab.text = [self strWithTime:time];
        self.streamer.currentTime = time;
        return;
    }
    
    self.timeLab.text = [self strWithTime:self.streamer.currentTime];
    self.playProgress.progress = progress;
}

#pragma mark - 私有方法
/**
 *  时长长度 -> 时间字符串
 */
- (NSString *)strWithTime:(NSTimeInterval)time {
    int minute = time / 60;
    int second = (int)time % 60;
    if (second < 10) {
        
        return [NSString stringWithFormat:@"%d:0%d", minute, second];
    } else {
        return [NSString stringWithFormat:@"%d:%d", minute, second];
    }
}

#pragma mark - 监听
/**
 利用KVO监听的属性值改变了,就会调用
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([keyPath isEqualToString:ZYStatusProp]) { // 监听到播放器状态改变了
            
            if (self.streamer.status == DOUAudioStreamerError) {
                
                [self showMassage:@"音乐加载失败"];
            }
        }
    });
}


#pragma mark - ui
- (void)initUIView {
    [self setBackButton:YES];
    self.navigationItem.title = NSLocalizedString(@"bofang", nil);
    self.picWidth.constant = 200*Heigt_Scale;
    self.headerTop.constant = 50*Heigt_Scale;
    self.headerPadding.constant = 30*Heigt_Scale;
}

- (void)setUpData {
    [self.picView sd_setImageWithURL:[NSURL URLWithString:self.viewmodel.play.cover] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
    self.titleLab.text = self.viewmodel.play.title;
    self.listenerLab.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"listen", nil), self.viewmodel.play.viewnum];
    self.timeLab.text = @"0:00";
    self.playProgress.progress = 0.00;
    [self.authorHeader sd_setImageWithURL:[NSURL URLWithString:self.viewmodel.play.diantai.user.avatar] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
    self.nameLab.text = self.viewmodel.play.diantai.user.nickname;
    self.descLab.text = self.viewmodel.play.diantai.content;
    
}

#pragma mark - dealloc
- (void)dealloc {
    [self.viewmodel cancelAllHTTPRequest];
    [self.streamer removeObserver:self forKeyPath:ZYStatusProp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
