//
//  CategorySegmentView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/7.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CategorySegmentView.h"

@interface CategorySegmentView()

@property (nonatomic,strong)UIButton *scoreButton;
@property (nonatomic,strong)UIButton *integralButton;
@property (nonatomic,copy  )CategorySegmentClickBlock clickBlock;

@end

@implementation CategorySegmentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
        [self bindCommand];
    }
    return self;
}

- (void)addViews
{
    // 储值商城
    UIButton *scoreButton = [UIButton new];
    self.scoreButton = scoreButton;
    scoreButton.titleLabel.font = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
    [scoreButton setTitle:@"懒店商城" forState:UIControlStateNormal];
    [scoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scoreButton setTitleColor:[CommUtls colorWithHexString:APP_MainColor] forState:UIControlStateSelected];
    [self addSubview:scoreButton];
    [scoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(self.centerX);
    }];
    // 积分商城
    UIButton *integralButton = [UIButton new];
    self.integralButton = integralButton;
    integralButton.titleLabel.font = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
    [integralButton setTitle:@"积分商城" forState:UIControlStateNormal];
    [integralButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [integralButton setTitleColor:[CommUtls colorWithHexString:APP_MainColor] forState:UIControlStateSelected];
    [self addSubview:integralButton];
    [integralButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.centerX);
    }];
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    [self changeToClickType:CategorySegmentViewClickTypeStore];
}

- (void)bindCommand
{
    @weakify(self);
    // 点击事件
    self.scoreButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self changeToClickType:CategorySegmentViewClickTypeStore];
        return [RACSignal empty];
    }];
    self.integralButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self changeToClickType:CategorySegmentViewClickTypeIntegral];
        return [RACSignal empty];
    }];
}
// 使切换
- (void)changeToClickType:(CategorySegmentViewClickType)cellType
{
    switch (cellType) {
        case CategorySegmentViewClickTypeStore:
        {
            if (!self.scoreButton.selected) {
                // 储值商城
                [self changeUIToClickType:CategorySegmentViewClickTypeStore];
                if (self.clickBlock) {
                    self.clickBlock(CategorySegmentViewClickTypeStore);
                }
            }
        }
            break;
        case CategorySegmentViewClickTypeIntegral:
        {
            if (!self.integralButton.selected) {
                // 积分商城
                [self changeUIToClickType:CategorySegmentViewClickTypeIntegral];
                if (self.clickBlock) {
                    self.clickBlock(CategorySegmentViewClickTypeIntegral);
                }
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -设置类型切换的回调
- (void)setChangeClickBlock:(CategorySegmentClickBlock)block
{
    self.clickBlock = block;
}

#pragma mark -设置UI显示
- (void)changeUIToClickType:(CategorySegmentViewClickType)cellType
{
    switch (cellType) {
        case CategorySegmentViewClickTypeStore:
        {
            if (!self.scoreButton.selected) {
                // 储值商城
                self.scoreButton.selected = YES;
                self.integralButton.selected = NO;
                self.scoreButton.backgroundColor = [UIColor whiteColor];
                self.integralButton.backgroundColor = [UIColor clearColor];
            }
        }
            break;
        case CategorySegmentViewClickTypeIntegral:
        {
            if (!self.integralButton.selected) {
                // 积分商城
                self.integralButton.selected = YES;
                self.scoreButton.selected = NO;
                self.integralButton.backgroundColor = [UIColor whiteColor];
                self.scoreButton.backgroundColor = [UIColor clearColor];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
