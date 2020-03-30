//
//  JoinUsCell.m
//  integralMall
//
//  Created by liu on 2018/10/8.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "JoinUsCell.h"
#import "PartnerSimpleIntroViewController.h"
#import "DataViewModel.h"
#import "HomeViewController.h"
#import "CashierDeskViewController.h"
#import "WithdrawInfoViewController.h"
#import "MyCorpsInfoViewController.h"
#import "PaymentViewController.h"
#import "PaymentViewModel.h"
#import "JoinPaySuccessViewController.h"
#import "PartnerCompactViewController.h"
#import "JoinPartnerCellViewModel.h"
#import "ImageLoadingUtils.h"

#define CELL_HEIGHT 120

@implementation JoinUsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //[self setBackgroundColor:[UIColor redColor]];
    }
    return self;
}

- (void)addViews{
    self.clipsToBounds = YES;
    UIColor *cLine = [UIColor colorWithRed:0xf3/255.0f green:0xf4/255.0f blue:0xf5/255.0f alpha:1];
    
    // 上面的颜色
    UIView *viewLine1 = [[UIView alloc] init];
    viewLine1.backgroundColor = cLine;
    [self addSubview:viewLine1];

    [viewLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_isPageMine) {
            make.left.top.right.height.mas_equalTo(0);
        } else {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(20);
            make.height.mas_equalTo(10);
        }
    }];
    
    // 下面的空白区域
    UIView *viewLine2 = [[UIView alloc] init];
    viewLine2.backgroundColor = cLine;
    [self addSubview:viewLine2];
    
    [viewLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_isPageMine) {
            make.left.bottom.right.height.mas_equalTo(0);
        } else {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(10);
        }
    }];
    
    // 图片
    UIImageView *imgBg = [[UIImageView alloc] init];
    imgBg.userInteractionEnabled = YES;
    [ImageLoadingUtils loadImageWithOriScaleType:imgBg withURL:_partnerModel.image];
    //imgBg.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imgBg];
    
    [imgBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(viewLine1.bottom).offset(8);
        make.bottom.mas_equalTo(viewLine2.top).offset(0);
    }];
    
    // 点击事件
    UITapGestureRecognizer *gesture_goto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_toJoinUs:)];
    [imgBg addGestureRecognizer:gesture_goto];
    
}

//我的界面使用
- (void)reload:(BOOL)isPageMine{
    _isPageMine = isPageMine;
    if (SignInUser) {
        _partnerModel = SignInUser.partner;
    }else{
        _partnerModel = [AccountService shareInstance].partner;
    }
    
    [self addViews];
}

//跳转到合伙人
- (void)gesture_toJoinUs:(id)sender{
    
    // tabbar有选中的导航 使用选中导航
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController *tabbar = appDelegate.tabBarController;
    UINavigationController *nav = tabbar.viewControllers[tabbar.selectedIndex];

    // 跳转到加入合伙人
    [PublicEventManager judgeLoginToPushWithNavigationController:nav pushBlock:^{
        //@strongify(self);
        
        [[self getParentViewController].view DLLoadingInSelf];
        [self performSelectorInBackground:@selector(thread_query) withObject:nil];
        
        
    }];
}

- (UIViewController*)getParentViewController{
    UIResponder *responder = self.nextResponder;
    while (nil != (responder = responder.nextResponder)) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)responder;
        }
    }
    return nil;
}

#pragma mark -bind
- (void)bindViewModel:(JoinPartnerCellViewModel*)jpcViewModel
{
    _partnerModel = [jpcViewModel.childViewModels objectAtIndex:0];
    
    [self addViews];
}

- (void)thread_query{
    PartnerMyPageModel *pmpm = [[DataViewModel getInstance] partnerMy];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self getParentViewController].view DLLoadingHideInSelf];
        
        if (pmpm) {
            [PublicEventManager gotoPartnerPageWithNavigationController:nil withPartnerMyPageModel:pmpm withRefUsrId:@""];
        }
    });
    
}

@end
