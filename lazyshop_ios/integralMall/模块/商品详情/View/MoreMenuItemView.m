//
//  MoreMenuItemView.m
//  NetSchool
//
//  Created by LY on 2017/9/13.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "MoreMenuItemView.h"

#import "SiftModel.h"

@interface MoreMenuItemView()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIView *bottomLine;

@end

@implementation MoreMenuItemView

- (void)addViews
{
    [super addViews];
    // 图
    UIImageView *imageView = [UIImageView new];
    self.imageView = imageView;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.siftConditionLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.centerY.mas_equalTo(imageView);
    }];
    // 文
    self.siftConditionLb.textColor = [UIColor whiteColor];
    // 线
    UIView *lineView = [UIView new];
    self.bottomLine = lineView;
    lineView.backgroundColor = [CommUtls colorWithHexString:@"#454341"];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1./[UIScreen mainScreen].scale);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
}

- (void)setIsSelected:(BOOL)isSelected
{

}

#pragma mark -reload
- (void)reloadDataWithSiftModel:(SiftModel *)siftModel
{
    UIImage *image = [UIImage imageNamed:siftModel.siftImgName];
    if ([siftModel.siftId integerValue] == 2) {
        // 消息
        self.imageView.hidden = YES;
        UIButton *messageBtn = [[PublicEventManager shareInstance] fetchMessageButtonWithNavigationController:nil];
        [self addSubview:messageBtn];
        [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
        }];
        messageBtn.userInteractionEnabled = NO;
        
        [[self.touchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [messageBtn.rac_command execute:nil];
        }];
    }else{
        self.imageView.hidden = NO;
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
        }];
        self.imageView.image = image;
    }
    self.siftConditionLb.text = siftModel.siftName;
    self.bottomLine.hidden = !siftModel.hasBottomLine;
}

@end
