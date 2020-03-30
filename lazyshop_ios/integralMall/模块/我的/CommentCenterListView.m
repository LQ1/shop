//
//  CommentCenterListView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CommentCenterListView.h"

#import "LYHeaderSwitchView.h"
#import "CommentCenterListViewModel.h"
#import "LYItemUIBaseViewModel.h"
#import "CommentCenterListItemCell.h"

@interface CommentCenterListView()

@property (nonatomic,strong)CommentCenterListViewModel *viewModel;

@end

@implementation CommentCenterListView

- (instancetype)initWithViewModel:(CommentCenterListViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self addViews];
        [self bindSingal];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    // 头视图
    CGFloat headerHeight = 40.0f;
    LYHeaderSwitchView *headerView = [[LYHeaderSwitchView alloc] initWithHeight:headerHeight];
    headerView.divideStyle = YES;
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(headerHeight);
    }];
    // 信号绑定
    @weakify(self);
    [headerView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self changeToListWithType:[x intValue]];
    }];
    [headerView reloadDataWithItemViewModels:[self.viewModel fetchHeadSwitchViewModels]];
    
    // 列表
    UITableView *mainTable = [UITableView new];
    self.mainTable = mainTable;
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    [self addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    // 下拉刷新
    [self setCurrentRefreshType:AT_ALL_REFRESH_STATE];
    self.noShowLoadingDone = YES;
    self.getDataNumber = PageGetDataNumber;
    [self getRefreshTableData:^{
        @strongify(self);
        [self.viewModel getData:YES];
    }];
    [self getLoadingMoreTableData:^{
        @strongify(self);
        [self.viewModel getData:NO];
    }];
}
// 获取数据
- (void)getData:(BOOL)refresh
{
    self.mainTable.hidden = YES;
    [self.viewModel getData:refresh];
    [self DLLoadingInSelf];
}
// 切换显示
- (void)changeToListWithType:(int)type
{
    self.viewModel.isComment = type>0?YES:NO;
    [self getData:YES];
}

#pragma mark -信号
- (void)bindSingal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case CommentCenterListViewModel_Signal_Type_FetchListSuccess:
            {
                // 获取收据成功
                NSArray *array = x;
                if (array.count) {
                    self.mainTable.hidden = NO;
                    [self setAutoDataArray:x];;
                    [self DLLoadingHideInSelf];
                }else{
                    self.mainTable.hidden = YES;
                    [self DLLoadingCycleInSelf:^{
                        @strongify(self);
                        [self getData:YES];
                    } code:DLDataEmpty title:@"暂无评价商品" buttonTitle:LOAD_FAILED_RETRY];
                }
            }
                break;
            case CommentCenterListViewModell_Signal_Type_FetchListFailed:
            {
                // 获取数据失败
                NSError *error = x;
                NSString *title = AppErrorParsing(error);
                if (self.currentRefreshState == AT_NO_REFRESH_STATE) {
                    [self DLLoadingCycleInSelf:^{
                        @strongify(self);
                        [self getData:YES];
                    } code:error.code title:title buttonTitle:LOAD_FAILED_RETRY];
                }else{
                    [self recoverShowState];
                    [DLLoading DLToolTipInWindow:title];
                }
            }
                break;
            case CommentCenterListViewModel_Signal_Type_TipLoading:
            {
                // 弹框
                [DLLoading DLToolTipInWindow:x];
            }
                break;
                
            default:
                break;
        }
    }];
}


#pragma mark -table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [UIView new];
    header.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [UIView new];
    footer.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    return footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *cellVM = [self.viewModel cellViewModelForRowAtIndexPath:indexPath];
    return cellVM.UIHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *cellVM = [self.viewModel cellViewModelForRowAtIndexPath:indexPath];
    CommentCenterListItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellVM.UIReuseID];
    if (!cell) {
        cell = [[NSClassFromString(cellVM.UIClassName) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellVM.UIReuseID];
    }
    [cell bindViewModel:cellVM];
    @weakify(self);
    [[cell.clickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel clickCommentForRowAtIndexPath:indexPath];
    }];
    return cell;
}

@end
