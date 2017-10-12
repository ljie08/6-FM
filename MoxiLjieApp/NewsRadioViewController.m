//
//  NewsRadioViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/5.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

//主播主页

#import "NewsRadioViewController.h"
#import "NewClassCell.h"//节目cell
#import "HomeHeaderCell.h"//分区头
#import "RadioHeaderCell.h"//表头
#import "FMPlayViewController.h"//播放vc
#import "NewsRadioViewModel.h"

@interface NewsRadioViewController ()<UITableViewDataSource, UITableViewDelegate, RefreshTableViewDelegate>

@property (weak, nonatomic) IBOutlet JJRefreshTabView *newsradioTable;
@property (nonatomic, strong) NewsRadioViewModel *viewmodel;

@end

@implementation NewsRadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[NewsRadioViewModel alloc] init];
    [self loadHeaderData];
    [self loadFMListIsRefresh:YES];
}

- (void)loadHeaderData {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getAuthorWithAuthorID:self.author.newid success:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf.newsradioTable reloadData];
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        [weakSelf showMassage:error];
    }];
}

- (void)loadFMListIsRefresh:(BOOL)isRefresh {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getAuthorFMListWithAuthorID:self.author.newid isRefresh:isRefresh success:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf.newsradioTable reloadData];
        if (weakSelf.viewmodel.authorFMArr.count >= 10) {
            weakSelf.newsradioTable.isShowMore = YES;
        }
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        [weakSelf showMassage:error];
    }];
}

#pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section) return self.viewmodel.authorFMArr.count;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) return 60;
    return 230;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RadioHeaderCell *cell = [RadioHeaderCell myCellWithTableview:tableView];
        [cell setDataWithModel:self.viewmodel.author];
        return cell;
    } else {
        NewClassCell *cell = [NewClassCell myCellWithTableview:tableView];
        if (self.viewmodel.authorFMArr.count) {
            [cell setDataWithAuthorModel:self.viewmodel.authorFMArr[indexPath.row]];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        FM *model = self.viewmodel.authorFMArr[indexPath.row];
        [self gotoPlayVCWithUserID:model.newid];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section) return 20;
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section) return 50;
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HomeHeaderCell *cell = [HomeHeaderCell myCellWithTableview:tableView];
    return cell;
}

#pragma mark - refresh
//刷新
- (void)refreshTableViewHeader {
    [self loadHeaderData];
    [self loadFMListIsRefresh:YES];
}
//加载
- (void)refreshTableViewFooter {
    [self loadFMListIsRefresh:NO];
}

- (void)cheakTableViewHasMoreData {
    //    self.scanHistoryTable.isShowMore = (self.viewModel.hasMoreData == NO || self.viewModel.scanHistoryArr.count == 0) ? NO : YES;
}

#pragma mark - UI
- (void)initUIView {
    self.navigationItem.title = [NSString stringWithFormat:NSLocalizedString(@"zhubo", nil), self.author.title];
    [self setBackButton:YES];
    [self setupTable];
}

- (void)setupTable {
    self.newsradioTable.refreshDelegate = self;
    self.newsradioTable.CanRefresh = YES;
    self.newsradioTable.lastUpdateKey = NSStringFromClass([self class]);
    self.newsradioTable.isShowMore = NO;
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
