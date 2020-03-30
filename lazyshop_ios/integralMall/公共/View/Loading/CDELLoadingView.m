//
//  CDELLoadingView.m
//  MobileClassPhone
//
//  Created by SL on 14-4-13.
//  Copyright (c) 2014年 cyx. All rights reserved.
//

#import "CDELLoadingView.h"
#import <DLUIKit/LLARingSpinnerView.h>
#import <DLUtls/CommUtls.h>
#import <Masonry/Masonry.h>
#import <DLUIKit/DLLoadingSetting.h>

typedef void (^CDELCycleLoading)();

@interface CDELLoadingView()

/**
 内容view
 */
@property (nonatomic,strong) UIView *contentView;

/**
 logo图片
 */
@property (nonatomic,strong) UIImageView *logoImage;

/**
 提示Label
 */
@property (nonatomic,strong) UILabel *titleLabel;

/**
 重试button
 */
@property (nonatomic,strong) UIButton *cycleButton;

/**
 加载框
 */
@property (nonatomic,strong) LLARingSpinnerView *loading;

/**
 重复加载调用的方法
 */
@property (nonatomic,copy) CDELCycleLoading cycleBlock;

- (void)startAnimating;
- (void)stopAnimating;

@end

@implementation CDELLoadingView

- (void)dealloc {
    CLog(@"dealloc -- %@",self.class);
}

- (instancetype)init{
    self = [super init];
    if (self) {
        UIView *contentView = [UIView new];
        [self addSubview:contentView];
        [contentView setBackgroundColor:[UIColor clearColor]];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        self.contentView = contentView;
        
        UIImageView *logoImage = [UIImageView new];
        [contentView addSubview:logoImage];
        [logoImage setBackgroundColor:[UIColor clearColor]];
        self.logoImage = logoImage;
        
        LLARingSpinnerView *loading = [[LLARingSpinnerView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [contentView addSubview:loading];
        loading.circleColor = [CommUtls colorWithHexString:APP_MainColor];
        [loading mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentView);
            make.top.mas_equalTo(0);
            make.width.height.mas_equalTo(60);
        }];
        self.loading = loading;
        
        UILabel *titleLabel = [UILabel new];
        [contentView addSubview:titleLabel];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextColor:[CommUtls colorWithHexString:@"#999999"]];
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [titleLabel setNumberOfLines:0];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel = titleLabel;
    }
    return self;
}

- (void)showCDELLoadingView:(CDELLoadingType)type
                      cycle:(void(^)())cycle
                      title:(NSString *)title
                buttonTitle:(NSString *)buttonTitle
                customImage:(NSString *)customImage {
    self.cycleBlock = cycle;
    self.cycleButton.hidden = YES;
    [self stopAnimating];
    
    NSString *imageName = nil;
    switch (type) {
        case CDELLoading: {
            //加载中
            imageName = @"refresh_logo.png";
        }
            break;
        case CDELLoadingCustom: {
            if (!cycle) {
                break;
            }
        }
        case CDELLoadingCycle: {
            //加载失败，可重新加载
            imageName = @"加载失败";
            if (!self.cycleButton) {
                UIButton *cycleButton = [UIButton buttonWithType:UIButtonTypeCustom];
                cycleButton.titleLabel.font = [UIFont systemFontOfSize:15];
                [cycleButton setTitleColor:[CommUtls colorWithHexString:APP_MainColor] forState:UIControlStateNormal];
                cycleButton.frame = CGRectMake(0, 0, 160, 40);
                [cycleButton addTarget:self action:@selector(cycleLoading) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:cycleButton];
                self.cycleButton = cycleButton;
                
                UIView *bgView = [UIView new];
                [self.contentView insertSubview:bgView belowSubview:cycleButton];
                [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(cycleButton);
                }];
                bgView.layer.borderColor = [CommUtls colorWithHexString:APP_MainColor].CGColor;
                bgView.layer.borderWidth = 1;
                bgView.alpha = .2;
                RAC(bgView, hidden) = RACObserve(cycleButton, hidden);
            }
            [self.cycleButton setTitle:buttonTitle?buttonTitle:@"重试" forState:UIControlStateNormal];
            self.cycleButton.hidden = NO;
        }
            break;
        case CDELLoadingDone: {
            //加载完成，没有数据显示，不需要重新加载，友好提示
            imageName = @"加载失败";
        }
            break;
        case CDELLoadingRemove: {
            [self removeFromSuperview];
            return;
        }
            break;
        default:
            break;
    }
    
    if (type == CDELLoadingCustom) {
        imageName = customImage;
    }
    
    if ([title isEqualToString:NO_NET_STATIC_SHOW] && imageName) {
        imageName = @"加载失败";
    }
    
    self.logoImage.hidden = (imageName==nil);
    [self.logoImage setImage:[UIImage imageNamed:imageName]];
    [self.logoImage sizeToFit];
    
    self.titleLabel.hidden = (title==nil);
    CGFloat minWidth = self.superview.frame.size.width;
    //解决自动布局下superview的宽度高度为0
    if (!minWidth) {
        minWidth = MIN([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }
    self.titleLabel.text = title;
    self.titleLabel.frame = CGRectMake(0, 0, minWidth-20, CGFLOAT_MAX);
    [self.titleLabel sizeToFit];
    
    CGFloat width = 0;
    CGFloat height = 0;
    if (type == CDELLoading) {
        width = MAX(self.loading.frame.size.width, self.titleLabel.frame.size.width);
        height = self.loading.frame.size.height+(title?10+self.titleLabel.frame.size.height:0);
    } else if (!self.cycleButton.hidden) {
        width = MAX(MAX(self.logoImage.frame.size.width, self.titleLabel.frame.size.width), self.cycleButton.frame.size.width);
        height = (imageName?self.logoImage.frame.size.height+10:0) + (title?self.titleLabel.frame.size.height+10:0) + self.cycleButton.frame.size.height;
    } else {
        width = MAX(self.logoImage.frame.size.width, self.titleLabel.frame.size.width);
        height = (imageName?self.logoImage.frame.size.height:0) + (title?self.titleLabel.frame.size.height:0) + (imageName&&title?10:0);
    }
    
    if (type == CDELLoading) {
        [self startAnimating];
        if (imageName) {
            [self.logoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self.loading);
                make.width.mas_equalTo(self.logoImage.frame.size.width);
                make.height.mas_equalTo(self.logoImage.frame.size.height);
            }];
        }
//        self.logoImage.hidden = YES;
        if (title) {
            [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.contentView);
                make.top.mas_equalTo(self.loading.mas_bottom).mas_equalTo(10);
                make.width.mas_equalTo(self.titleLabel.frame.size.width);
                make.height.mas_equalTo(self.titleLabel.frame.size.height);
            }];
        }
    } else {
        [self.logoImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(self.logoImage.frame.size.width);
            make.height.mas_equalTo(self.logoImage.frame.size.height);
        }];
        if (title) {
            [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.contentView);
                make.top.mas_equalTo(self.logoImage.mas_bottom).mas_equalTo(10);
                make.width.mas_equalTo(self.titleLabel.frame.size.width);
                make.height.mas_equalTo(self.titleLabel.frame.size.height);
            }];
        }
        if (!self.cycleButton.hidden){
            [self.cycleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.contentView);
                make.width.mas_equalTo(self.cycleButton.frame.size.width);
                make.height.mas_equalTo(self.cycleButton.frame.size.height);
                make.top.mas_equalTo(title?self.titleLabel.mas_bottom:self.logoImage.mas_bottom).mas_equalTo(10);
            }];
        }
    }
    
    if (!([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0? YES : NO) && ([self.superview isKindOfClass:[UITableView class]] || [self.superview isKindOfClass:[UICollectionView class]])) {
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
								| UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        self.frame = CGRectMake(0, 0, minWidth, height);
        [self setCenter:CGPointMake(self.superview.frame.size.width/2, self.superview.frame.size.height/2)];
    } else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
            make.center.mas_equalTo(0);
        }];
    }
}

//重新加载数据
- (void)cycleLoading {
    if (self.cycleBlock) {
        self.cycleBlock();
    }
}

#pragma mark - 定时器
- (void)startAnimating {
    [self.loading setHidden:NO];
    [self.loading startAnimating];
}

- (void)stopAnimating {
    [self.loading setHidden:YES];
    [self.loading stopAnimating];
}

@end
