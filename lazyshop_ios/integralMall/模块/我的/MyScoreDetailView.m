//
//  MyScoreDetailView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "MyScoreDetailView.h"

#import "MyScoreDetailSegementView.h"
#import "MyScoreViewModel.h"
#import "MyScoreDetailItemCell.h"

static NSString *cellReuseID = @"MyScoreDetailItemCell";

@interface MyScoreDetailView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MyScoreDetailSegementView *segMentView;
@property (nonatomic, strong) MyScoreViewModel *viewModel;

@end

@implementation MyScoreDetailView

- (instancetype)initWithViewModel:(MyScoreViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self addViews];
        [self bindSignal];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [UIColor whiteColor];
    // tip
    UILabel *tipLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                     textAlignment:0
                                         textColor:App_TxtBColor
                                      adjustsWidth:NO
                                      cornerRadius:0
                                              text:@"积分明细"];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
    }];
    // segement
    MyScoreDetailSegementView *segMentView = [MyScoreDetailSegementView new];
    self.segMentView = segMentView;
    [self addSubview:segMentView];
    [segMentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipLabel.bottom).offset(17);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(MyScoreDetailSegementViewWidth);
        make.height.mas_equalTo(MyScoreDetailSegementViewHeight);
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
        make.top.mas_equalTo(self.segMentView.bottom).offset(18);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    [mainTable registerClass:[MyScoreDetailItemCell class] forCellReuseIdentifier:cellReuseID];
    
    // 下拉刷新
    [self setCurrentRefreshType:AT_LOADING_MORE_STATE];
    self.noShowLoadingDone = YES;
    self.getDataNumber = MyScoreListPageNum;
    @weakify(self);
    [self getLoadingMoreTableData:^{
        @strongify(self);
        [self getDataMore:YES];
    }];

}

#pragma mark -getData
- (void)getDataMore:(BOOL)more
{
    if (!more) {
        self.mainTable.hidden = YES;
        [self DLLoadingInSelf];
    }
    [self.viewModel getScoreListWithMore:more];
}

#pragma mark -bindSignal
- (void)bindSignal
{
    @weakify(self);
    [self.segMentView setChangeClickBlock:^(MyScoreDetailSegementViewClickType clickType) {
        @strongify(self);
        [self.viewModel changeDataSourceToClickType:clickType];
    }];
    
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        switch (self.viewModel.currentSignalType) {
            case MyScoreViewModel_Signal_Type_FetchScoreListSuccess:
            {
                @strongify(self);
                self.mainTable.hidden = NO;
                [self DLLoadingHideInSelf];
                self.autoDataArray = x;
            }
                break;
            case MyScoreViewModel_Signal_Type_FetchScoreListError:
            {
                @strongify(self);
                NSError *error = x;
                self.mainTable.hidden = YES;
                [self DLLoadingDoneInSelf:CDELLoadingDone
                                    title:AppErrorParsing(error)];
            }
                break;
            default:
                break;
        }
    }];
}

#pragma mark -list
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MyScoreDetailItemCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyScoreDetailItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    [cell bindViewModel:[self.viewModel cellModelForRowAtIndexPath:indexPath]];
    return cell;
}

@end
