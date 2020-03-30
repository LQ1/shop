//
//  HomeAllActivityHeaderItemView.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/3.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "HomeAllActivityHeaderItemView.h"

@interface HomeAllActivityHeaderItemView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSString *title;

@end

@implementation HomeAllActivityHeaderItemView

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.titleLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                   textAlignment:NSTextAlignmentCenter
                                       textColor:@"#a5a5a5"
                                    adjustsWidth:NO
                                    cornerRadius:14
                                            text:self.title];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(28);
        make.center.mas_equalTo(self);
    }];
    
    UIButton *clickBtn = [UIButton new];
    [self addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    @weakify(self);
    clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:nil];
        return [RACSignal empty];
    }];
}

#pragma mark -set
- (void)setChecked:(BOOL)checked
{
    _checked = checked;
    if (checked) {
        self.titleLabel.textColor = [CommUtls colorWithHexString:@"#ffffff"];
        self.titleLabel.backgroundColor = [CommUtls colorWithHexString:APP_MainColor];
    }else{
        self.titleLabel.textColor = [CommUtls colorWithHexString:@"#a5a5a5"];
        self.titleLabel.backgroundColor = [CommUtls colorWithHexString:@"#ffffff"];
    }
}

@end
