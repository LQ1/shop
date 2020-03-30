//
//  MyBargainView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MyBargainView.h"

#import "MyBargainItemCell.h"
#import "MyBargainViewModel.h"
#import "MyBargainSecFooterView.h"

static NSString *cellReuseID = @"MyBargainItemCell";
static NSString *footerReuseID = @"MyBargainSecFooterView";

@interface MyBargainView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)MyBargainViewModel *viewModel;

@end

@implementation MyBargainView

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
    // 背景
    self.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    // 列表
    UITableView *mainTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.mainTable = mainTable;
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = [UIColor clearColor];
    [self addSubview:mainTable];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [mainTable registerClass:[MyBargainItemCell class] forCellReuseIdentifier:cellReuseID];
    [mainTable registerClass:[MyBargainSecFooterView class] forHeaderFooterViewReuseIdentifier:footerReuseID];
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
- (void)reloadDataWithViewModel:(MyBargainViewModel *)viewModel
{
    self.viewModel = viewModel;
    self.autoDataArray = viewModel.dataArray;
}

#pragma mark -table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7.5f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [UIView new];
    header.backgroundColor = [CommUtls colorWithHexString:@"#f5f5f5"];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return MyBargainSecFooterViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    MyBargainSecFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerReuseID];
    @weakify(self);
    [[footer.clickSignal takeUntil:footer.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        @strongify(self);
        switch ([x integerValue]) {
            case MyBargainSecFooterViewClickType_InviteFriends:
            {
                // 邀请好友砍价
                [self.viewModel inviteFriendsAtSection:section];
            }
                break;
            case MyBargainSecFooterViewClickType_ImediatelyBuy:
            {
                // 立即购买
                [self.viewModel immediatelyBuyAtSection:section];
            }
                break;
                
            default:
                break;
        }
    }];
    [footer bindViewModel:[self.viewModel itemViewModelInSection:section]];
    return footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyBargainItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel cellVMForRowAtIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
}

@end
