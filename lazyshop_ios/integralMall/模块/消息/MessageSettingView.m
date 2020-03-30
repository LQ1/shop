//
//  MessageSettingView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/26.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "MessageSettingView.h"

#import "MessageSettingViewModel.h"
#import "MessageSettingItemCell.h"
#import "LYMainColorButton.h"

static NSString *cellReuseID = @"MessageSettingItemCell";

@interface MessageSettingView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)MessageSettingViewModel *viewModel;
@property (nonatomic,strong)UITableView *mainTable;

@end

@implementation MessageSettingView

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
    // 标题
    UIView *topView = [UIView new];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(36);
    }];
    [topView addBottomLine];
    UILabel *tipLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                     textAlignment:0
                                         textColor:@"#7d7d7d"
                                      adjustsWidth:NO
                                      cornerRadius:0
                                              text:@"消息栏推送开关"];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(topView);
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
        make.top.mas_equalTo(topView.bottom);
    }];
    [mainTable registerClass:[MessageSettingItemCell class] forCellReuseIdentifier:cellReuseID];
    // 清空全部消息
    UIView *tableFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 100)];
    self.mainTable.tableFooterView = tableFooter;
    LYMainColorButton *clearBtn = [[LYMainColorButton alloc] initWithTitle:@"清空全部消息"
                                                            buttonFontSize:MIDDLE_FONT_SIZE
                                                              cornerRadius:3];
    [tableFooter addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(50);
    }];
    @weakify(self);
    clearBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self clearAllMsg];
        return [RACSignal empty];
    }];
}
// 清空全部
- (void)clearAllMsg
{
    @weakify(self);
    LYAlertView *alert = [[LYAlertView alloc] initWithTitle:nil
                                                    message:@"清空全部消息"
                                                     titles:@[@"取消",@"确定"]
                                                      click:^(NSInteger index) {
                                                          if (index == 1) {
                                                              @strongify(self);
                                                              [self.viewModel clearAllMsg];
                                                          }
                                                      }];
    [alert show];
}

#pragma mark -reload
- (void)reloadDataWithViewModel:(MessageSettingViewModel *)viewModel
{
    self.viewModel = viewModel;
    [self.mainTable reloadData];
}

#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MessageSettingItemCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageSettingItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel cellViewModelForRowAtIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectRowAtIndexPath:indexPath];
}

@end
