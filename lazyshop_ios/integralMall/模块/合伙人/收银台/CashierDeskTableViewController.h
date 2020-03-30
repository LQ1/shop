//
//  CashierDeskTableViewController.h
//  integralMall
//
//  Created by liu on 2018/10/17.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface CashierDeskTableViewController : UITableViewController{
    UIImage *_imgChk,*_imgUnChk;
    int _nPayType;//1 微信   2支付宝   3银联   4线下支付
}
@property (weak, nonatomic) IBOutlet UILabel *lblPayMoney;

//@property PartnerMyPageModel *propertyPartnerMyPage;
@property PayInfoModel *propertyPayInfo;

- (void)doSumbit;

@end

NS_ASSUME_NONNULL_END
