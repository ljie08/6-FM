//
//  PlayViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/4.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "PlayViewController.h"
#import "PlayCell.h"
#import "MyPlayer.h"

@interface PlayViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *playTable;

@property (nonatomic, strong) MyPlayer *myplayer;

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myplayer = [MyPlayer shareInstance];
}

- (void)playOrStop:(UIButton *)button {
    
}


#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 550;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayCell *cell = [PlayCell myCellWithTableview:tableView];
    return cell;
}

#pragma mark - UI
- (void)initUIView {
    self.navigationItem.title = [NSString stringWithFormat:@"播放 - %@", self.name];
    [self setBackButton:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end





