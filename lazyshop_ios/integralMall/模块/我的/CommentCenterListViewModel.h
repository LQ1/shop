//
//  CommentCenterListViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

typedef NS_ENUM(NSInteger,CommentCenterListViewModel_Signal_Type)
{
    CommentCenterListViewModel_Signal_Type_FetchListSuccess = 0,
    CommentCenterListViewModell_Signal_Type_FetchListFailed,
    CommentCenterListViewModell_Signal_Type_GotoCommentDetail,
    CommentCenterListViewModell_Signal_Type_GotoSendComment,
    CommentCenterListViewModel_Signal_Type_TipLoading
};

@interface CommentCenterListViewModel : BaseViewModel

@property (nonatomic, assign) CommentCenterListViewModel_Signal_Type currentSignalType;

@property (nonatomic,assign) BOOL isComment;

/*
 *  头部显示
 */
- (NSArray *)fetchHeadSwitchViewModels;

- (void)getData:(BOOL)refresh;

- (NSInteger)numberOfSections;
- (id)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)clickCommentForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
