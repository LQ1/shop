//
//  CommentCenterListItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CommentCenterListItemCell.h"

#import "CommentCenterListItemViewModel.h"
#import "LYTextColorButton.h"

@interface CommentCenterListItemCell()

@property (nonatomic,strong)LYTextColorButton *commentBtn;

@end

@implementation CommentCenterListItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _clickSignal = [[RACSubject subject] setNameWithFormat:@"%@ clickSignal", self.class];
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 评价按钮
    self.commentBtn = [[LYTextColorButton alloc] initWithTitle:nil
                                                buttonFontSize:MIDDLE_FONT_SIZE
                                                  cornerRadius:3];
    [self.contentView addSubview:self.commentBtn];
    @weakify(self);
    self.commentBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.clickSignal sendNext:nil];
        return [RACSignal empty];
    }];
}

#pragma mark -bind
- (void)bindViewModel:(CommentCenterListItemViewModel *)vm
{
    [super bindViewModel:vm];
    if (vm.isComment) {
        // 已评价
        self.commentBtn.layer.borderColor = [CommUtls colorWithHexString:@"#797979"].CGColor;
        [self.commentBtn setTitleColor:[CommUtls colorWithHexString:@"#797979"] forState:UIControlStateNormal];
        [self.commentBtn setTitle:@"查看评价" forState:UIControlStateNormal];
        // 布局
        [self.commentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(65);
            make.height.mas_equalTo(25);
            make.bottom.right.mas_equalTo(-15);
        }];
        [self.productSkuLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productNameLabel);
            make.right.mas_equalTo(self.commentBtn.left).offset(5);
            make.top.mas_equalTo(self.productNameLabel.bottom);
            make.bottom.mas_equalTo(self.productPriceLabel.top);
        }];
    }else{
        // 未评价
        self.commentBtn.layer.borderColor = [CommUtls colorWithHexString:APP_MainColor].CGColor;
        [self.commentBtn setTitleColor:[CommUtls colorWithHexString:APP_MainColor] forState:UIControlStateNormal];
        [self.commentBtn setTitle:@"评价" forState:UIControlStateNormal];
        // 布局
        [self.commentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(25);
            make.bottom.right.mas_equalTo(-15);
        }];
        [self.productSkuLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productNameLabel);
            make.right.mas_equalTo(self.commentBtn.left).offset(5);
            make.top.mas_equalTo(self.productNameLabel.bottom);
            make.bottom.mas_equalTo(self.productPriceLabel.top);
        }];
    }
    
}

@end
