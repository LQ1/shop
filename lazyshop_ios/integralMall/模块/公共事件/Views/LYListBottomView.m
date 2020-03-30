//
//  LYListBottomView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/21.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYListBottomView.h"

@implementation LYListBottomView

- (instancetype)initWithTitles:(NSArray *)titles
              backColorStrings:(NSArray *)backColorStrings
              textColorStrings:(NSArray *)textColorStrings
                       leftPro:(CGFloat)leftPro
                    clickBlock:(LYListBottomViewClickBlock)block
{
    self = [super init];
    if (self) {
        // 1
        UIButton *button1 = [UIButton new];
        [button1 setTitle:titles[0] forState:UIControlStateNormal];
        [button1 setBackgroundColor:[CommUtls colorWithHexString:backColorStrings[0]]];
        [button1 setTitleColor:[CommUtls colorWithHexString:textColorStrings[0]] forState:UIControlStateNormal];
        [self addSubview:button1];
        [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(KScreenWidth*leftPro);
        }];
        button1.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            if (block) {
                block(0);
            }
            return [RACSignal empty];
        }];
        // 2
        UIButton *button2 = [UIButton new];
        [button2 setTitle:titles[1] forState:UIControlStateNormal];
        [button2 setBackgroundColor:[CommUtls colorWithHexString:backColorStrings[1]]];
        [button2 setTitleColor:[CommUtls colorWithHexString:textColorStrings[1]] forState:UIControlStateNormal];
        [self addSubview:button2];
        [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(button1.right);
        }];
        button2.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            if (block) {
                block(1);
            }
            return [RACSignal empty];
        }];
        [self addTopLineWithColorString:@"#eaeaea"];
    }
    return self;
}

@end
