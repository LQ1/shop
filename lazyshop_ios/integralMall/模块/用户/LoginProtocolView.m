//
//  LoginProtocolView.m
//  NetSchool
//
//  Created by LY on 2017/4/7.
//  Copyright © 2017年 CDEL. All rights reserved.
//

#import "LoginProtocolView.h"

#import "LawProtocolViewModel.h"

@interface LoginProtocolView()

@property (nonatomic,copy)NSString *prefixString;

@end

@implementation LoginProtocolView

#pragma mark -初始化
- (instancetype)initWithPrefixString:(NSString *)prefixString
{
    if (self = [super init]) {
        self.prefixString = prefixString;
        _clickSignal      = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        [self addViews];
    }
    
    return self;
}

#pragma mark -主界面
- (void)addViews {
    // 控件
    UILabel *protocolLabel               = [UILabel new];
    protocolLabel.font                   = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
    [self addSubview:protocolLabel];
    [protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    // 富文本
    NSString *protocolActionString                   = [NSString stringWithFormat:@"《%@用户服务协议》",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
    NSString *protocolNameString                     = [NSString stringWithFormat:@"%@%@",self.prefixString,protocolActionString];
    protocolLabel.attributedText                      = [CommUtls changeText:protocolActionString
                                                                     content:protocolNameString
                                                              changeTextFont:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                                                    textFont:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE] changeTextColor:[CommUtls colorWithHexString:@"#ffb324"] textColor:[CommUtls colorWithHexString:@"#666666"]];
    
    CGFloat notActionWidth = [CommUtls getContentSize:self.prefixString
                                              font:[UIFont systemFontOfSize:MIDDLE_FONT_SIZE]
                                              size:CGSizeMake(CGFLOAT_MAX, LoginProtocolHeight)].width;
    // 点击事件
    protocolLabel.userInteractionEnabled = YES;
    UIButton *actionBtn = [UIButton new];
    [protocolLabel addSubview:actionBtn];
    [actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(notActionWidth);
        make.right.top.bottom.mas_equalTo(0);
    }];
    
    @weakify(self);
    actionBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        LawProtocolViewModel *vm = [[LawProtocolViewModel alloc] initWithContentID:@"1"];
        [self.clickSignal sendNext:vm];
        return [RACSignal empty];
    }];
}

- (void)dealloc
{
    CLog(@"dealloc----%@",self.class);
}

@end
