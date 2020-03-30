//
//  DLAlertShowView.m
//  Pods
//
//  Created by SL on 16/6/16.
//
//

#import "DLAlertShowView.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

#define Animations_Time         .4

typedef void (^OutsideDisappear)();

@interface DLAlertShowView ()

/**
 黑色背景view
 */
@property (nonatomic,strong) UIView *bgView;

/**
 背景button，用于点击view外部自动消失
 */
@property (nonatomic,strong) UIButton *bgButton;

/**
 需要弹出的view
 */
@property (nonatomic,strong) UIView *alertView;

/**
 弹出模式
 */
@property (nonatomic,assign) View_Popup_Mode popupMode;

/**
 正在消失中
 以免在执行disappear方法的时候，有新的页面调用当前show方法，引起的页面弹不出问题
 */
@property (nonatomic,assign) BOOL disappearing;

/**
 点击外围消失的block
 */
@property (nonatomic,copy) OutsideDisappear outBlock;

@end

@implementation DLAlertShowView

+ (instancetype)sharedInstance {
    static DLAlertShowView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DLAlertShowView alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        UIView *bgView = [UIView new];
        [self addSubview:bgView];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0;
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        self.bgView = bgView;
        
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:bgButton];
        [bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        @weakify(self);
        bgButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [DLAlertShowView disappear:self.outBlock];
            return [RACSignal empty];
        }];
        self.bgButton = bgButton;
    }
    return self;
}

+ (void)showInView:(UIView *)alertView {
    [self showInView:alertView popupMode:View_Popup_Mode_Center outsideDisappear:NO];
}

+ (void)disappear {
    [[self sharedInstance] disappear];
}

+ (void)disappear:(void(^)())done {
    if (done) {
        DLAlertShowView *sView = [self sharedInstance];
        [[[RACObserve(sView, alertView) skip:1] take:1] subscribeNext:^(id x) {
            if (!x) {
                done();
            }
        }];
    }
    [[self sharedInstance] disappear];
}

- (void)disappear {
    self.disappearing = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.userInteractionEnabled = NO;
    if (self.popupMode == View_Popup_Mode_Center) {
        [UIView animateWithDuration:Animations_Time animations:^{
            self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, .5, .5);
            self.alertView.alpha = 0;
            self.bgView.alpha = 0;
        } completion:^(BOOL s){
            [self completion];
        }];
    } else if (self.popupMode == View_Popup_Mode_Down) {
        [UIView animateWithDuration:Animations_Time animations:^{
            self.alertView.alpha = 0;
            self.bgView.alpha = 0;
            [self.alertView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(self.alertView.frame.size.height);
            }];
            [self layoutIfNeeded];
        } completion:^(BOOL s){
            [self completion];
        }];
    }
}

- (void)completion {
    [self.alertView removeFromSuperview];
    self.alertView = nil;
    [self removeFromSuperview];
    [self unregisterFromNotifications];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
    self.disappearing = NO;
}

+ (void)showInView:(UIView *)alertView
         popupMode:(View_Popup_Mode)popupMode
  outsideDisappear:(BOOL)outsideDisappear {
    DLAlertShowView *sView = [self sharedInstance];
    
    if (sView.disappearing) {
        [[[RACObserve(sView, disappearing) skip:1] take:1] subscribeNext:^(id x) {
            [DLAlertShowView showInView:alertView popupMode:popupMode outsideDisappear:outsideDisappear];
        }];
        return;
    }
    
    if (sView.alertView) {
        [sView.alertView removeFromSuperview];
        sView.alertView = nil;
    }
    if (sView.superview) {
        [sView removeFromSuperview];
    }
    
    sView.outBlock = nil;
    sView.popupMode = popupMode;
    sView.alertView = alertView;
    sView.bgButton.hidden = !outsideDisappear;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.userInteractionEnabled = NO;
    [window addSubview:sView];
    [sView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [sView addSubview:alertView];
    
    alertView.alpha = 0;
    sView.bgView.alpha = 0;
    
#ifdef DEBUG
    NSLog(@"alertView.frame.size.width==%f",alertView.frame.size.width);
    NSLog(@"alertView.frame.size.height==%f",alertView.frame.size.height);
#endif
    
    [sView registerForNotifications];
    [sView setTransformForCurrentOrientation];
    
    if (popupMode == View_Popup_Mode_Center) {
        [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(sView);
            make.width.mas_equalTo(alertView.frame.size.width);
            make.height.mas_equalTo(alertView.frame.size.height);
        }];
        alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        
        [UIView animateWithDuration:Animations_Time animations:^{
            sView.bgView.alpha = .2;
            alertView.alpha = 1;
            alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        } completion:^(BOOL finished) {
            window.userInteractionEnabled = YES;
        }];
    } else if (popupMode == View_Popup_Mode_Down) {
        [alertView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(sView.mas_centerX);
            make.width.mas_equalTo(alertView.frame.size.width);
            make.height.mas_equalTo(alertView.frame.size.height);
            make.bottom.mas_equalTo(sView.mas_bottom).mas_equalTo(alertView.frame.size.height);
        }];
        [sView layoutIfNeeded];
        
        [UIView animateWithDuration:Animations_Time animations:^{
            sView.bgView.alpha = .2;
            alertView.alpha = 1;
            [alertView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(0);
            }];
            [sView layoutIfNeeded];
        } completion:^(BOOL finished) {
            window.userInteractionEnabled = YES;
        }];
    }
}

+ (void)showInView:(UIView *)alertView
         popupMode:(View_Popup_Mode)popupMode
           outside:(void(^)())outside {
    DLAlertShowView *sView = [self sharedInstance];
    if (sView.disappearing) {
        [[[RACObserve(sView, disappearing) skip:1] take:1] subscribeNext:^(id x) {
            [DLAlertShowView showInView:alertView popupMode:popupMode outside:outside];
        }];
        return;
    }
    [DLAlertShowView showInView:alertView popupMode:popupMode outsideDisappear:outside?YES:NO];
    sView.outBlock = outside;
}

@end
