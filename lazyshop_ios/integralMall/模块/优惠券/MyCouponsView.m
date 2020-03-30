//
//  MyCouponsView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/9.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyCouponsView.h"

#import "LYHeaderSwitchView.h"
#import "MyCouponsViewModel.h"
#import "CouponItemCell.h"
#import "CouponItemViewModel.h"

static NSString *cellReuseID = @"CouponItemCell";

@interface MyCouponsView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)MyCouponsViewModel *viewModel;
@property (nonatomic,strong)LYHeaderSwitchView *headerView;

@end

@implementation MyCouponsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    
    self.headerView = [[LYHeaderSwitchView alloc] initWithHeight:50];
    self.headerView.divideStyle = YES;
    [self addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    @weakify(self);
    [self.headerView.clickSignal subscribeNext:^(id x) {
        @strongify(self);
        [self changeDataSourceAtIndex:[x integerValue]];
    }];
    
    // 列表
    UITableView *mainTable = [UITableView new];
    self.mainTable = mainTable;
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    [self addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.headerView.bottom).offset(8);
    }];
    
    [mainTable registerClass:[CouponItemCell class] forCellReuseIdentifier:cellReuseID];
    
    // 下拉刷新
    [self setCurrentRefreshType:AT_ALL_REFRESH_STATE];
    self.noShowLoadingDone = YES;
    self.getDataNumber = PageGetDataNumber;
    [self getRefreshTableData:^{
        @strongify(self);
        [self getData:YES];
    }];
    [self getLoadingMoreTableData:^{
        @strongify(self);
        [self getData:NO];
    }];
}

// 改变数据源
- (void)changeDataSourceAtIndex:(NSInteger)index
{
    self.viewModel.inValidCouponDataSource = index==1 ? YES:NO;
    [self getData:YES];
}
// 获取数据
- (void)getData:(BOOL)refresh
{
    self.mainTable.hidden = YES;
    [self DLLoadingInSelf];
    [self.viewModel getData:YES];
}

#pragma mark -reload
- (void)bindViewModel:(MyCouponsViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.headerView reloadDataWithItemViewModels:viewModel.switchItemViewModels];
    [self bindSignal];
}
// 信号绑定
- (void)bindSignal
{
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case MyCouponsViewModel_Signal_Type_GetDataSuccess:
            {
                // 获取数据成功
                self.mainTable.hidden = NO;
                [self DLLoadingHideInSelf];
                [self.headerView reload];
                [self setAutoDataArray:x];
            }
                break;
            case MyCouponsViewModel_Signal_Type_GetDataFailed:
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
                
            default:
                break;
        }
    }];
}

#pragma mark -tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponItemViewModel *itemVM = [self.viewModel itemViewModelAtIndexPath:indexPath];
    return itemVM.UIHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    CouponItemViewModel *itemVM = [self.viewModel itemViewModelAtIndexPath:indexPath];
    [cell bindViewModel:itemVM];
    @weakify(self);
    [[cell.clickSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel useCouponAtIndexPath:indexPath];
    }];
    return cell;
}

@end
