//
//  ScanView.m
//  BookForDream
//
//  Created by song on 14-10-9.
//  Copyright (c) 2014年 Gl. All rights reserved.
//

#import "ScanView.h"

#define ScanViewWidth 252.0f

@interface ScanView ()<UIGestureRecognizerDelegate>
{
    int num;
    BOOL upOrdown;
    CGRect scanRect;
    CGRect zxRect;
}

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ScanView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self start];
        num = 0;
    }
    return self;
}

// 开始布局
- (void)start
{
    CGPoint newPoint = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2-50);
    CGRect rect = CGRectMake((self.frame.size.width - ScanViewWidth) / 2, newPoint.y - ScanViewWidth/2, ScanViewWidth, ScanViewWidth);
    // 上半透明
    [self initTopView:rect.origin.y];
    // 左右半透明
    for (int i = 0; i < 2; i++) {
        UILabel *bgView = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rect) * i, rect.origin.y, (self.frame.size.width - ScanViewWidth) / 2, ScanViewWidth)];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.5;
        [self addSubview:bgView];
    }
    // 扫描框和下面的视图
    [self initScanView:rect.origin.y];
}
// 上半透明
- (void)initTopView:(CGFloat)orginY
{
    UILabel *topView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, orginY)];
    topView.backgroundColor = [UIColor blackColor];
    topView.alpha = 0.5;
    [self addSubview:topView];
}
// 扫描框
- (void)initScanView:(CGFloat)orginY
{
    self.orginY = orginY;
    CGRect rect = CGRectMake((self.frame.size.width - ScanViewWidth) / 2, orginY, ScanViewWidth, ScanViewWidth);
    zxRect = rect;
    
    UIImageView *scanImageView = [[UIImageView alloc]initWithFrame:CGRectMake(rect.origin.x - 3, rect.origin.y - 3, 258, 258)];
    scanImageView.image = [UIImage imageNamed:@"扫一扫边框"];
    scanImageView.tag = 1000;
    [self addSubview:scanImageView];
    
    UIImageView *scanStrip = [[UIImageView alloc]initWithFrame:CGRectMake(scanImageView.frame.origin.x + 28.5, rect.origin.y + rect.size.height / 2, 201, 8)];
    scanStrip.image = [UIImage imageNamed:@"scan_strip"];
    scanStrip.hidden = YES;
    scanRect = scanStrip.frame;
    self.scanStrip = scanStrip;
    [self addSubview:scanStrip];
    
    [self initBottomView:CGRectGetMaxY(rect)];
}
// 扫描框下面布局
- (void)initBottomView:(CGFloat)orginY
{
    UILabel *bgLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, orginY, self.frame.size.width, self.frame.size.height-orginY)];
    bgLabel.backgroundColor = [UIColor blackColor];
    bgLabel.alpha = 0.5;
    UIImageView *imageView = (UIImageView *)[self viewWithTag:1000];
    [self insertSubview:bgLabel belowSubview:imageView];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, orginY, self.frame.size.width, 45)];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont boldSystemFontOfSize:LARGE_FONT_SIZE];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    //tipLabel.text = @"扫描店铺二维码关联店铺";
    tipLabel.text = @"扫描商品编码进入商品详情";
    tipLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:tipLabel];
    
    UIButton *lightOnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lightOnBtn setImage:[UIImage imageNamed:@"点亮灯光"] forState:UIControlStateNormal];
    lightOnBtn.frame = CGRectMake(self.bounds.size.width/2-17.5, CGRectGetMaxY(tipLabel.frame)+30, 35, 35);
    [self addSubview:lightOnBtn];
    [lightOnBtn addTarget:self action:@selector(lightOn) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 开灯
- (void)lightOn
{
    if ([self.scanViewDelegate respondsToSelector:@selector(scanLightOn)]) {
        [self.scanViewDelegate scanLightOn];
    }
}

#pragma mark - 开始扫描动画
- (void)beginScanAnimation
{
    self.scanStrip.hidden = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(animation1) userInfo:nil repeats:YES];
}

- (void)endScanAnimation
{
    self.scanStrip.frame = scanRect;
    [self.timer invalidate];
    self.timer = nil;
    num = 0;
    upOrdown = NO;
}

- (void)animation1
{
    if (!upOrdown) {
        num ++;
        self.scanStrip.frame = CGRectMake(scanRect.origin.x, self.orginY + 2 * num, scanRect.size.width, scanRect.size.height);
        if (2 * num == 240) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        self.scanStrip.frame = CGRectMake(scanRect.origin.x, self.orginY + 2 * num, scanRect.size.width, scanRect.size.height);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}

- (void)dealloc
{
    CLog(@"%@ dealloc",[self class]);
}

@end
