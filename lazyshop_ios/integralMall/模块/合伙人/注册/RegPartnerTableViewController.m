//
//  RegPartnerTableViewController.m
//  integralMall
//
//  Created by liu on 2018/10/9.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "RegPartnerTableViewController.h"
#import "RegPartnerCell.h"
#import "PartnerCompactViewController.h"
#import "DataViewModel.h"
#import "UIColor+YYAdd.h"
#import "RegPartnerViewController.h"

@interface RegPartnerTableViewController ()

@end

@implementation RegPartnerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RegPartnerCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([RegPartnerCell class])];
    
    [self.btnNext addTarget:self action:@selector(btnNext_onClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.btnNext.enabled = NO;
    
    [self initControl];
}

- (void)initControl{
    [self initData];
}

- (void)initData{
    _imgChked = [UIImage imageNamed:@"默认地址选中.png"];
    _imgUnChked = [UIImage imageNamed:@"未勾选.png"];
    _arrayQuestions = [NSMutableArray new];
    _nSec = 59;
    self.txtPhoneNum.text = SignInUser.mobilePhone;
    
    [self performSelectorInBackground:@selector(thread_question) withObject:nil];
    
    UITapGestureRecognizer *gesture_male = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_male_onClicked:)];
    self.viewMale.userInteractionEnabled = YES;
    [self.viewMale addGestureRecognizer:gesture_male];
    
    UITapGestureRecognizer *gesture_female = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_female_onClicked:)];
    self.viewFemale.userInteractionEnabled = YES;
    [self.viewFemale addGestureRecognizer:gesture_female];
    
    [self.txtPhoneNum addTarget:self action:@selector(txt_value_changed:) forControlEvents:UIControlEventEditingChanged];
    [self.txtCode addTarget:self action:@selector(txt_value_changed:) forControlEvents:UIControlEventEditingChanged];
    [self.txtName addTarget:self action:@selector(txt_value_changed:) forControlEvents:UIControlEventEditingChanged];
    [self.txtIdCard addTarget:self action:@selector(txt_value_changed:) forControlEvents:UIControlEventEditingChanged];
    [self.txtAge addTarget:self action:@selector(txt_value_changed:) forControlEvents:UIControlEventEditingChanged];
}

//男选中
- (void)gesture_male_onClicked:(id)sender{
    UIImageView *imgMale = [self.viewMale.subviews objectAtIndex:1];
    UIImageView *imgFemale = [self.viewFemale.subviews objectAtIndex:1];
    
    imgMale.image = _imgChked;
    imgFemale.image = _imgUnChked;
}

//女选中
- (void)gesture_female_onClicked:(id)sender{
    UIImageView *imgMale = [self.viewMale.subviews objectAtIndex:1];
    UIImageView *imgFemale = [self.viewFemale.subviews objectAtIndex:1];
    
    imgMale.image = _imgUnChked;
    imgFemale.image = _imgChked;
}

- (void)txt_value_changed:(UITextField*)sender{
    [self btnCanNextStep];
    if (sender == self.txtIdCard) {
        if (self.txtIdCard.text.length >= 10) {
            NSRange range = {6,4};
            int nYear = [[self.txtIdCard.text substringWithRange:range] intValue];
            NSDate *dtNow = [NSDate date];
            NSCalendar* calendar = [NSCalendar currentCalendar];
            NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:dtNow];
            int nCurYear = (int)components.year;
            int nSub = nCurYear - nYear;
            if (nSub > 0 && nSub < 100) {
                self.txtAge.text = [NSString stringWithFormat:@"%d",nSub];
            }
        }
    }
}

//是否可以继续下一步
- (void)btnCanNextStep{
    NSString *szName = [self.txtName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([Utility isStringEmptyOrNull:self.txtPhoneNum.text] ||
        [Utility isStringEmptyOrNull:szName] ||
        [Utility isStringEmptyOrNull:self.txtIdCard.text] ||
        [Utility isStringEmptyOrNull:self.txtAge.text] ||
        ![self isAllChked]) {
        self.btnNext.enabled = NO;
        [self.btnNext setTitleColor:[UIColor colorWithHexString:@"#CECECE"] forState:UIControlStateNormal];
        self.btnNext.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    }else{
        self.btnNext.enabled = YES;
        [self.btnNext setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        self.btnNext.backgroundColor = [UIColor colorWithHexString:@"#FF0000"];
    }
}

//所有问题是否已经选择
- (BOOL)isAllChked{
    for (JoinPartnerQuestion *jpq in _arrayQuestions) {
        if (jpq.option_id == 0) {
            return NO;
        }
    }
    return YES;
}

//发送验证码
- (IBAction)btnSendCode:(id)sender {
    _nSec = 59;
    self.btnSendCode.enabled = NO;
    self.btnSendCode.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [self.btnSendCode setTitleColor:[UIColor colorWithHexString:@"#CECECE"] forState:UIControlStateNormal];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSString *szSec = [NSString stringWithFormat:@"%d后重新发送",_nSec--];
        self.btnSendCode.titleLabel.text = szSec;
        [self.btnSendCode setTitle:szSec forState:UIControlStateNormal];
        
        if (_nSec == 0) {
            [self.btnSendCode setTitle:@"重新发送" forState:UIControlStateNormal];
            self.btnSendCode.enabled = YES;
            [self.btnSendCode setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
            self.btnSendCode.backgroundColor = [UIColor colorWithHexString:@"#FF0000"];
            [_timer invalidate];
        }
    }];
    [_timer fire];
}

//下一步
- (void)btnNext_onClicked:(id)sender{
    _szName = self.txtName.text;
    _szIdCard = self.txtIdCard.text;
    
    //验证姓名
    if ([self.txtName.text length] <= 0) {
        [DLLoading DLToolTipInWindow:@"请输入姓名"];
        return;
    }
    
    //验证手机号
    if (![Utility isPhoneNum:self.txtPhoneNum.text]) {
        [DLLoading DLToolTipInWindow:@"请输入正确的手机号"];
        return;
    }
    
    //验证身份证号
//    if (![Utility judgeIdentityStringValid:self.txtIdCard.text]) {
//        [DLLoading DLToolTipInWindow:@"请输入正确的身份证号"];
//        return;
//    }
    
    // 年龄
    int nYear = [self.txtAge.text intValue];
    if (nYear < 18 || nYear > 100) {
        [DLLoading DLToolTipInWindow:@"请输入正确的年龄"];
        return;
    }
    
    [self.btnNext setEnabled:NO];
    [self.propertyRegPartnerViewCtrl.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_reg) withObject:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return _arrayQuestions.count;
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 189;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        JoinPartnerQuestion *jpq = [_arrayQuestions objectAtIndex:indexPath.row];
        RegPartnerCell *cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([RegPartnerCell class]) owner:self options:nil].firstObject;
        //[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RegPartnerCell class])];
        
        [cell loadData:jpq withBlockItemClicked:^{
            [self btnCanNextStep];
        }];
        
        return cell;
    }

    // Configure the cell...
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

//跳转到w支付页面
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    PartnerCompactViewController *partnerCompactViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PartnerCompactViewController class])];
//    partnerCompactViewCtrl.propertyOrderId = 0;
//    [self.navigationController pushViewController:partnerCompactViewCtrl animated:YES];
}

//合伙人注册
- (void)thread_reg{
    int nRet = [[DataViewModel getInstance] partnerReg:self.propertyRefUsrId withRealName:_szName withIdCard:_szIdCard withQuestions:_arrayQuestions];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.btnNext setEnabled:YES];
        [self.propertyRegPartnerViewCtrl.view DLLoadingHideInSelf];
        if (nRet > 0) {
            PartnerCompactViewController *partnerCompactViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PartnerCompactViewController class])];
            partnerCompactViewCtrl.propertyOrderId = nRet;
            [self.navigationController pushViewController:partnerCompactViewCtrl animated:YES];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[DataViewModel getInstance].ERROR_MSG delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    });
    
}

//查询问题
- (void)thread_question{
    NSMutableArray *arrayTmp = [[DataViewModel getInstance] partnerQuestion];
    if (arrayTmp) {
        [_arrayQuestions addObjectsFromArray:arrayTmp];
        [self.tableView reloadData];
    }
}

@end
