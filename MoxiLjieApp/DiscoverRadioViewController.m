//
//  DiscoverRadioViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/6.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

//主播推荐，发现主播

#import "DiscoverRadioViewController.h"
#import "FMRecommendCell.h"//新晋主播cell
#import "RadioCell.h"//热门主播cell
#import "HomeHeaderCell.h"//分区头
#import "NewsRadioViewController.h"//主播首页
#import "DiscoverRadioViewModel.h"

@interface DiscoverRadioViewController ()<UITableViewDelegate, UITableViewDataSource, FMRecommendDelegate, RefreshTableViewDelegate>

@property (weak, nonatomic) IBOutlet JJRefreshTabView *radioTable;

@property (nonatomic, strong) DiscoverRadioViewModel *viewmodel;

@end

@implementation DiscoverRadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[DiscoverRadioViewModel alloc] init];
    [self loadData];
    [self loadAuthorListDataWithRefresh:YES];
}

- (void)loadData {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getMoreDTDataWithSuccess:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf.radioTable reloadData];
        
    } failture:^(NSString *error) {
        
        [weakSelf hideWaiting];
        [weakSelf showMassage:error];
    }];
}

- (void)loadAuthorListDataWithRefresh:(BOOL)isRefresh {
    @weakSelf(self);
    [self showWaiting];
    [self.viewmodel getAuthorListWithRefresh:isRefresh success:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf.radioTable reloadData];
        
        if (weakSelf.viewmodel.hotListArr.count >= 10) {
            weakSelf.radioTable.isShowMore = YES;
        }
    } failure:^(NSString *errorStr) {
        [weakSelf hideWaiting];
        [weakSelf showMassage:errorStr];
    }];
}

#pragma mark - FMRecommend
- (void)didSelectFMItemAtIndexPath:(NSIndexPath *)indexPath {
    [self gotoNewsRadioWithModel:self.viewmodel.newlistArr[indexPath.row]];
}

#pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    return self.viewmodel.hotListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FMRecommendCell *cell = [FMRecommendCell myCellWithTableview:tableView fmArr:self.viewmodel.newlistArr];
        cell.fmDelegate = self;
        [cell.fmCollectionview reloadData];
        return cell;
    } else {
        RadioCell *cell = [RadioCell myCellWithTableview:tableView];
        if (self.viewmodel.hotListArr.count) {
            [cell setDataWithModel:self.viewmodel.hotListArr[indexPath.row]];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section  {
    HomeHeaderCell *header = [HomeHeaderCell myCellWithTableview:tableView];
    [header setTitleWithTitle:self.viewmodel.headerArr[section]];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self gotoNewsRadioWithModel:self.viewmodel.hotListArr[indexPath.row]];
}

#pragma mark - refresh
//刷新
- (void)refreshTableViewHeader {
    [self loadData];
    [self loadAuthorListDataWithRefresh:YES];
}
//加载
- (void)refreshTableViewFooter {
    [self loadAuthorListDataWithRefresh:NO];
}

- (void)cheakTableViewHasMoreData {
    //    self.scanHistoryTable.isShowMore = (self.viewModel.hasMoreData == NO || self.viewModel.scanHistoryArr.count == 0) ? NO : YES;
}

#pragma mark - UI
- (void)initUIView {
    self.navigationItem.title = NSLocalizedString(@"findzhubo", nil);
    [self setBackButton:YES];
    [self setupTable];
}

- (void)setupTable {
    self.radioTable.refreshDelegate = self;
    self.radioTable.CanRefresh = YES;
    self.radioTable.lastUpdateKey = NSStringFromClass([self class]);
    self.radioTable.isShowMore = NO;
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
