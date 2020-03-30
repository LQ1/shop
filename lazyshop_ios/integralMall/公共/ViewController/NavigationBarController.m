//
//  NavagationBarController.m
//  UIDemo
//
//  Created by cyx on 14-10-30.
//  Copyright (c) 2014年 cyx. All rights reserved.
//

#import "NavigationBarController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface NavigationBarController ()<NavigatonBarViewDelegate>

@end

@implementation NavigationBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _navigationBarView = [[NavigatonBarView alloc]initLeftButtonPicNormal:[UIImage imageNamed:@"返回_白"] leftButtonPicHighlight:[UIImage imageNamed:@""] rightButtonPicNormal:[UIImage imageNamed:@""] rightButtonPicHighlight:[UIImage imageNamed:@""] fontColor:[UIColor whiteColor]];
//    _navigationBarView.leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 35);
    _navigationBarView.backGroundImgeView.image = nil;
     _navigationBarView.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
    if([self.navigationController.topViewController isKindOfClass:self.class]&&self.navigationController.viewControllers.count == 1)
        _navigationBarView.navagationBarStyle = None_button_show;
    else
        _navigationBarView.navagationBarStyle = Left_button_Show;
    
    _navigationBarView.titleLabel.font = [UIFont boldSystemFontOfSize:LARGE_FONT_SIZE];
    _navigationBarView.delegate = self;
    [self.view addSubview:_navigationBarView];
    
    [_navigationBarView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo(NAVIGATIONBAR_HEIGHT);
    }];
}


- (void)nearByNavigationBarView:(UIView *)tView isShowBottom:(BOOL)bottom
{
    [tView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navigationBarView.mas_bottom);
        make.left.equalTo(0);
        make.right.equalTo(0);
        if(IsIOS7)
        {
        if(bottom)
            make.bottom.equalTo(self.view.bottom).offset(-TABLE_BAR_HEIGHT);
        else
            make.bottom.equalTo(self.view.bottom);
        }
        else
        {
           make.bottom.equalTo(self.view.bottom);  
        }
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.closeIQKeyboardManager) {
        [[IQKeyboardManager sharedManager] setEnable:NO];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.closeIQKeyboardManager) {
        [[IQKeyboardManager sharedManager] setEnable:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (IsIOS7) {
        if (self.closeInteractiveGesture) {
            CLog(@"该页面不支持ios7手势NO===%@",self.class);
        }else{
            CLog(@"该页面支持ios7手势YES====%@",self.class);
        }
        self.navigationController.interactivePopGestureRecognizer.enabled = !self.closeInteractiveGesture;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClick
{
}



@end
