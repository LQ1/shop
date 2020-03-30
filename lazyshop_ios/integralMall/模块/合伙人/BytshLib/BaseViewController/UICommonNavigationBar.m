//
//  UICommonNavigationBar.m
//  EcologicalMgr
//
//  Created by yons on 14-10-31.
//
//

#import "UICommonNavigationBar.h"

@implementation UICommonNavigationBar
@synthesize navigationBar;
@synthesize selViewControllerMethod;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        imgChecked = [UIImage imageNamed:@"checkbox_white_on.png"];
        imgNoChecked = [UIImage imageNamed:@"checkbox_white_off.png"];
    }
    return self;
}

- (id)initControlWithBackBtn:(UIViewController*)viewController withTitle:(NSString*)szNavItemTitle
{
    self = [super init];
    [self initControl:viewController withTitle:szNavItemTitle];
    
    return self;
}

- (id)initControlWithBackBtn:(UIViewController*)viewController withTitle:(NSString*)szNavItemTitle withBackReturnBlock:(BackReturnBlock)backReturnBlock
{
    self = [super init];
    [self initControl:viewController withTitle:szNavItemTitle withBackReturnBlock:backReturnBlock];
    
    return self;
}

//最后一个参数为默认ViewController类的方法
- (id)initControlWithLRBtn:(UIViewController *)viewController withTitle:(NSString *)szNavItemTitle withRightBtnTitle:(NSString *)szRBtnTitle withSEL:(SEL)selMethod
{
    self = [super init];
    [self initControl:viewController withTitle:szNavItemTitle];
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithTitle:szRBtnTitle style:UIBarButtonItemStylePlain target:viewController  action:selMethod];
    btnRight.tintColor = [UIColor whiteColor];
    [navItem setRightBarButtonItem:btnRight];

    return self;
}

- (id)initControlWithLRCheckBox:(UIViewController*)viewController withTitle:(NSString*)szNavItemTitle withRightBtnTitle:(NSString*)szRBtnTitle withSEL:(SEL)selMethod
{
    selViewControllerMethod = selMethod;
    self = [super init];
    [self initControl:viewController withTitle:szNavItemTitle];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    //UIImageView
    CGRect rcFrame = {0};
    rcFrame.origin.x = 10;
    rcFrame.size.width = rcFrame.size.height = 20;
    rcFrame.origin.y = (view.frame.size.height - rcFrame.size.height)*.5;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rcFrame];
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureImgChecked:)];
    [imgView addGestureRecognizer:gesture];
    imgView.image = imgNoChecked;
    [view addSubview:imgView];
    //Label
    rcFrame.origin.x += rcFrame.size.width+2;
    rcFrame.size.width = 35;
    UILabel *lblText = [[UILabel alloc] initWithFrame:rcFrame];
    lblText.text = szRBtnTitle;
    lblText.textColor = [UIColor whiteColor];
    [view addSubview:lblText];
    
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithCustomView:view];
    [navItem setRightBarButtonItem:btnRight];
    return self;
}

- (void)initControl:(UIViewController *)viewController withTitle:(NSString *)szNavItemTitle
{
    viewControllerParent = viewController;
    navigationBar = [[UINavigationBar alloc] init];
    navItem = [[UINavigationItem alloc] initWithTitle:szNavItemTitle];
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back_key.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackClicked:)];
    [navItem setLeftBarButtonItem:btnLeft];
    [navigationBar pushNavigationItem:navItem animated:NO];
    //设置位置
    CGRect rcFrame = {0};
    rcFrame.origin.y = 0;//[Utility getStateBarHeight];
    rcFrame.size.height = 64;
    rcFrame.size.width = [Utility getScreenWidth];
    [self setFrame:rcFrame];
    
    rcFrame.origin.y = 0;
    [navigationBar setFrame:rcFrame];
    
    [self addSubview:navigationBar];
    
    btnLeft.tintColor = [UIColor whiteColor];
    UIColor *color = [UIColor colorWithRed:0xED/255.0f green:0x6D/255.0f blue:0/255.0f alpha:1.0];
    navigationBar.barTintColor = color;
    navigationBar.tintColor = color;
    [navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
}

- (void)initControl:(UIViewController *)viewController withTitle:(NSString *)szNavItemTitle withBackReturnBlock:(BackReturnBlock)backReturnBlock{
    _blockBackReturn = backReturnBlock;
    [self initControl:viewController withTitle:szNavItemTitle];
    
}

- (void)gestureImgChecked:(UITapGestureRecognizer *)gesture
{
    UIImageView *imgView = (UIImageView*)gesture.view;
    if (imgView.image == imgChecked) {
        imgView.image = imgNoChecked;
    }else{
        imgView.image = imgChecked;
    }
    if (selViewControllerMethod) {
        [viewControllerParent performSelector:selViewControllerMethod withObject:nil];
    }
}


//返回
- (void)btnBackClicked:(id)sender
{
    if (_blockBackReturn) {
        if (!_blockBackReturn()) {
            return;
        }
    }
    if (viewControllerParent) {
        [viewControllerParent dismissViewControllerAnimated:NO completion:nil];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
