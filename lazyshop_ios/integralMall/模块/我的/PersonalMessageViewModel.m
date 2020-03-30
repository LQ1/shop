//
//  PersonalMessageViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/17.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "PersonalMessageViewModel.h"

#import "PersonalMessageTextCellViewModel.h"
#import "PersonalMessageHeadImgCellViewModel.h"

#import "MineService.h"
#import "PersonalMessageModel.h"

@interface PersonalMessageViewModel()

@property (nonatomic,strong)MineService *service;

@end

@implementation PersonalMessageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [MineService new];
    }
    return self;
}

- (void)getData
{
    @weakify(self);
    RACDisposable *disPos = [[self.service getUserInfo] subscribeNext:^(PersonalMessageModel *model) {
        @strongify(self);
        [self dealDataWithModel:model];
    } error:^(NSError *error) {
        @strongify(self);
        [self.fetchListFailedSignal sendNext:error];
    }];
    [self addDisposeSignal:disPos];
}

- (void)dealDataWithModel:(PersonalMessageModel *)model
{
    SignInUser.headImageUrl = model.avatar;
    SignInUser.nickName = model.nickname;
    NSInteger sexNumber = [model.sex integerValue];
    if (sexNumber == 0) {
        SignInUser.sex = UserSexType_Woman;
    }else if (sexNumber == 1){
        SignInUser.sex = UserSexType_Man;
    }else{
        SignInUser.sex = UserSexType_UnKnown;
    }
    SignInUser.mobilePhone = model.mobile;
    SignInUser.birthDay = [CommUtls encodeTime:[CommUtls dencodeTime:model.birthday] format:@"yyyy年MM月dd日"];
    
    PersonalMessageHeadImgCellViewModel *headerCellVM = [[PersonalMessageHeadImgCellViewModel alloc] initWithTitle:@"头像" imgUrl:SignInUser.headImageUrl];
    headerCellVM.actionType = PersonalMessageViewModelSignalType_ClickHeader;
    
    PersonalMessageTextCellViewModel *nickCellVM = [[PersonalMessageTextCellViewModel alloc] initWithTitle:@"昵称" detail:SignInUser.nickName hideArrow:NO];
    nickCellVM.actionType = PersonalMessageViewModelSignalType_ClickNick;
    
    PersonalMessageTextCellViewModel *sexCellVM = [[PersonalMessageTextCellViewModel alloc] initWithTitle:@"性别" detail:[SignInUser sexName] hideArrow:NO];
    sexCellVM.actionType = PersonalMessageViewModelSignalType_ClickSex;
    
    PersonalMessageTextCellViewModel *phoneCellVM = [[PersonalMessageTextCellViewModel alloc] initWithTitle:@"手机号" detail:SignInUser.mobilePhone hideArrow:YES];
    
    PersonalMessageTextCellViewModel *birthDayCellVM = [[PersonalMessageTextCellViewModel alloc] initWithTitle:@"出生日期" detail:SignInUser.birthDay.length?SignInUser.birthDay:@"未填写" hideArrow:model.is_complete == 1];
    birthDayCellVM.actionType = PersonalMessageViewModelSignalType_ClickBirthDay;
    
    self.dataArray = @[headerCellVM,nickCellVM,sexCellVM,phoneCellVM,birthDayCellVM];
    [self.fetchListSuccessSignal sendNext:nil];
}

#pragma mark -list
- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (LYItemUIBaseViewModel *)cellViewModelAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray objectAtIndex:indexPath.row];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYItemUIBaseViewModel *vm = [self cellViewModelAtIndexPath:indexPath];
    self.currentSignalType = vm.actionType;
    if (vm.actionType == PersonalMessageViewModelSignalType_ClickBirthDay) {
        PersonalMessageTextCellViewModel *birthDayCellVM = (PersonalMessageTextCellViewModel *)vm;
        if (birthDayCellVM.hideArrow) {
            return;
        }
    }
    [self.updatedContentSignal sendNext:nil];
}

#pragma mark -更新用户信息
- (void)updateUserInfoField_name:(NSString *)field_name
                     field_value:(NSString *)field_value
{
    @weakify(self);
    self.loading = YES;
    RACDisposable *disPos = [[self.service updateUserInfoField_name:field_name
                                                        field_value:field_value] subscribeNext:^(id x) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:@"修改成功"];
        [self getData];
    } error:^(NSError *error) {
        @strongify(self);
        self.loading = NO;
        [self.tipLoadingSignal sendNext:AppErrorParsing(error)];
        
    }];
    [self addDisposeSignal:disPos];

}

@end
