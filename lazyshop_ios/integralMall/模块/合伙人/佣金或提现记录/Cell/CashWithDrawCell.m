//
//  CashWithDrawCell.m
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "CashWithDrawCell.h"
#import "Utility.h"

@implementation CashWithDrawCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadData:(CommissionRecordModel*)model{
    self.lblDate.text = [model.created_at formateDate:@"yyyy-MM-dd HH:mm"];
    self.lblContent.text = model.content;
    self.lblMoney.text = [NSString stringWithFormat:@"+￥%.2f",model.commission];
    self.lblStatus.text = [Utility getSafeString:model.status];
}

- (void)updateConstraints {
    [super updateConstraints];
    
    [self.statusWidth setConstant:0.01f];
}

@end
