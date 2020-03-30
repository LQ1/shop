//
//  CashWithdrawViewController.h
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePartnerViewController.h"
#import "Include.h"

NS_ASSUME_NONNULL_BEGIN

@interface CashWithdrawViewController : BasePartnerViewController{
    NSMutableArray *_arrayDatas;
    int _nPageNum;
}
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusWidth;


//类型  1提现记录  2佣金记录
@property int propertyTag;


@end

NS_ASSUME_NONNULL_END
