//
//  ScanViewController.m
//  BookForDream
//
//  Created by song on 14-10-9.
//  Copyright (c) 2014年 Gl. All rights reserved.
//

#import "ScanViewController.h"

#import <AVFoundation/AVFoundation.h>

#import <Base64nl/Base64.h>

#import "ScanView.h"

// 扫描结果
#import "StoreToRelateViewController.h"
#import "StoreToRelateViewModel.h"
// 商品详情
#import "GoodsDetailViewController.h"
#import "GoodsDetailViewModel.h"
// 首页service
#import "HomeService.h"
// 首页HomeCycleItemModel
#import "HomeCycleItemModel.h"

@interface ScanViewController ()<ScanViewDelegate,AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) ScanView *scanView;

@property (nonatomic, copy)   NSString *resultText;

@property (nonatomic, strong) HomeService *homeService;

@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;

@end

@implementation ScanViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.homeService = [HomeService new];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.scanView beginScanAnimation];
    [self.session startRunning];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.session stopRunning];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    [self initScanView];
    [self setupCamera];
}

- (void)initNavigationBar
{
    _navigationBarView.navagationBarStyle = Left_button_Show;
    _navigationBarView.backgroundColor = [UIColor blackColor];
    _navigationBarView.alpha = 0.5;
    _navigationBarView.titleLabel.text = @"扫一扫";
    _navigationBarView.titleLabel.textColor = [UIColor whiteColor];
    _navigationBarView.titleLabel.font = [UIFont boldSystemFontOfSize:MIDDLE_FONT_SIZE];
}

- (void)initScanView
{
    ScanView *scanView = [[ScanView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - NAVIGATIONBAR_HEIGHT)];
    scanView.scanViewDelegate = self;
    self.scanView = scanView;
    [self.view addSubview:scanView];
}

- (void)setupCamera
{
    // Device
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Input
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    // Output
    self.output = [[AVCaptureMetadataOutput alloc]init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input]){
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]){
        [self.session addOutput:self.output];
    }
    // 条码类型 AVMetadataObjectTypeQRCode
    if (self.output.availableMetadataObjectTypes.count) {
        self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    }
    
    // Preview
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer insertSublayer:self.preview atIndex:0];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if ([metadataObjects count] > 0){
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        if ([metadataObject.stringValue isEqualToString:@""]) {
            CLog(@"----未获取到扫描字符串");
            return;
        }
        NSString *stringValue = metadataObject.stringValue;
        // 扫描到字符串
        [self scanSucessMethod:stringValue];
    }
}

#pragma mark - scanView代理
// 扫描成功
- (void)scanSucessMethod:(NSString *)resultText
{
    //// 关联店铺
    //[self relateStoreWithResultText:resultText];
    // 跳转商品详情
    [self gotoGoodsDetailWithResultText:resultText];
}
// 开灯
- (void)scanLightOn
{
    if ([self.device isFlashAvailable]) {
        NSError* err = nil;
        BOOL lockAcquired = [self.device lockForConfiguration:&err];
        if (lockAcquired) {
            if (self.device.flashMode == AVCaptureFlashModeOn) {
                self.device.torchMode = AVCaptureTorchModeOff;
                self.device.flashMode = AVCaptureFlashModeOff;
            }else{
                self.device.torchMode = AVCaptureTorchModeOn;
                self.device.flashMode = AVCaptureFlashModeOn;
            }
        }
        [self.device unlockForConfiguration];
    }
}

#pragma mark -商品详情
- (void)gotoGoodsDetailWithResultText:(NSString *)resultText
{
    // 扫码停止
    [self.scanView endScanAnimation];
    [self.session stopRunning];

    NSString *scanCode = [resultText base64EncodedString];
    if (scanCode.length) {
        // 网络请求
        [DLLoading DLLoadingInWindow:nil close:nil];
        @weakify(self);
        [[self.homeService fetchGoodsMsgWithScanCode:scanCode] subscribeNext:^(NSDictionary *dict) {
            // 跳转
            [DLLoading DLHideInWindow];
            HomeCycleItemModel *model = [HomeCycleItemModel modelFromJSONDictionary:dict[@"data"]];
            model.link = [HomeLinkModel modelFromJSONDictionary:(NSDictionary *)model.link];
            model.link.options = [HomeLinkNativeModel modelFromJSONDictionary:(NSDictionary *)model.link.options];
            if ([model.link_type integerValue] == 0) {
                // 跳转网址
                [PublicEventManager gotoWebDisplayViewControllerWithUrl:model.link.options.wz
                                                   navigationController:nil];
            }else{
                // 跳转原生模块
                [PublicEventManager gotoNativeModuleWithLinkModel:model.link
                                             navigationController:nil];
            }
        } error:^(NSError *error) {
            @strongify(self);
            [DLLoading DLToolTipInWindow:AppErrorParsing(error)];
            // 扫码开始
            [self.scanView beginScanAnimation];
            [self.session startRunning];
        }];
    }else{
        [DLLoading DLToolTipInWindow:@"商品编码格式有误"];
        // 扫码开始
        [self.scanView beginScanAnimation];
        [self.session startRunning];
    }
}

#pragma mark -关联店铺
// 获取店铺信息
- (void)relateStoreWithResultText:(NSString *)resultText
{
    [DLLoading DLLoadingInWindow:@"获取店铺信息中,请稍候..." close:nil];
    [self.scanView endScanAnimation];
    [self.session stopRunning];
    self.resultText = resultText;
    [self performSelector:@selector(pushScoreRelateViewController) withObject:nil afterDelay:1.];

}
// 跳转店铺关联页面
- (void)pushScoreRelateViewController
{
    [DLLoading DLHideInWindow];
    // 解析shop_id
    NSString *shop_id_tip = @"shop_id:";
    
    if ([self.resultText rangeOfString:shop_id_tip].location==NSNotFound) {
        [DLLoading DLToolTipInWindow:@"请扫描店铺二维码"];
        [self.scanView beginScanAnimation];
        [self.session startRunning];
        return;
    }
    
    NSString *shop_id = [self.resultText stringByReplacingOccurrencesOfString:shop_id_tip
                                                                   withString:@""];
    if (!shop_id.length) {
        [DLLoading DLToolTipInWindow:@"店铺二维码解析失败"];
        [self.scanView beginScanAnimation];
        [self.session startRunning];
        return;
    }
    StoreToRelateViewController *vc = [StoreToRelateViewController new];
    vc.viewModel = [[StoreToRelateViewModel alloc] initWithStoreID:shop_id];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 导航代理
- (void)leftButtonClick
{
    [self.scanView endScanAnimation];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    CLog(@"%@ dealloc",[self class]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
