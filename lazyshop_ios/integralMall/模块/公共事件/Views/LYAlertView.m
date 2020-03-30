//
//  LYAlertView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/23.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYAlertView.h"

#define DLAlertView_Width           270

@interface LYAlertView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *otherButton;
@property (nonatomic, strong) UIButton *centerButton;

@end

@implementation LYAlertView

#pragma mark -初始化
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                       titles:(NSArray *)titles
                        click:(void(^)(NSInteger index))click {
    return [self initWithTitle:title
                       message:message
                           tip:nil
                        cancel:titles.count>0?titles.firstObject:nil
                        center:titles.count>2?titles[1]:nil
                         other:titles.count>1?titles.lastObject:nil
                         click:click];
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                          tip:(NSString *)tip
                       cancel:(NSString *)cancel
                       center:(NSString *)center
                        other:(NSString *)other
                        click:(void(^)(NSInteger index))click {
    self = [super init];
    if (self) {
        UIView *bgView = [UIView new];
        [self addSubview:bgView];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0;
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        self.bgView = bgView;
        
        // 弹出框
        UIView *alertView = [UIView new];
        [self addSubview:alertView];
        alertView.backgroundColor = [UIColor whiteColor];
        alertView.layer.cornerRadius = 5.;
        alertView.layer.masksToBounds = YES;
        self.alertView = alertView;
        
        UIView *view1 = nil;
        // 标题
        if (title) {
            UILabel *label = [UILabel new];
            [alertView addSubview:label];
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
            label.text = title;
            label.textColor = [CommUtls colorWithHexString:@"#222222"];
            label.font = [UIFont systemFontOfSize:17];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.top.mas_equalTo(13);
            }];
            
            UIView *lineView = [self fetchLine];
            [alertView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(1);
                make.top.mas_equalTo(label.mas_bottom).mas_equalTo(13);
            }];
            view1 = lineView;
        }
        // 内容
        if (message) {
            UILabel *label = [UILabel new];
            [alertView addSubview:label];
            label.numberOfLines = 0;
            label.text = message;
            label.textColor = [CommUtls colorWithHexString:@"#222222"];
            label.font = [UIFont systemFontOfSize:17];
            label.textAlignment = NSTextAlignmentCenter;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                if (view1) {
                    make.top.mas_equalTo(view1.mas_bottom).mas_equalTo(20);
                }else{
                    make.top.mas_equalTo(40);
                }
            }];
            view1 = label;
        }
        
        if (tip && message) {
            UILabel *label = [UILabel new];
            [alertView addSubview:label];
            label.numberOfLines = 0;
            label.text = tip;
            label.textColor = [CommUtls colorWithHexString:@"#999999"];
            label.font = [UIFont systemFontOfSize:12];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.top.mas_equalTo(view1.mas_bottom).mas_equalTo(23);
            }];
            view1 = label;
        }
        
        if (message) {
            UIView *lineView = [self fetchLine];
            [alertView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(1);
                make.top.mas_equalTo(view1.mas_bottom).mas_equalTo((title||tip)?20:40);
            }];
            view1 = lineView;
        }
        
        @weakify(self);
        if (cancel) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [alertView addSubview:button];
            [button setTitle:cancel forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:[CommUtls colorWithHexString:@"#222222"] forState:UIControlStateNormal];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                if (!other) {
                    make.right.mas_equalTo(0);
                }
                make.left.mas_equalTo(0);
                make.height.mas_equalTo(50);
                make.top.mas_equalTo(view1.mas_bottom);
            }];
            button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self);
                [self disappear];
                if (click) {
                    click(0);
                }
                return [RACSignal empty];
            }];
            view1 = button;
            self.cancelButton = button;
        }
        
        if (center) {
            UIView *lineView = [self fetchLine];
            [alertView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(view1);
                make.width.mas_equalTo(1);
                make.left.mas_equalTo(view1.mas_right).mas_equalTo(0);
            }];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [alertView addSubview:button];
            [button setTitle:center forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:[CommUtls colorWithHexString:@"#222222"] forState:UIControlStateNormal];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view1.mas_right);
                make.width.mas_equalTo(view1.mas_width);
                make.top.mas_equalTo(view1.mas_top);
                make.height.mas_equalTo(50);
            }];
            button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self);
                [self disappear];
                click(1);
                return [RACSignal empty];
            }];
            view1 = button;
            self.centerButton = button;
        }
        
        if (other) {
            if (cancel || center) {
                UIView *lineView = [self fetchLine];
                [alertView addSubview:lineView];
                [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.mas_equalTo(view1);
                    make.width.mas_equalTo(1);
                    make.left.mas_equalTo(view1.mas_right).mas_equalTo(0);
                }];
            }
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [alertView addSubview:button];
            [button setTitle:other forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:[CommUtls colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
            [button setBackgroundColor:[CommUtls colorWithHexString:APP_MainColor]];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                if (cancel) {
                    make.left.mas_equalTo(view1.mas_right);
                    make.width.mas_equalTo(view1.mas_width);
                    make.top.mas_equalTo(view1.mas_top);
                }else{
                    make.left.mas_equalTo(0);
                    make.top.mas_equalTo(view1.mas_bottom);
                }
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(50);
            }];
            button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self);
                [self disappear];
                if (center) {
                    click(2);
                } else if (cancel) {
                    click(1);
                } else {
                    click(0);
                }
                return [RACSignal empty];
            }];
            view1 = button;
            self.otherButton = button;
        }
        
        [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(DLAlertView_Width);
            make.bottom.mas_equalTo(view1.mas_bottom);
        }];
    }
    return self;
}

- (void)show {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    [UIView animateWithDuration:.3 animations:^{
        self.bgView.alpha = .2;
        self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    }];
}

- (void)disappear {
    [UIView animateWithDuration:.3 animations:^{
        self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, .5, .5);
        self.alertView.alpha = 0;
        [self.bgView setAlpha:0];
    } completion:^(BOOL s){
        [self.bgView removeFromSuperview];
        self.bgView = nil;
        [self.alertView removeFromSuperview];
        self.alertView = nil;
        [self removeFromSuperview];
    }];
}

- (UIView *)fetchLine {
    UIView *view = [UIView new];
    view.backgroundColor = [CommUtls colorWithHexString:APP_GapColor];
    return view;
}

- (void)setIsOutside:(BOOL)isOutside {
    if (isOutside) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        @weakify(self);
        button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self disappear];
            return [RACSignal empty];
        }];
    }
}

@end
