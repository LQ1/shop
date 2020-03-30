//
//  DLShareController.m
//  DLShareSDK
//
//  Created by LY on 16/7/6.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "DLShareController.h"
#import "DLShareBottomView.h"
#import "DLShareConstant.h"
#import <DLUIKit/DLLoading.h>
#import <DLUIKit/DLRotateView.h>
#import <DLUtls/CommUtls.h>

#define WXThumbImageSize 25.0

@interface DLShareController()<UIAlertViewDelegate>

// 点击消失按钮
@property (nonatomic,strong) UIView *backButton;
// 分享视图
@property (nonatomic,strong) DLShareView*shareContentView;

// 分享标题
@property (nonatomic,copy)NSString *defaultMainTitle;
@property (nonatomic,copy)NSString *mainTitle;
// 分享详细
@property (nonatomic,copy)NSString *defaultDetailTitle;
@property (nonatomic,copy)NSString *detailTitle;
// 分享链接
@property (nonatomic,copy)NSString* defaultHtmlStr;
@property (nonatomic,copy)NSString* htmlStr;
// 分享图片
@property (nonatomic,strong)UIImage* defaultPreviewImage;
@property (nonatomic,strong)UIImage* previewImage;
// 分享是否有链接
@property (nonatomic,assign)BOOL isContainURL;

// 当前分享类型(QQ/微信...)
@property (nonatomic,assign)ShareType currentShareType;
// 分享风格(图片/新闻...)
@property (nonatomic,assign)DLShareStyle shareStyle;

// 是否通过审核
@property (nonatomic,assign)BOOL isAppAgree;

@end


@implementation DLShareController

#pragma mark -单例
+ (DLShareController *)shareInstance{
    static DLShareController *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[DLShareController alloc]init];
    });
    return shareInstance;
}

#pragma mark -注册微信key
-(void)setWXAppKey:(NSString *)WXAppKey
{
//    if (ISIOS7_1_1) {
//        // ios7.1.1不要分享
//        return;
//    }
    if (![_WXAppKey isEqualToString:WXAppKey]) {
        _WXAppKey=WXAppKey;
        if (_WXAppKey) {
            //注册
#if TARGET_IPHONE_SIMULATOR
            
#else
            [WXApi registerApp:_WXAppKey];
#endif
        }
    }
}

#pragma mark -OpenURL
- (BOOL)applicationOpenURL:(NSURL *)url{
//    if (ISIOS7_1_1) {
//        // ios7.1.1不要分享
//        return NO;
//    }
#if TARGET_IPHONE_SIMULATOR
    return NO;
#else
    if (self.currentShareType == ShareTypeWeixin) {
        return [WXApi handleOpenURL:url delegate:nil];
    }else{
        return [TencentOAuth HandleOpenURL:url];
    }
#endif
}
- (BOOL)applicationHandleOpenURL:(NSURL *)url{
//    if (ISIOS7_1_1) {
//        // ios7.1.1不要分享
//        return NO;
//    }
#if TARGET_IPHONE_SIMULATOR
    return NO;
#else
    if (self.currentShareType == ShareTypeWeixin) {
        return [WXApi handleOpenURL:url delegate:nil];
    }else{
        return [QQApiInterface handleOpenURL:url delegate:nil];
    }
#endif
}

#pragma mark -注册分享
- (void)registerShareSDKWithQQAppKey:(NSString*)QQKey
                        previewImage:(UIImage*)previewImage
                             htmlStr:(NSString *)htmlStr
                            titleStr:(NSString *)titleStr
                           detailStr:(NSString *)detailStr
{
//    if (ISIOS7_1_1) {
//        // ios7.1.1不要分享
//        return;
//    }
#if TARGET_IPHONE_SIMULATOR

#else
    // 注册QQ分享
    if (QQKey.length) {
        TencentOAuth *tencentOAuth = [[TencentOAuth alloc]init];
        [tencentOAuth initWithAppId:QQKey andDelegate:nil];
    }
#endif
    // 设置分享内容和默认分享内容
    self.previewImage=previewImage;
    self.htmlStr=htmlStr;
    self.mainTitle=titleStr;
    self.detailTitle=detailStr;
    
    self.defaultPreviewImage=previewImage;
    self.defaultHtmlStr=htmlStr;
    self.defaultMainTitle=titleStr;
    self.defaultDetailTitle=detailStr;
}

#pragma mark -调用分享

- (void)displayTitle:(NSString *)mainTitle
         DetailTitle:(NSString *)detailTitle
        previewImage:(id)imageObject
             HtmlStr:(NSString*)htmlStr
          isAppAgree:(BOOL)isAppAgree
          shareStyle:(DLShareStyle)shareStyle
{
//    if (ISIOS7_1_1) {
//        // ios7.1.1不要分享
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"对不起,该系统版本下不提供分享功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
    // 审核状态
    self.isAppAgree = isAppAgree;
    // 添加分享视图
    if (!self.shareContentView) {
        [self initBackGroundViewNew];
    }
    
    // 分享风格
    self.shareStyle = shareStyle;
    
    // 设置分享内容
    
    if (mainTitle) {
        self.mainTitle = mainTitle;
    }else{
        self.mainTitle = self.defaultMainTitle;
    }
    
    if (detailTitle) {
        self.detailTitle = detailTitle;
    }else{
        self.detailTitle = self.defaultDetailTitle;
    }
    
    if (htmlStr.length) {
        self.htmlStr=htmlStr;
    }else{
        self.htmlStr=self.defaultHtmlStr;
    }
    
    self.isContainURL = self.htmlStr.length ? YES:NO;
    
    // 分享图片要判断是本地还是网络
    if (imageObject) {
        if ([imageObject isKindOfClass:[UIImage class]]) {
            self.previewImage=imageObject;
        }else if([imageObject isKindOfClass:[NSURL class]]){
            // 异步请求网络图片
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:imageObject];
            request.timeoutInterval = 15.0;
            __weak DLShareController *selfController = self;
            [DLLoading DLLoadingInWindow:@"获取分享图片中,请稍候" close:nil];
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                [DLLoading DLHideInWindow];
                selfController.previewImage = [UIImage imageWithData:data];
                // 视图出现
                [selfController presentShareView];
            }];
        }
    }else{
        self.previewImage=self.defaultPreviewImage;
    }
    
    if (![imageObject isKindOfClass:[NSURL class]]) {
        // 视图出现
        [self presentShareView];
    }
}
// 设置分享自定义视图
- (void)setCustomShareView:(DLShareView *)customShareView
{
    _customShareView = customShareView;
    self.shareContentView = nil;
}
// 分享底视图
- (void)initBackGroundViewNew
{
    UIWindow *curWindow = [[[UIApplication sharedApplication] delegate] window];
    // 背景
    DLRotateView *backView = [[DLRotateView alloc]init];
    [curWindow addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [backView registerForNotifications];
    [backView setTransformForCurrentOrientation];
    backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    // 分享视图
    DLShareBottomView *shareContentView;
    if (self.customShareView) {
        shareContentView = self.customShareView;
    }else{
        shareContentView = [DLShareBottomView new];
    }
    [backView addSubview:shareContentView];
    [shareContentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.backButton = backView;
    self.shareContentView = shareContentView;
    shareContentView.hidden = YES;
    
    // 添加点击消失事件
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissShareView)];
    [backView addGestureRecognizer:gesture];
    
    // 添加分享按钮事件
    [self.shareContentView.qqButton addTarget:self action:@selector(qqTap) forControlEvents:UIControlEventTouchUpInside];
    [self.shareContentView.qzoneButton addTarget:self action:@selector(qzoneTap) forControlEvents:UIControlEventTouchUpInside];
    [self.shareContentView.wxFriendButton addTarget:self action:@selector(friendTap) forControlEvents:UIControlEventTouchUpInside];
    [self.shareContentView.wxGroupButton addTarget:self action:@selector(groupTap) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -分享点击响应
// 微信分享
- (void)friendTap
{
    
    [self weixinActionWithType:0];
    
}
// 朋友圈分享
- (void)groupTap
{
    
    [self weixinActionWithType:1];
    
}
- (void)weixinActionWithType:(NSInteger)typeValue{
#if TARGET_IPHONE_SIMULATOR
    
#else
    self.currentShareType = ShareTypeWeixin;
    if ([WXApi isWXAppInstalled]) {
        if (self.shareStyle == DLShareStyleNews) {
            //新闻样式
            WXWebpageObject *ext = [WXWebpageObject object];
            ext.webpageUrl = self.htmlStr;
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = self.mainTitle;
            message.description = self.detailTitle;
            message.mediaObject = ext;
            [message setThumbImage:[UIImage imageWithData:[CommUtls compressImage:self.previewImage
                                                                       MaxSize_KB:WXThumbImageSize]]];
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.scene = (int)typeValue;
            req.message = message;
            [WXApi sendReq:req];
        }else{
            //图片样式
            WXImageObject *ext = [WXImageObject object];
            ext.imageData = UIImagePNGRepresentation(self.previewImage);
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = nil;
            message.description = nil;
            message.mediaObject = ext;
            message.messageExt = @"ZXWLKJ";
            message.messageAction = @"<action>dotalist</action>";
            message.mediaTagName = @"CDEL_SHARE_IMAGE";
            [message setThumbImage:[UIImage imageWithData:[CommUtls compressImage:self.previewImage
                                                                       MaxSize_KB:WXThumbImageSize]]];
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.scene = (int)typeValue;
            req.message = message;
            [WXApi sendReq:req];
        }
        
    }else{
        if (self.isAppAgree) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"请安装微信客户端"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag = WEI_XIN_ALERT;
            [alert show];
        }else{
            [DLLoading DLToolTipInWindow:@"未安装微信客户端"];
        }
    }
    [self dismissShareView];
#endif
}
// QQ分享
- (void)qqTap{
#if TARGET_IPHONE_SIMULATOR
    
#else
    if ([QQApiInterface isQQInstalled]) {
        if (self.shareStyle == DLShareStyleNews) {
            //新闻样式
            QQApiObject *shareObject = nil;
            if (!self.isContainURL)
            {
                NSString *message = [NSString stringWithFormat:@"%@\n%@",self.mainTitle,self.detailTitle];
                shareObject = [[QQApiTextObject alloc]initWithText:message];
                SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:shareObject];
                [QQApiInterface sendReq:req];
            }
            else{
                QQApiNewsObject* img = [QQApiNewsObject objectWithURL:[NSURL URLWithString:self.htmlStr] title:self.mainTitle description:self.detailTitle previewImageData:UIImagePNGRepresentation(self.previewImage)];
                SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
                [QQApiInterface sendReq:req];
            }
        }else{
            //图片样式
            NSData* data = UIImagePNGRepresentation(self.previewImage);
            QQApiImageObject* img = [QQApiImageObject objectWithData:data previewImageData:data title:self.mainTitle description:self.detailTitle];
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
            [QQApiInterface sendReq:req];
        }
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"请安装QQ客户端"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert.tag = QQ_ALERT;
        [alert show];
    }
    [self dismissShareView];
#endif
}
// QQ空间分享
- (void)qzoneTap
{
#if TARGET_IPHONE_SIMULATOR
    
#else
    if ([QQApiInterface isQQInstalled]) {
        // QQ空间分享不支持纯文本和纯图片模式
        QQApiNewsObject* img = [QQApiNewsObject objectWithURL:[NSURL URLWithString:self.htmlStr] title:self.mainTitle description:self.detailTitle previewImageData:UIImagePNGRepresentation(self.previewImage)];
        [img setCflag: kQQAPICtrlFlagQZoneShareOnStart];
        SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
        [QQApiInterface SendReqToQZone:req];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"请安装QQ客户端"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert.tag = QQ_ALERT;
        [alert show];
    }
    [self dismissShareView];
#endif
}
// 去appStore下载
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
#if TARGET_IPHONE_SIMULATOR
    
#else
    if (alertView.tag == WEI_XIN_ALERT) {
        if (buttonIndex == 0) {
            // 去下载微信
            NSString *downLoadUrl = [WXApi getWXAppInstallUrl];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:downLoadUrl]];
        }
    }
    else if(alertView.tag == QQ_ALERT){
        if (buttonIndex == 0) {
            // 去下载QQ
            NSString *downLoadUrl = [QQApiInterface getQQInstallUrl];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:downLoadUrl]];
        }
    }
#endif
}

#pragma mark -分享视图的出现和消失
// 视图出现
- (void)presentShareView
{
    __weak DLShareController *selfControl = self;
    if (self.shareContentView.appearDirection==animateDirectionNone&&!self.shareContentView.apperAnimation) {
        [UIView animateWithDuration:0.3 animations:^{
            selfControl.shareContentView.hidden = NO;
            selfControl.backButton.alpha = 1.;
        }];
    }else{
        self.shareContentView.hidden = NO;
        [self.shareContentView.layer addAnimation:self.shareContentView.apperAnimation?:[self creatAnmitionHorizontalAppear:YES] forKey:@"appear"];
        [UIView animateWithDuration:0.3 animations:^{
            selfControl.backButton.alpha = 1.;
        }];
    }
}
// 视图消失
- (void)dismissShareView
{
    __weak DLShareController *selfControl = self;
    if (self.shareContentView.appearDirection==animateDirectionNone&&!self.shareContentView.disapperAnimation){
        [UIView animateWithDuration:0.3 animations:^{
            selfControl.shareContentView.hidden = YES;
            selfControl.backButton.alpha = 0.;
        }];
    }else{
        self.shareContentView.hidden = YES;
        [self.shareContentView.layer addAnimation:self.shareContentView.disapperAnimation?:[self creatAnmitionHorizontalAppear:NO] forKey:@"dismiss"];
        [UIView animateWithDuration:0.3 animations:^{
            selfControl.backButton.alpha = 0.;
        }];
    }
}
// 动画
- (CATransition *)creatAnmitionHorizontalAppear:(BOOL)appear
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    if (appear) {
        // 视图出现
        animation.type = kCATransitionMoveIn;
    }else{
        // 视图消失
        animation.type = kCATransitionPush;
    }
    // 动画方向
    switch (self.shareContentView.appearDirection) {
        case animateDirectionFromBottom:
        {
            // 底部
            animation.subtype = appear ? kCATransitionFromTop:kCATransitionFromBottom;
        }
            break;
        case animateDirectionFromTop:
        {
            // 顶部
            animation.subtype = appear ? kCATransitionFromBottom:kCATransitionFromTop;
        }
            break;
        case animateDirectionFromLeft:
        {
            // 左边
            animation.subtype = appear ? kCATransitionFromLeft:kCATransitionFromRight;
        }
            break;
        case animateDirectionFromRight:
        {
            // 右边
            animation.subtype = appear ? kCATransitionFromRight:kCATransitionFromLeft;
        }
            break;
        
        default:
            break;
    }
    
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    return animation;
}

@end
