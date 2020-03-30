//
//  GoodsDetailRightMoreCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "GoodsDetailRightMoreBaseCell.h"

@interface GoodsDetailRightMoreBaseCell()

@property (nonatomic,strong)UIButton *moreButton;

@end

@implementation GoodsDetailRightMoreBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _moreBtnClickSignal = [[RACSubject subject] setNameWithFormat:@"%@ moreBtnClickSignal", self.class];
        // 更多
        UIButton *moreBtn = [UIButton new];
        self.rightMoreBtn = moreBtn;
        [self.contentView addSubview:moreBtn];
        [moreBtn setImage:[UIImage imageNamed:@"详情页优惠券查看更多"] forState:UIControlStateNormal];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.bottom.mas_equalTo(0);
        }];
        moreBtn.userInteractionEnabled = NO;
        
        // 点击事件
        UIButton *clickBtn = [UIButton new];
        RAC(clickBtn,hidden) = RACObserve(self.rightMoreBtn, hidden);
        [self.contentView addSubview:clickBtn];
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        @weakify(self);
        clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.moreBtnClickSignal sendNext:nil];
            return [RACSignal empty];
        }];
    }
    return self;
}

@end
