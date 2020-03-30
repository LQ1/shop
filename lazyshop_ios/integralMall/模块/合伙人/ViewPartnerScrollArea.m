//
//  ViewPartnerScrollArea.m
//  integralMall
//
//  Created by liu on 2018/10/18.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ViewPartnerScrollArea.h"
#import "GlobalSetting.h"
#import "EntityModel.h"
#import "ImageLoadingUtils.h"
#import "UIColor+YYAdd.h"
#import "Utility.h"

@implementation ViewPartnerScrollArea

- (instancetype)initWithParentView:(UIView*)viewParent{
    self = [super init];
    viewParent.clipsToBounds = YES;
    
    
    //滚动区域
    for (UIView *v in viewParent.subviews) {
        [v removeFromSuperview];
    }
    CGRect rc = viewParent.frame;

    rc.origin.x = rc.origin.y = 0;
    _viewContainerScrollArea = [[UIView alloc] initWithFrame:rc];
    [viewParent addSubview:_viewContainerScrollArea];
    
    [self createScrollNotice:[GlobalSetting getThis].arrayPartnerScrollInfos];
    
    return self;
}

//创建滚动区域视图
- (void)createScrollNotice:(NSMutableArray*)arrayPartners{
    
    for (int i=0; i<arrayPartners.count; i++) {
        PartnerScrollModel *psm = [arrayPartners objectAtIndex:i];
        
        UIView *viewScrollContainer = [[UIView alloc] initWithFrame:CGRectMake(8 + i*260, (64-48)*0.5, 260, 48)];
        UIImageView *imgAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
        imgAvatar.layer.cornerRadius = imgAvatar.frame.size.width*0.5f;
        imgAvatar.layer.masksToBounds = YES;
        [ImageLoadingUtils loadImage:imgAvatar withURL:psm.avatar];
        [viewScrollContainer addSubview:imgAvatar];
        
        UILabel *lblTip = [[UILabel alloc] initWithFrame:CGRectMake(48+8, 0, 200, 48)];
        lblTip.font = [UIFont systemFontOfSize:14.0f];
        lblTip.text = psm.msg;
        lblTip.textColor = [UIColor colorWithHexString:@"#E02124"];
        [viewScrollContainer addSubview:lblTip];
        
        [_viewContainerScrollArea addSubview:viewScrollContainer];
    }
}

//滚动通知
- (void)startAnimationNotice{
    if (![GlobalSetting getThis].arrayPartnerScrollInfos) {
        return;
    }
     _viewContainerScrollArea.transform = CGAffineTransformMakeTranslation(0, 0);
    
    int nLen = (int)[GlobalSetting getThis].arrayPartnerScrollInfos.count * 270;
    float fDuring = [GlobalSetting getThis].arrayPartnerScrollInfos.count * 4.0f;
    [_viewContainerScrollArea.layer removeAllAnimations];
    const float oriWidth = SCREEN_WIDTH - 60;
    if (nLen > oriWidth) {
        float offset = nLen - oriWidth;
        
        [UIView animateWithDuration:fDuring
                              delay:0
                            options:UIViewAnimationOptionRepeat //动画重复的主开关
         //|UIViewAnimationOptionAutoreverse //动画重复自动反向，需要和上面这个一起用
         |UIViewAnimationOptionCurveLinear //动画的时间曲线，滚动字幕线性比较合理
                         animations:^{
                             _viewContainerScrollArea.transform = CGAffineTransformMakeTranslation(-offset, 0);
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 NSLog(@"notice animation finished");
                                 _viewContainerScrollArea.transform = CGAffineTransformMakeTranslation(0, 0);
                                 //[self startAnimationNotice];
                             }
                         }
         ];
    }
}

@end
