//
//  MyScoreViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "MyScoreViewModel.h"

#import "MyScoreDetailItemModel.h"
#import "MyScoreService.h"
#import "MyScoreGrowthDetailModel.h"

@interface MyScoreViewModel ()

@property (nonatomic, strong) MyScoreService *service;
@property (nonatomic, copy) NSString *change_type;

@end

@implementation MyScoreViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.change_type = @"";
        self.service = [MyScoreService new];
    }
    return self;
}

#pragma mark -获取数据
// 获取成长值信息
- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getUserGrowthDetail] subscribeNext:^(MyScoreGrowthDetailModel *model) {
        @strongify(self);
        // 当前成长信息
        self.vipLevelName = [SignInUser vipLevelName];
        // 成长值
        self.growthTip = [NSString stringWithFormat:@"成长值：%ld",(long)model.growth];
        // 下次成长提醒
        if (model.notice.length) {
            self.levelTip = model.notice;
        }else{
            if (model.level == UserVipLevel_Zuan) {
                self.levelTip = @"您的会员等级已是最高";
            }else{
                NSString *nextLevelName = [SignInUser vipLevelNameWithLevel:model.level+1];
                self.levelTip = [NSString stringWithFormat:@"还需要%ld积分 就可升级到%@",(long)model.residue,nextLevelName];
            }
        }
        [self.fetchListSuccessSignal sendNext:nil];
    } error:^(NSError *error) {
        @strongify(self);
        [self.fetchListFailedSignal sendNext:AppErrorParsing(error)];
    }];
    [self addDisposeSignal:disPos];
}
// 获取积分列表
- (void)getScoreListWithMore:(BOOL)more
{
    NSString *page = @"1";
    if (more) {
        page = [NSString stringWithFormat:@"%ld",(long)(self.dataArray.count/MyScoreListPageNum+1)];
    }
    @weakify(self);
    RACDisposable *disPos = [[self.service getUserScoreListWithChange_type:self.change_type
                                                                      page:page] subscribeNext:^(id x) {
        @strongify(self);
        if (!more) {
            self.dataArray = [NSArray arrayWithArray:x];
        }else{
            self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:x];
        }
        self.currentSignalType = MyScoreViewModel_Signal_Type_FetchScoreListSuccess;
        [self.updatedContentSignal sendNext:self.dataArray];
    } error:^(NSError *error) {
        @strongify(self);
        self.currentSignalType = MyScoreViewModel_Signal_Type_FetchScoreListError;
        [self.updatedContentSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

#pragma mark -跳转签到
- (void)gotoSignalVC
{
    self.currentSignalType = MyScoreViewModel_Signal_Type_GotoSignalVC;
    [self.updatedContentSignal sendNext:nil];
}

#pragma mark -切换列表类型
- (void)changeDataSourceToClickType:(MyScoreDetailSegementViewClickType)cellType
{
    switch (cellType) {
        case MyScoreDetailSegementViewClickType_All:
        {
            self.change_type = @"";
            [self getScoreListWithMore:NO];
        }
            break;
        case MyScoreDetailSegementViewClickType_Income:
        {
            self.change_type = @"1";
            [self getScoreListWithMore:NO];
        }
            break;
        case MyScoreDetailSegementViewClickType_Outcome:
        {
            self.change_type = @"0";
            [self getScoreListWithMore:NO];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -list
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (id)cellModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

@end
