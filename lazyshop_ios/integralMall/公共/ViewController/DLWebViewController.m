//
//  DLWebViewController.m
//  MobileClassPhone
//
//  Created by LY on 16/12/16.
//  Copyright © 2016年 CDEL. All rights reserved.
//

#import "DLWebViewController.h"

@interface DLWebViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView                     *webView;
@property (nonatomic,copy  ) webViewShouldLoadRequestBlock loadRequestBlock;
@property (nonatomic,strong) UIButton                      *closeButton;

@end

@implementation DLWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 初始化网页地址
    [self initUrlString];
    // 导航
    [self initNav];
    // webView
    [self addWebview];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.hasAppered) {
        [self requestUrl];
        self.hasAppered = YES;
    }
}

- (void)dealloc
{
    self.webView.delegate = nil;
    [self stopWebLoading];
}

#pragma mark -界面
// 初始化网址 子类可重写
- (void)initUrlString
{
    
}
// 初始化导航 子类可重写
- (void)initNav
{
    // 关闭按钮
    UIButton *closeButton = [UIButton new];
    self.closeButton      = closeButton;
    [closeButton setImage:[UIImage imageNamed:@"title_btn_closed_normal"] forState:UIControlStateNormal];
    [closeButton setImage:[UIImage imageNamed:@"title_btn_closed_pressed"] forState:UIControlStateHighlighted];
    [self.navigationBarView addSubview:closeButton];
    @weakify(self);
    closeButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
        return [RACSignal empty];
    }];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.navigationBarView.leftButton);
        make.left.mas_equalTo(self.navigationBarView.leftButton.right);
        make.width.mas_equalTo(40);
    }];
    [self.navigationBarView.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navigationBarView.rightButton.left).offset(-50);
        make.left.equalTo(self.navigationBarView.leftButton.right).offset(50);
    }];
    self.closeButton.hidden = YES;
    // 标题
    if (self.staticNavTitle.length) {
        self.navigationBarView.titleLabel.text = self.staticNavTitle;
    }
}
// 左键回退
- (void)leftButtonClick
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [super leftButtonClick];
    }
}
// 添加webView
-(void)addWebview
{
    // 添加网页
    UIWebView *mainWebView = [UIWebView new];
    self.webView = mainWebView;
    mainWebView.delegate = self;
    mainWebView.opaque = NO;
    mainWebView.backgroundColor = [UIColor whiteColor];
    mainWebView.scalesPageToFit = YES;
    [self.view addSubview:mainWebView];
    [self nearByNavigationBarView:mainWebView isShowBottom:NO];
}
// web开始加载
- (void)requestUrl
{
    // 加载
    self.webView.hidden = YES;
    [self.view DLLoadingInSelf];
    // 网络判断
    if ([NetStatusHelper sharedInstance].netStatus == NoneNet) {
        @weakify(self);
        [self.view DLLoadingCycleInSelf:^{
            @strongify(self);
            [self requestUrl];
        } code:DLDataFailed title:NO_NET_STATIC_SHOW buttonTitle:LOAD_FAILED_RETRY];
        return;
    }
    //开始加载
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:10];
    [self.webView loadRequest:request];
}
// web停止加载
- (void)stopWebLoading
{
    if (self.webView.isLoading) {
        [self.webView stopLoading];
    }
}
// 设置网页开始加载的回调
- (void)setStartLoadBlock:(webViewShouldLoadRequestBlock)block
{
    self.loadRequestBlock = block;
}
#pragma mark -webviewDelegate
// 开始加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (self.loadRequestBlock) {
        return self.loadRequestBlock(request,navigationType);
    }
    return YES;
}
// 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (!self.staticNavTitle.length) {
        self.navigationBarView.titleLabel.text = @"加载中...";
    }
    self.webView.hidden = YES;
    [self.view DLLoadingInSelf];
}
// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 是否展示关闭按钮
    [self resetCloseButtonShow];
    // 界面变化
    if (!self.staticNavTitle.length) {
        self.navigationBarView.titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    self.webView.hidden = NO;
    [self.view DLLoadingDoneInSelf:CDELLoadingRemove title:nil];
    // 去除长按后出现的文本选取框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
}
// 加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (!self.staticNavTitle.length) {
        self.navigationBarView.titleLabel.text = @"加载失败";
    }
    // 是否展示关闭按钮
    [self resetCloseButtonShow];
    // 错误可被忽略
    if ([self loadErrorCanBeIgnored:error]) {
        self.webView.hidden = NO;
        [self.view DLLoadingHideInSelf];
        return;
    }
    
    self.webView.hidden = YES;
    @weakify(self);
    [self.view DLLoadingCycleInSelf:^{
        @strongify(self);
        [self requestUrl];
    } code:DLDataFailed title:@"网页加载失败" buttonTitle:LOAD_FAILED_RETRY];
}
// 设置是否展示关闭按钮
- (void)resetCloseButtonShow
{
    if ([self.webView canGoBack]) {
        self.closeButton.hidden = NO;
    }
}
#pragma mark -可被忽略的错误
- (BOOL)loadErrorCanBeIgnored:(NSError *)error
{
    // 当网页内部链接跳转时
    if ([error.domain isEqualToString:@"NSURLErrorDomain"] && error.code == NSURLErrorCancelled) {
        return YES;
    }
    
    // 当网页包含 appstore 链接时
    if ([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code == 102) {
        return YES;
    }
    
    // 当链接就视频路径时（不影响视频正常播放）
    if ([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code == 204) {
        return YES;
    }
    
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
