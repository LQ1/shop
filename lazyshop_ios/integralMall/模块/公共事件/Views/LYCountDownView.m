//
//  CountDownView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/18.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYCountDownView.h"

@interface LYCountDownView()

@property (nonatomic,copy)NSString *backColorString;
@property (nonatomic,copy)NSString *textColorString;
@property (nonatomic,copy)NSString *dotColorString;
@property (nonatomic,assign)CGFloat dotWidth;

@property (nonatomic,strong)UILabel *hourLabel;
@property (nonatomic,strong)UILabel *miniteLabel;
@property (nonatomic,strong)UILabel *secondLabel;


@end

@implementation LYCountDownView

- (instancetype)initWithItemBackColorString:(NSString *)backColorString
                            textColorString:(NSString *)textColorString
                             dotColorString:(NSString *)dotColorString
                                   dotWidth:(CGFloat)dotWidth
{
    self = [super init];
    if (self) {
        self.backColorString = backColorString;
        self.textColorString = textColorString;
        self.dotColorString = dotColorString;
        self.dotWidth = dotWidth;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 时
    self.hourLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                  textAlignment:NSTextAlignmentCenter
                                      textColor:self.textColorString
                                   adjustsWidth:YES
                                   cornerRadius:1
                                           text:nil];
    self.hourLabel.backgroundColor = [CommUtls colorWithHexString:self.backColorString];
    [self.hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.height.mas_equalTo(CountDownViewHeight);
        make.centerY.mas_equalTo(self);
    }];
    // :
    UILabel *dotLabel1 = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                      textAlignment:NSTextAlignmentCenter
                                          textColor:self.dotColorString
                                       adjustsWidth:NO
                                       cornerRadius:0
                                               text:@":"];
    dotLabel1.font = [UIFont boldSystemFontOfSize:SMALL_FONT_SIZE];
    [dotLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hourLabel.right);
        make.top.bottom.mas_equalTo(self.hourLabel);
        make.width.mas_equalTo(self.dotWidth);
    }];
    // 分
    self.miniteLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                    textAlignment:NSTextAlignmentCenter
                                        textColor:self.textColorString
                                     adjustsWidth:YES
                                     cornerRadius:1
                                             text:nil];
    self.miniteLabel.backgroundColor = [CommUtls colorWithHexString:self.backColorString];
    [self.miniteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dotLabel1.right);
        make.width.height.mas_equalTo(self.hourLabel);
        make.centerY.mas_equalTo(self);
    }];
    // :
    UILabel *dotLabel2 = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                      textAlignment:NSTextAlignmentCenter
                                          textColor:self.dotColorString
                                       adjustsWidth:NO
                                       cornerRadius:0
                                               text:@":"];
    dotLabel2.font = [UIFont boldSystemFontOfSize:SMALL_FONT_SIZE];
    [dotLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.miniteLabel.right);
        make.top.bottom.mas_equalTo(self.miniteLabel);
        make.width.mas_equalTo(self.dotWidth);
    }];
    // 秒
    self.secondLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                    textAlignment:NSTextAlignmentCenter
                                        textColor:self.textColorString
                                     adjustsWidth:YES
                                     cornerRadius:1
                                             text:nil];
    self.secondLabel.backgroundColor = [CommUtls colorWithHexString:self.backColorString];
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dotLabel2.right);
        make.width.height.mas_equalTo(self.miniteLabel);
        make.centerY.mas_equalTo(self);
    }];
}

#pragma mark -获取高度
- (CGFloat)totalWidth
{
    return CountDownViewHeight*3+self.dotWidth*2;
}

#pragma mark -设置时间
- (void)setRemainingTime:(NSInteger)time
{
    NSInteger hour = time/60/60;
    NSInteger minite = (time/60)%60;
    NSInteger second = time%60;
    
    self.hourLabel.text = [NSString stringWithFormat:@"%02ld",(long)hour];
    self.miniteLabel.text = [NSString stringWithFormat:@"%02ld",(long)minite];
    self.secondLabel.text = [NSString stringWithFormat:@"%02ld",(long)second];
}

@end
