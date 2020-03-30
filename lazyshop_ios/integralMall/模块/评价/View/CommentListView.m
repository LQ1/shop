//
//  CommentListView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CommentListView.h"

#import "CommentListViewModel.h"
#import "CommentRowItemViewModel.h"
#import "CommentRowItemCell.h"

static NSString *cellReuseID = @"CommentRowItemCell";

@interface CommentListView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)CommentListViewModel *viewModel;

@end

@implementation CommentListView

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
    self.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    // 列表
    UITableView *mainTable = [UITableView new];
    self.mainTable = mainTable;
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    [self addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12.5);
        make.left.right.bottom.mas_equalTo(0);
    }];
    [mainTable registerClass:[CommentRowItemCell class] forCellReuseIdentifier:cellReuseID];
    // 下拉刷新
    [self setCurrentRefreshType:AT_REFRESH_STATE];
    self.noShowLoadingDone = YES;
    @weakify(self);
    [self getRefreshTableData:^{
        @strongify(self);
        [self.viewModel getData];
    }];
}

// 获取数据
- (void)getData
{
    self.mainTable.hidden = YES;
    [self.viewModel getData];
    [self DLLoadingInSelf];
}

#pragma mark -信号绑定
- (void)bindViewModel:(CommentListViewModel *)viewModel
{
    if (self.viewModel) {
        return;
    }
    self.viewModel = viewModel;
    
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        self.mainTable.hidden = NO;
        [self doneLoadingTableViewData];
        [self DLLoadingHideInSelf];
    }];
    
    [self.viewModel.errorSignal subscribeNext:^(id x) {
        @strongify(self);
        // 获取数据失败
        NSError *error = x;
        NSString *title = AppErrorParsing(error);
        if (self.currentRefreshState == AT_NO_REFRESH_STATE) {
            [self DLLoadingCycleInSelf:^{
                @strongify(self);
                [self getData];
            } code:error.code title:title buttonTitle:LOAD_FAILED_RETRY];
        }else{
            [self recoverShowState];
            [DLLoading DLToolTipInWindow:title];
        }
    }];
    
    [self getData];
}

#pragma mark -tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentRowItemViewModel *vm = [self.viewModel cellViewModelForRowAtIndexPath:indexPath];
    return vm.UIHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentRowItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel cellViewModelForRowAtIndexPath:indexPath]];
    return cell;
}

@end
