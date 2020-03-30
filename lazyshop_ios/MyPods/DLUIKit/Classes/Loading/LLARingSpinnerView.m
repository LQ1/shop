//
//  LLARingSpinnerView.m
//  LLARingSpinnerView
//
//  Created by Lukas Lipka on 05/04/14.
//  Copyright (c) 2014 Lukas Lipka. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#ifdef DEBUG
#define NLog(format, ...) NSLog(format, ## __VA_ARGS__)

#else
#define NLog(format, ...)
#endif

#define START(degrees)  ((M_PI * (degrees-90))/ 180.)

#import "LLARingSpinnerView.h"
#import "DLLoadingSetting.h"

static NSString *kLLARingSpinnerAnimationKey = @"llaringspinnerview.rotation";

@interface LLARingSpinnerView ()

/**
 *  背景
 */
@property (nonatomic,strong) CAShapeLayer *trackLayer;

/**
 *  loadinglayer
 */
@property (nonatomic,strong) CAShapeLayer *progressLayer;

/**
 *  是否正在loading
 */
@property (nonatomic,assign) BOOL isAnimating;

@end

@implementation LLARingSpinnerView

@synthesize progressLayer = _progressLayer;
@synthesize isAnimating = _isAnimating;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.circleColor = [UIColor whiteColor];
        [self.layer addSublayer:self.progressLayer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updatePath];
}

- (void)setCircleColor:(UIColor *)circleColor {
    if (![DLLoadingSetting sharedInstance].loadingImg) {
        _circleColor = circleColor;
        if (![DLLoadingSetting sharedInstance].activityIndicatorLoading) {
            self.progressLayer.strokeColor = circleColor.CGColor;
        }
    }
}

- (void)startAnimating {
    if (self.isAnimating)
        return;
    
    [self addObserver];
    
    if (![DLLoadingSetting sharedInstance].loadingImg && [DLLoadingSetting sharedInstance].activityIndicatorLoading) {
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        
        CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
        [self.layer addSublayer:replicatorLayer];
        replicatorLayer.frame = self.bounds;
        replicatorLayer.position = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
        replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
        
        //几等分
        NSInteger numOfDot = 12.;
        CGFloat time = 1.0;
        replicatorLayer.instanceCount = numOfDot;
        CGFloat angle = (M_PI * 2)/numOfDot;
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
        replicatorLayer.instanceDelay = time/numOfDot;
        
        CALayer *lineLayer = [CALayer layer];
        lineLayer.bounds = CGRectMake(0, 0, self.frame.size.width/12., self.frame.size.width/6.);
        lineLayer.position = CGPointMake(self.frame.size.width/2., self.frame.size.width/6.);
        lineLayer.backgroundColor = self.circleColor.CGColor;
        lineLayer.opacity = 1;
        lineLayer.cornerRadius = self.frame.size.width/12/2.;
        lineLayer.shouldRasterize = YES;
        lineLayer.rasterizationScale = [UIScreen mainScreen].scale;
        
        [replicatorLayer addSublayer:lineLayer];
        
        CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation1.fromValue = @0;
        animation1.toValue = @1;
        animation1.duration = time;
        animation1.repeatCount = CGFLOAT_MAX;
        animation1.removedOnCompletion = NO;
        
        self.progressLayer = lineLayer;
        [self.progressLayer addAnimation:animation1 forKey:kLLARingSpinnerAnimationKey];
    } else {
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"transform.rotation";
        animation.duration = 1.0f;
        animation.fromValue = @(0.0f);
        animation.toValue = @(2 * M_PI);
        animation.repeatCount = INFINITY;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        [self.progressLayer addAnimation:animation forKey:kLLARingSpinnerAnimationKey];
    }
    
    self.isAnimating = true;
}

- (void)stopAnimating {
    if (!self.isAnimating)
        return;
    
    [self removeObserver];
    
    [self.progressLayer removeAnimationForKey:kLLARingSpinnerAnimationKey];
    self.isAnimating = false;
}

#pragma mark - Private

- (void)updatePath {
    if (![DLLoadingSetting sharedInstance].loadingImg && ![DLLoadingSetting sharedInstance].activityIndicatorLoading) {
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGFloat radius = MIN(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) - self.lineWidth/2.;
        CGFloat startAngle = START(self.loadingStart);
        CGFloat endAngle = START(360);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:radius
                                                        startAngle:startAngle
                                                          endAngle:endAngle
                                                         clockwise:YES];
        self.progressLayer.path = path.CGPath;
    }
}

#pragma mark - Properties

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        if ([DLLoadingSetting sharedInstance].loadingImg) {
            self.progressLayer = [CAShapeLayer layer];
            _progressLayer.frame = self.bounds;
            _progressLayer.contents = (id)([[DLLoadingSetting sharedInstance].loadingImg CGImage]);
            
            CALayer *caLayer = (CALayer *) self.layer;
            caLayer.mask = _progressLayer;
        } else {
            self.progressLayer = [CAShapeLayer layer];
            _progressLayer.frame = self.bounds;
            _progressLayer.strokeColor = [self.circleColor CGColor];
            _progressLayer.fillColor = nil;
            _progressLayer.lineWidth = self.progressLayer.lineWidth;
        }
    }
    return _progressLayer;
}

- (CAShapeLayer *)trackLayer {
    if (!_trackLayer) {
        if (![DLLoadingSetting sharedInstance].loadingImg) {
            _trackLayer = [CAShapeLayer layer];
            [self.layer insertSublayer:_trackLayer below:_progressLayer];
            _trackLayer.fillColor = nil;
            _trackLayer.frame = self.bounds;
            _trackLayer.lineWidth = self.progressLayer.lineWidth;
        }
    }
    return _trackLayer;
}

- (BOOL)isAnimating {
    return _isAnimating;
}

- (CGFloat)loadingStart {
    return _loadingStart?_loadingStart:45;
}

- (CGFloat)lineWidth {
    return self.progressLayer.lineWidth?self.progressLayer.lineWidth:1.5;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    if (![DLLoadingSetting sharedInstance].loadingImg) {
        self.progressLayer.lineWidth = lineWidth;
        [self updatePath];
    }
}

- (void)addBezierPathBg:(UIColor *)bgColor {
    if (bgColor) {
        if (![DLLoadingSetting sharedInstance].loadingImg && ![DLLoadingSetting sharedInstance].activityIndicatorLoading) {
            UIBezierPath *_trackPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
                                                                      radius:MIN(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) - self.lineWidth/2.
                                                                  startAngle:0
                                                                    endAngle:M_PI * 2
                                                                   clockwise:YES];
            self.trackLayer.strokeColor = bgColor.CGColor;
            self.trackLayer.path = _trackPath.CGPath;
        }
    }
}

#pragma mark - 当前页面不在活动状态下，动画会停止
-(void)dealloc {
#ifdef DEBUG
    NSLog(@"dealloc -- %@",[self class]);
#endif
    [self removeObserver];
}

-(void)addObserver {
    //程序进入前台
    [self removeObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(becomeActive)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

-(void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)becomeActive {
//    NLog(@"\n\nloading\n加载状态：：：：%d\n加载动画：：：：%@\n\n",self.isAnimating,[self.progressLayer animationForKey:kLLARingSpinnerAnimationKey]);
    if (self.isAnimating && ![self.progressLayer animationForKey:kLLARingSpinnerAnimationKey]) {
        [self stopAnimating];
        [self startAnimating];
    }
}

//当前页面不显示在UIWindow的时候，会将动画CABasicAnimation给删除
//此时需要做处理，让动画动起来
- (void)willMoveToWindow:(UIWindow *)newWindow {
    if (!self.hidden && self.alpha>0) {
//    NLog(@"\n\nloading\n所属Window：：：：%@\n加载状态：：：：%d\n加载动画：：：：%@\n\n",newWindow,self.isAnimating,[self.progressLayer animationForKey:kLLARingSpinnerAnimationKey]);
        if (newWindow && self.isAnimating && ![self.progressLayer animationForKey:kLLARingSpinnerAnimationKey]) {
            [self stopAnimating];
            [self startAnimating];
        }
    }
}

@end
