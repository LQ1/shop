//
//  UIView+Loading.m
//  MobileClassPhone
//
//  Created by SL on 14/12/26.
//  Copyright (c) 2014年 CDEL. All rights reserved.
//

#import "UIView+Loading.h"

@implementation UIView (Loading)

- (void)DLLoadingInSelf{
    [[self DLGetLoadingView:NO] showCDELLoadingView:CDELLoading
                                              cycle:nil
                                              title:nil
                                        buttonTitle:nil
                                        customImage:nil];
}

- (void)DLLoadingHideInSelf{
    [[self DLGetLoadingView:YES] showCDELLoadingView:CDELLoadingRemove
                                               cycle:nil
                                               title:nil
                                         buttonTitle:nil
                                         customImage:nil];
}

- (void)DLLoadingDoneInSelf:(CDELLoadingType)type
                      title:(NSString*)title{
    [[self DLGetLoadingView:(type==CDELLoadingRemove)] showCDELLoadingView:type
                                                                     cycle:nil
                                                                     title:title
                                                               buttonTitle:nil
                                                               customImage:nil];
}

- (void)DLLoadingCycleInSelf:(void(^)())cycle
                        code:(NSInteger)code
                       title:(NSString*)title
                 buttonTitle:(NSString*)buttonTitle{
    if (code == DLDataEmpty) {
        [self DLLoadingDoneInSelf:CDELLoadingDone
                            title:title];
        return;
    }
    [[self DLGetLoadingView:NO] showCDELLoadingView:CDELLoadingCycle
                                              cycle:cycle
                                              title:title
                                        buttonTitle:buttonTitle
                                        customImage:nil];
}

- (void)DLLoadingCustomInSelf:(NSString *)imageName
                         code:(NSInteger)code
                        title:(NSString *)title
                        cycle:(void(^)())cycle
                  buttonTitle:(NSString *)buttonTitle{
    if (code == DLDataEmpty) {
        cycle = nil;
        buttonTitle = nil;
    }
    [[self DLGetLoadingView:NO] showCDELLoadingView:CDELLoadingCustom
                                              cycle:cycle
                                              title:title
                                        buttonTitle:buttonTitle
                                        customImage:imageName];
}

//获取加载框
- (CDELLoadingView *)DLGetLoadingView:(BOOL)remove {
    __block CDELLoadingView *_loadingView = nil;
    [[self subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] < 8) {
            if ([self isKindOfClass:[UITableViewCell class]]) {
                if ([obj isKindOfClass:[UIView class]]) {
                    for (id x in ((UIView *)obj).subviews) {
                        if ([x isKindOfClass:[CDELLoadingView class]]) {
                            _loadingView = (CDELLoadingView*)x;
                            *stop = YES;
                        }
                    }
                }
            }
        }
        if ([obj isKindOfClass:[CDELLoadingView class]]) {
            if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0 && !remove) {
                [obj removeFromSuperview];
            } else {
                _loadingView = (CDELLoadingView*)obj;
            }
            *stop = YES;
        }
    }];
    
    if (!_loadingView && !remove) {
        _loadingView = [CDELLoadingView new];
        [_loadingView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_loadingView];
        [self bringSubviewToFront:_loadingView];
    }
    
    return _loadingView;
}

@end
