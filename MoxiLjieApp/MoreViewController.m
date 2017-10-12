//
//  MoreViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/5.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

//更多

#import "MoreViewController.h"
#import "MoreCell.h"
#import "FMPlayViewController.h"
#import "MoreViewModel.h"

@interface MoreViewController ()<UITableViewDelegate, UITableViewDataSource, RefreshTableViewDelegate>

@property (weak, nonatomic) IBOutlet JJRefreshTabView *moreTable;

@property (nonatomic, assign) int page;
@property (nonatomic, strong) MoreViewModel *viewmodel;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - data
- (void)initViewModelBinding {
    self.viewmodel = [[MoreViewModel alloc] init];
    self.viewmodel.catogry = self.catagory;
    [self loadDataWithRefresh:YES];
}

- (void)loadDataWithRefresh:(BOOL)isRefresh {
    
    [self showWaiting];
    @weakSelf(self);
    [self.viewmodel getMoreDataWithRefresh:isRefresh type:self.type success:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf.moreTable reloadData];
        if (weakSelf.viewmodel.moreList.count >= 10) {
            self.moreTable.isShowMore = YES;
        }
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        [weakSelf showMassage:error];
    }];
}

#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewmodel.moreList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreCell *cell = [MoreCell myCellWithTableview:tableView];
    [cell setDataWithModel:self.viewmodel.moreList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FMPlayViewController *play = [[FMPlayViewController alloc] init];
    Player *model = self.viewmodel.moreList[indexPath.row];
    play.user_id = model.newid;

    [self.navigationController pushViewController:play animated:YES];
}

#pragma mark - refresh
//刷新
- (void)refreshTableViewHeader {
    [self loadDataWithRefresh:YES];
}
//加载
- (void)refreshTableViewFooter {
    [self loadDataWithRefresh:NO];
}

- (void)cheakTableViewHasMoreData {
//    self.scanHistoryTable.isShowMore = (self.viewModel.hasMoreData == NO || self.viewModel.scanHistoryArr.count == 0) ? NO : YES;
}

#pragma mark - UI
- (void)initUIView {
    self.navigationItem.title = [NSString stringWithFormat:NSLocalizedString(@"more", nil)];
    [self setBackButton:YES];
    [self setupTable];
}

- (void)setupTable {
    self.moreTable.refreshDelegate = self;
    self.moreTable.CanRefresh = YES;
    self.moreTable.lastUpdateKey = NSStringFromClass([self class]);
    self.moreTable.isShowMore = NO;
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
