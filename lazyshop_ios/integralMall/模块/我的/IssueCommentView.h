//
//  IssueCommentView.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectImgBlock)(void);

@class IssueCommentViewModel;

@interface IssueCommentView : UIView

- (instancetype)initWithViewModel:(IssueCommentViewModel *)viewModel;

/**
 *  内容 TextView
 */
@property (nonatomic, strong) UITextView * contentTV;

/**
 *  展示的images
 */
@property (nonatomic, strong) NSMutableArray * imgs;

/**
 *  选择图片
 */
@property (nonatomic, copy) SelectImgBlock selectImg;

/*
 *  是否有输入内容
 */
- (BOOL)hasContentInput;

/*
 *  设置图片
 */
- (void)setImgZone;

/*
 *  收起键盘
 */
- (void)closeVC;

@end
