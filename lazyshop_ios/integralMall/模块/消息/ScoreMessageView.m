//
//  ScoreMessageView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ScoreMessageView.h"

#import "ScoreMessageViewModel.h"
#import "ScoreMessageCell.h"
#import "LYItemUIBaseViewModel.h"

static NSString *cellReuseID = @"ScoreMessageCell";

@interface ScoreMessageView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)ScoreMessageViewModel *viewModel;

@end


@implementation ScoreMessageView

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
        make.edges.mas_equalTo(0);
    }];
    [mainTable registerClass:[ScoreMessageCell class] forCellReuseIdentifier:cellReuseID];
    // header
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 37)];
    [header addBottomLine];
    self.mainTable.tableHeaderView = header;
    // 下拉刷新
    [self setCurrentRefreshType:AT_ALL_REFRESH_STATE];
    self.noShowLoadingDone = YES;
    self.getDataNumber = PageGetDataNumber;
    @weakify(self);
    [self getRefreshTableData:^{
        @strongify(self);
        [self getData:YES];
    }];
    [self getLoadingMoreTableData:^{
        @strongify(self);
        [self getData:NO];
    }];
}
// 获取数据
- (void)getData:(BOOL)refresh
{
    [self.viewModel getData:refresh];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(ScoreMessageViewModel *)viewModel
{
    self.viewModel = viewModel;
    self.autoDataArray = self.viewModel.dataArray;
    // 这里强制再请求一次分页 避免消息cell过短 导致下一次的加载更多显示不出来
    if (self.autoDataArray.count == PageGetDataNumber) {
        [self getData:NO];
    }
}

#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScoreMessageCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScoreMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    LYItemUIBaseViewModel *cellVM = [self.viewModel cellVMForRowAtIndexPath:indexPath];
    [cell bindViewModel:cellVM];
    return cell;
}

@end
