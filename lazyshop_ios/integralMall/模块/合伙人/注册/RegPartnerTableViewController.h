//
//  RegPartnerTableViewController.h
//  integralMall
//
//  Created by liu on 2018/10/9.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegPartnerViewController;

NS_ASSUME_NONNULL_BEGIN

@interface RegPartnerTableViewController : UITableViewController{
    NSMutableArray *_arrayQuestions;
    UIImage *_imgChked,*_imgUnChked;
    int _nSec;
    NSTimer *_timer;
    NSString *_szName,*_szIdCard;
}
@property RegPartnerViewController *propertyRegPartnerViewCtrl;

@property (weak, nonatomic) IBOutlet UITextField *txtPhoneNum;
@property (weak, nonatomic) IBOutlet UITextField *txtCode;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtIdCard;
@property (weak, nonatomic) IBOutlet UIView *viewMale;
@property (weak, nonatomic) IBOutlet UIView *viewFemale;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnSendCode;

@property NSString *propertyRefUsrId;

@end

NS_ASSUME_NONNULL_END
