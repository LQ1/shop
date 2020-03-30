//
//  UIBaseViewController.m
//  HomeDecoration
//
//  Created by xtkj on 15/5/6.
//  Copyright (c) 2015年 anz. All rights reserved.
//

#import "UIBaseViewController.h"



@interface UIBaseViewController ()

@end


@implementation UIBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //self.view.alpha = 0;
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _viewAnimation = [UIViewAnimation new];
    
    self.nPageNum = 1;
    [self initControl];
    [self initData];
}

//设置 状态栏的前景色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initControl{

}

- (void)initData{
    
}

//初始化中间带标题的
- (void)initNavBar:(NSString *)szTitle{
    self.navigationItem.title = szTitle;
}

- (void)initNavBar:(NSString *)szTitle withBackBlock:(BackReturnBlock)backReturnBlock{
    
}

//初始化右键
- (void)initNavBarRightBtn:(NSString*)szRightText withClicked:(SEL)btnClicked{
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:szRightText style:UIBarButtonItemStylePlain target:self action:btnClicked];
    [self.navigationItem setRightBarButtonItem:right];
}

//初始化右键-->图片
- (void)initNavBarRightImg:(UIImage*)image withClicked:(SEL)btnClicked{
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:btnClicked];
    right.imageInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [self.navigationItem setRightBarButtonItem:right];
}

//初始化 中间带加载进度条
- (void)initNavBarWithTitleIndicator{
    UIView *viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 22)];
    //viewTitle.backgroundColor = [UIColor redColor];
    UIActivityIndicatorView *actIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [actIndicatorView startAnimating];
    [viewTitle addSubview:actIndicatorView];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(actIndicatorView.frame.size.width+4, 0, 80, 22)];
    lblTitle.textAlignment = NSTextAlignmentLeft;
    lblTitle.font = [UIFont fontWithName:@"Arial" size:14.0f];
    lblTitle.text = @"加载中...";
    [viewTitle addSubview:lblTitle];
    
    self.navigationItem.titleView = viewTitle;
}


////////////////////////view/////////////////////

- (void)setThinBorder:(UIView*)view{
    view.layer.borderColor = [ColorUtils getLineColor].CGColor;
    view.layer.backgroundColor = [UIColor clearColor].CGColor;
    view.layer.borderWidth = 0.3f;
}

- (void)setBtnDarkBackground:(UIButton*)btn{
    btn.backgroundColor = [ColorUtils getBtnDarkColor];
    [btn setTintColor:[UIColor whiteColor]];
}
- (void)setBtnLightBackground:(UIButton*)btn{
    btn.backgroundColor = [ColorUtils getBtnLightColor];
    [btn setTintColor:[UIColor whiteColor]];
}

- (void)setBtnMasterBackground:(UIButton*)btn{
    btn.backgroundColor = [ColorUtils getBtnMasterColor];
    [btn setTintColor:[UIColor whiteColor]];
}

- (void)setAlphaBackground:(UIView*)view{
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4f];
}

- (void)initProgress{
    if (self.progressView == nil) {
        CGRect rc = {0};
        if (self.navigationItem) {
            //有标题栏
            rc.origin.y = 66;
        }
        rc.size.height = SCREEN_HEIGHT;
        rc.size.width = SCREEN_WIDTH;
        self.progressView = [[ProgressView alloc] initActivWithViewAndFrame:self.view withFrame:rc];
    }
}

//显示加载显示
- (void)showProgressLoadingIndicator:(NSString*)szTips{
    [self initProgress];
    [self.progressView showActivityIndicatorView:szTips];
}
- (void)showProgressLoadingIndicatorWithoutAutoClose:(NSString*)szTips{
    [self initProgress];
    [self.progressView showActivityIndicatorViewWithoutAutoClose:szTips];
}
//关闭加载显示
- (void)closeProgressLoadingIndicator{
    [self.progressView closeActivityIndicator];
}


/////////////////////////////////////end//////////////////////



/////////////////////////////////////show tips//////////////////////
- (void)showTipWithDismissWindow:(NSString*)szTips{
    [self showTipCenter:szTips];
    //3s后关闭窗体
    [self performSelector:@selector(dismissThisViewController) withObject:nil afterDelay:3];
}

- (void)dismissThisViewController{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)showTipWithDismiss:(NSString*)szTipsMsg{
    [self performSelectorOnMainThread:@selector(showTipWithDismissWindow:) withObject:szTipsMsg waitUntilDone:NO];
}

//在主线程显示提示
- (void)showTipInCenter:(NSString*)szTipMsg{
    [self performSelectorOnMainThread:@selector(showTipCenter:) withObject:szTipMsg waitUntilDone:NO];
}

- (void)showTipCenter:(NSString*)szTipMsg{
    [self initProgress];
    [self.progressView showTip:szTipMsg];
}

- (void)showTipBottom:(NSString*)szTipMsg{
    [self initProgress];
    [self.progressView showTipInBottom:szTipMsg];
}

//在主线程显示提示
- (void)showTipInBottom:(NSString*)szTipMsg{
    [self performSelectorOnMainThread:@selector(showTipBottom:) withObject:szTipMsg waitUntilDone:NO];
}
/////////////////////////////////////end//////////////////////

- (void)presentViewController:(UIViewController *)viewController{
    [self presentViewController:viewController withAnimationType:Push];
}
- (void)presentViewController:(UIViewController *)viewController withAnimationType:(AnimationType)aniType{
    if (self.navigationController) {
        BOOL bNav = self.navigationController.navigationBarHidden;
        self.hidesBottomBarWhenPushed = YES;//隐藏底部的
        [self.navigationController pushViewController:viewController animated:YES];
        self.hidesBottomBarWhenPushed = !bNav;//如果没有这句，返回的时候底部不会出现
    }else{
        [_viewAnimation showViewAnimation:aniType withSelfView:self.view];
        [self presentViewController:viewController animated:NO completion:nil];
    }
}


#pragma 给View添加背景图
-(void)addBgImageWithImageName:(NSString *) imageName
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
    
}

//获取字符串类型的页码-
- (NSString*)getStringPageNum{
    return [NSString stringWithFormat:@"%d",self.nPageNum];
}





- (void)showHUDSuccess:(NSString*)szMsg{
    //[MBProgressHUD wj_showSuccess:szMsg];
}
- (void)showHUDFail:(NSString*)szMsg{
    //[MBProgressHUD wj_showError:szMsg];
}
- (void)closeHUD{
    //[MBProgressHUD wj_hideHUD];
}

@end
