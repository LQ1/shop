//
//  LYUpImgDownTxtView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYUpImgDownTxtView.h"

#import "LYRedRoundLabel.h"

@interface LYUpImgDownTxtView()

@property (nonatomic,strong)LYRedRoundLabel *roundLabel;

@end

@implementation LYUpImgDownTxtView

- (instancetype)initWithImageName:(NSString *)imageName
                            title:(NSString *)title
                       titleColor:(NSString *)titleColor
                       clickBlock:(LYUpImgDownTxtViewClickBlock)clickBlock
{
    self = [super init];
    if (self) {
        // 文
        self.titleLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                       textAlignment:NSTextAlignmentCenter
                                           textColor:titleColor
                                        adjustsWidth:NO
                                        cornerRadius:0
                                                text:title];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(0);
        }];
        // 图
        UIView *imageContentView = [UIView new];
        [self addSubview:imageContentView];
        [imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(self.titleLabel.top).offset(-5);
        }];
        UIImage *image = [UIImage imageNamed:imageName];
        self.imageView = [[UIImageView alloc] initWithImage:image];
        [imageContentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
            make.center.mas_equalTo(imageContentView);
        }];
        // 角标
        self.roundLabel = [[LYRedRoundLabel alloc] init];
        [self.imageView addSubview:self.roundLabel];
        [self.roundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(LYRedRoundLabelHeight);
            make.centerX.mas_equalTo(self.imageView.right);
            make.centerY.mas_equalTo(self.imageView.top);
        }];
        self.roundLabel.hidden = YES;
        
        // 点击事件
        UIButton *clickBtn = [UIButton new];
        [self addSubview:clickBtn];
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            if (clickBlock) {
                clickBlock();
            }
            return [RACSignal empty];
        }];
    }
    return self;
}

#pragma mark -设置角标
- (void)setRoundNumber:(NSInteger)roundNumber
{
    if (roundNumber>0) {
        self.roundLabel.hidden = NO;
        if (roundNumber>9) {
            self.roundLabel.text = @"9+";
            [self.roundLabel updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(LYRedRoundLabelHeight*1.5);
            }];
        }else{
            self.roundLabel.text = [NSString stringWithFormat:@"%ld",(long)roundNumber];
            [self.roundLabel updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(LYRedRoundLabelHeight);
            }];
        }
    }else{
        self.roundLabel.hidden = YES;
    }
}

@end
