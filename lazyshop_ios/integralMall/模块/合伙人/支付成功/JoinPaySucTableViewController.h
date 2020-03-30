//
//  JoinPaySucTableViewController.h
//  integralMall
//
//  Created by liu on 2018/10/13.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JoinPaySucTableViewController : UITableViewController{
    UIImage *_imgChk,*_imgUnChk;
    int _nType;//1支付宝 2银联
    int _nReturnType;//奖励方式 0按单人，1按团队
    int _nDealYear;//签约年份 1,2,3年
    NSString *_szAccount;
    PartnerInfoModel *_pim;
    
    PartnerInfoModel *_partnerInfoModel;
}
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNum;
@property (weak, nonatomic) IBOutlet UILabel *commissionMethodLabel;
@property (weak, nonatomic) IBOutlet UIView *viewAlipy;
@property (weak, nonatomic) IBOutlet UIView *viewCard;
@property (weak, nonatomic) IBOutlet UIView *viewRewardBySingle;
@property (weak, nonatomic) IBOutlet UIView *viewRewardByGroup;
@property (weak, nonatomic) IBOutlet UILabel *txtDesc;
@property (weak, nonatomic) IBOutlet UITextField *txtAccount;
@property (weak, nonatomic) IBOutlet UIView *viewYear1;
@property (weak, nonatomic) IBOutlet UIView *viewYear2;
@property (weak, nonatomic) IBOutlet UIView *viewYear3;
@property (weak, nonatomic) IBOutlet UIImageView *protocolImageView;
@property (weak, nonatomic) IBOutlet UIImageView *upOrDownImageView;
@property (weak, nonatomic) IBOutlet UILabel *bankDescLabel;


- (void)btnChkAndSubmit;

@end

NS_ASSUME_NONNULL_END
