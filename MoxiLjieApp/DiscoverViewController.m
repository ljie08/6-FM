//
//  DiscoverViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/4.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

//发现

#import "DiscoverViewController.h"
#import "DiscoverCell.h"//心情场景cell
#import "DiscoverRadioCell.h"//主播cell
#import "HomeHeaderCell.h"//分区头
#import "MoreViewController.h"//更多
#import "DiscoverViewModel.h"

@interface DiscoverViewController ()<UITableViewDelegate, UITableViewDataSource, DiscoverDelegate, DiscoverRadioDelegate>

@property (weak, nonatomic) IBOutlet UITableView *discoverTable;
@property (nonatomic, strong) DiscoverViewModel *viewmodel;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[DiscoverViewModel alloc] init];
    [self loadData];
}

- (void)loadData {
    [self showWaiting];
    @weakSelf(self);
    [self.viewmodel getDiscoverDataWithSuccess:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf.discoverTable reloadData];
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        [weakSelf showMassage:error];
    }];
}

#pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) return 210;
    return 270;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        DiscoverRadioCell *cell = [DiscoverRadioCell myCellWithTableview:tableView authorArr:self.viewmodel.zhuboArr];
        cell.discoverDelegate = self;
        [cell.radioCollectionview reloadData];
        return cell;
    } else {
        DiscoverCell *cell = [DiscoverCell myCellWithTableview:tableView];
        cell.discoverDelegate = self;
        [cell setDataWithDic:self.viewmodel.imgDic currentSection:indexPath.section];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 20;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HomeHeaderCell *cell = [HomeHeaderCell myCellWithTableview:tableView];
    [cell setTitleWithTitle:self.viewmodel.headerArr[section]];
    return cell;
}

#pragma mark - discover
- (void)didSelectDiscoverItemAtIndexPath:(NSIndexPath *)indexPath {
    MoreViewController *more = [[MoreViewController alloc] init];
    more.type = 4;
    
    NSString *key = [NSString stringWithFormat:@"%ld",indexPath.row];
    more.catagory = self.viewmodel.imgDic[key];
    more.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:more animated:YES];
}

- (void)didSelectDiscoverRadioItemAtIndexPath:(NSIndexPath *)indexPath {
    [self gotoNewsRadioWithModel:self.viewmodel.zhuboArr[indexPath.row]];
}

#pragma mark - UI
- (void)initUIView {
    self.navigationItem.title = NSLocalizedString(@"discover", nil);
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
