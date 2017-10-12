//
//  HomeViewController.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/4.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "HomeViewController.h"
#import "BannerScrollView.h"//banner
#import "HomeTypeCell.h"//8个按钮
#import "HotRecommendCell.h"//热门推荐
#import "NewClassCell.h"//最新心理课/FM
#import "FMRecommendCell.h"//心里电台推荐
#import "HomeHeaderCell.h"//分区头
#import "HomeFootCell.h"//分区尾
#import "MoreViewController.h"//更多
#import "FMPlayViewController.h"//播放
#import "HomeViewModel.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, BannerScrollViewDelegate, TypeDelegate, HotDelegate, FMRecommendDelegate, RefreshTableViewDelegate>

@property (weak, nonatomic) IBOutlet JJRefreshTabView *homeTable;
@property (nonatomic, strong) BannerScrollView *bannerView;
@property (nonatomic, strong) UIImageView *bannerDefaultImg;//banner默认图片
@property (nonatomic, strong) NSMutableArray *imgUrlArr;//banner图片地址

@property (nonatomic, strong) HomeViewModel *viewmodel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)initViewModelBinding {
    self.viewmodel = [[HomeViewModel alloc] init];
    [self loadData];
}

- (void)loadData {
    [self showWaiting];
    @weakSelf(self);
    [self.viewmodel getHomeFMDataWithSuccess:^(BOOL result) {
        [weakSelf hideWaiting];
        [weakSelf setBannerData];
        [weakSelf.homeTable reloadData];
        
    } failture:^(NSString *error) {
        [weakSelf hideWaiting];
        [weakSelf showMassage:error];
    }];
}

#pragma mark - BannerScrollViewDelegate
- (void)bannerTappedIndex:(NSInteger)index tap:(UITapGestureRecognizer *)tap {
    NSLog(@"%ld", index);
    
}

#pragma mark - collection
//8个按钮点击
- (void)didSelectTypeItemAtIndexPath:(NSIndexPath *)indexPath {
    [self gotoMoreVCWithTag:indexPath.row type:1];
}

//热门推荐
- (void)didSelectHotItemAtIndexPath:(NSIndexPath *)indexPath {
    FM *model = self.viewmodel.hotFMArr[indexPath.row];
    [self gotoPlayVCWithUserID:model.newid];
}

//电台推荐
- (void)didSelectFMItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self gotoNewsRadioWithModel:self.viewmodel.diantaiArr[indexPath.row]];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2 || section == 3) {
        return 4;
    } else if (section == 4) return 2;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)//8个按钮
        return 160;
    else if (indexPath.section == 1)//热门推荐
        return 150;
    else if (indexPath.section == 2 || indexPath.section == 3)//最新
        if (indexPath.row == 3) return 35;
        else return 60;
    else//电台推荐
        if (indexPath.row == 0) return 100;
        else return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) { //8个按钮
        HomeTypeCell *cell = [HomeTypeCell myCellWithTableview:tableView typeArr:self.viewmodel.categoryArr];
        cell.typeDelegate = self;
        [cell.typeCollectionview reloadData];
        return cell;
        
    } else if (indexPath.section == 1) {//热门推荐
        HotRecommendCell *cell = [HotRecommendCell myCellWithTableview:tableView hotArr:self.viewmodel.hotFMArr];
        cell.hotDelegate = self;
        [cell.recommendCollectionview reloadData];
        return cell;
        
    } else if (indexPath.section == 2 || indexPath.section == 3) {//最新
        if (indexPath.row == 3) {
            HomeFootCell *footer = [HomeFootCell myCellWithTableview:tableView];
            [footer setTitleWithTitle:self.viewmodel.footerArr[indexPath.section]];
            return footer;
        }
        NewClassCell *cell = [NewClassCell myCellWithTableview:tableView];
        if (indexPath.section == 2) {
            if (self.viewmodel.newlessonArr.count) {
                [cell setDataWithFMModel:self.viewmodel.newlessonArr[indexPath.row]];
            }
        } else {
            if (self.viewmodel.newfmArr.count) {
                [cell setDataWithFMModel:self.viewmodel.newfmArr[indexPath.row]];
            }
        }
        return cell;
        
    } else {//电台推荐
        if (indexPath.row == 1) {
            HomeFootCell *footer = [HomeFootCell myCellWithTableview:tableView];
            [footer setTitleWithTitle:self.viewmodel.footerArr[indexPath.section]];
            return footer;
        }
        FMRecommendCell *cell = [FMRecommendCell myCellWithTableview:tableView fmArr:self.viewmodel.diantaiArr];
        cell.fmDelegate = self;
        [cell.fmCollectionview reloadData];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [UIView new];
    } else {
        HomeHeaderCell *header = [HomeHeaderCell myCellWithTableview:tableView];
        [header setTitleWithTitle:self.viewmodel.headerArr[section]];
        return header;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    } else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return 20;
    }
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 || indexPath.section == 3) {
        if (indexPath.row == 3) {//
            [self gotoMoreVCWithTag:nil type:indexPath.section];
        } else {//
            if (indexPath.section == 2) {
                FM *model = self.viewmodel.newlessonArr[indexPath.row];
                [self gotoPlayVCWithUserID:model.newid];
            } else {
                FM *model = self.viewmodel.newfmArr[indexPath.row];
                [self gotoPlayVCWithUserID:model.newid];
            }
        }
    }
    if (indexPath.section == 4 && indexPath.row == 1) {//电台
        [self gotoDiscoverRadioWithTitle:[NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.row]];
    }
}

#pragma mark - refresh
//刷新
- (void)refreshTableViewHeader {
    [self loadData];
}

#pragma mark - UI
- (void)initUIView {
    self.imgUrlArr = [[NSMutableArray alloc] initWithObjects:@"http://img15.3lian.com/2015/h1/280/d/5.jpg", @"http://img39.51tietu.net/pic/2017-011003/20170110030923zgwnujrdwlu107946.jpg", @"http://img15.3lian.com/2015/a1/16/d/205.jpg", nil];
    [self setUpBannerView];
    [self setupTable];
    self.navigationItem.title = NSLocalizedString(@"home", nil);
}

- (void)setupTable {
    self.homeTable.refreshDelegate = self;
    self.homeTable.CanRefresh = YES;
    self.homeTable.lastUpdateKey = NSStringFromClass([self class]);
    self.homeTable.isShowMore = NO;
}

- (void)setUpBannerView {
    self.bannerView = [[BannerScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width*180/375)];
    self.bannerView.delegate = self;
    self.homeTable.tableHeaderView = self.bannerView;
    
    self.bannerDefaultImg = [[UIImageView alloc] init];
    self.bannerDefaultImg.frame = self.bannerView.bounds;
    self.bannerDefaultImg.image = [UIImage imageNamed:@"normal"];
    self.bannerDefaultImg.contentMode = UIViewContentModeScaleAspectFill;
    self.bannerDefaultImg.clipsToBounds = YES;
    [self.bannerView addSubview:self.bannerDefaultImg];
}

- (void)setBannerData {
    if (self.viewmodel.bannerImgArr.count > 0) {
        //把图片地址数组赋值给banner的地址数组
        self.bannerView.imageUrls = self.viewmodel.bannerImgArr;
        if (self.bannerDefaultImg) {
            [self.bannerDefaultImg removeFromSuperview];
            self.bannerDefaultImg = nil;
        }
    }
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
