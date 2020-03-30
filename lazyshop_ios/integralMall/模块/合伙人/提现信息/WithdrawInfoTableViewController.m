//
//  WithdrawInfoTableViewController.m
//  integralMall
//
//  Created by liu on 2018/10/17.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "WithdrawInfoTableViewController.h"
#import "Utility.h"
#import "DataViewModel.h"
#import "MyCorpsInfoViewController.h"

@interface WithdrawInfoTableViewController ()

@property (strong, nonatomic) NSMutableArray *bankArray;
@property (assign, nonatomic) int bankNumber;
@property (assign, nonatomic) BOOL isAgree;

@end

@implementation WithdrawInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [Utility setExtraCellLineHidden:self.tableView];
    _imgChk = [UIImage imageNamed:@"已勾选_chked.png"];
    _imgUnChk = [UIImage imageNamed:@"未勾选_unchked.png"];
    self.btnConfirm.layer.cornerRadius = 20;
    self.btnConfirm.layer.masksToBounds = YES;
    
    _nType = -1;//默认支付宝
    [self setBankNumber:1];
    [self setIsAgree:NO];
    [self.commissionMethodLabel setText:@""];
    
    UITapGestureRecognizer *gesture_union = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_chked_onClicked:)];
    self.viewUnionPay.userInteractionEnabled = YES;
    [self.viewUnionPay addGestureRecognizer:gesture_union];
    
    UITapGestureRecognizer *gesture_alipy = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_chked_onClicked:)];
    self.viewAlipyPay.userInteractionEnabled = YES;
    [self.viewAlipyPay addGestureRecognizer:gesture_alipy];
    
    [self.btnConfirm addTarget:self action:@selector(btnConfirm_onClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *gestureProtocol = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_Protocol_onClicked:)];
    self.protocolImageView.userInteractionEnabled = YES;
    [self.protocolImageView addGestureRecognizer:gestureProtocol];
    
    UITapGestureRecognizer *gestureUpOrDown = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_UpOrDown_onClicked:)];
    self.upOrDownImageView.userInteractionEnabled = YES;
    [self.upOrDownImageView addGestureRecognizer:gestureUpOrDown];
}

- (void)viewWillAppear:(BOOL)animated{
    [self performSelectorInBackground:@selector(thread_initData) withObject:nil];
    
    if (self.propertyType == 1 || self.propertyType == 3) {
        [self.btnConfirm setTitle:(self.propertyType == 1)?@"确定":@"确定提交" forState:UIControlStateNormal];
        if (self.propertyType == 1) {
            [self.withdrawDescLabel setText:[NSString stringWithFormat:@"%.2f元",self.can_get_commission]];
        }
    }else if (self.propertyType == 2) {
        //退还保证金
        self.lblBackDesc.text = @"退还至";
        [self.btnConfirm setTitle:@"申请退还" forState:UIControlStateNormal];
        self.lblBack.text = @"";//j最下面的描述文字,后期修改
    }
}

- (NSMutableArray *)bankArray {
    if (!_bankArray) {
        _bankArray = [[NSMutableArray alloc] init];
    }
    
    return _bankArray;
}

//是否同意
- (void)gesture_Protocol_onClicked:(UITapGestureRecognizer*)sender {
    [self setIsAgree:!self.isAgree];
    [self.protocolImageView setImage:self.isAgree?_imgChk:_imgUnChk];
    
    if (self.isAgree) {
        [self.bankDescLabel setTextColor:[UIColor blackColor]];
    }
}

// 收或者展开列表
- (void)gesture_UpOrDown_onClicked:(UITapGestureRecognizer*)sender {
    if (self.bankNumber == 1) {
        [self setBankNumber:(int)self.bankArray.count+1];
        [self.upOrDownImageView setImage:[UIImage imageNamed:@"icon_drop_up"]];
    } else {
        [self setBankNumber:1];
        [self.upOrDownImageView setImage:[UIImage imageNamed:@"icon_drop_down"]];
    }
    
    NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:1];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
}


//提现类型点击
- (void)gesture_chked_onClicked:(UITapGestureRecognizer*)sender{
    UIImageView *img1 = [self.viewUnionPay.subviews objectAtIndex:0];
    UIImageView *img2 = [self.viewAlipyPay.subviews objectAtIndex:0];
    img1.image = img2.image = _imgUnChk;
    
    UIImageView *imgChk = [sender.view.subviews objectAtIndex:0];
    imgChk.image = _imgChk;
    
    _nType = (int)sender.view.tag;
}

//确认提交
- (void)btnConfirm_onClicked:(id)sender{
    _szRealName = self.txtRealName.text;
    _szAccount = self.txtAccount.text;
    if (_nType == -1) { // 未选择银行
        [DLLoading DLToolTipInWindow:@"请选择提佣金的方式"]; // 或支付宝账号
        return;
    }
    
    if (!self.isAgree) {
        if (self.bankNumber != 1) {
            [self setBankNumber:1];
            [self.upOrDownImageView setImage:[UIImage imageNamed:@"icon_drop_down"]];
            NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:1];
            [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
        }
        
        [self.bankDescLabel setTextColor:[UIColor redColor]];
        
        return;
    }
    
    if ([Utility isStringEmptyOrNull:_szRealName]) {
        [DLLoading DLToolTipInWindow:@"请输入您的姓名"];
        return;
    }
    if ([Utility isStringEmptyOrNull:_szAccount]) {
        [DLLoading DLToolTipInWindow:@"请输入支付宝账号或银行卡号"];
        return;
    }
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_submit) withObject:nil];
}

//查询初始化提现信息
- (void)thread_initData{
    CommissionShowModel *commissionShow = [[DataViewModel getInstance] commissionGetShow];
    if (commissionShow) {
        _nType = commissionShow.bank_type;
        [self getBankList];
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            if (commissionShow.type == 1) {
//                self.txtAccount.text = commissionShow.zfb_account;
//            }else if (commissionShow.type == 2) {//银联选中
//                UIImageView *img1 = [self.viewUnionPay.subviews objectAtIndex:0];
//                UIImageView *img2 = [self.viewAlipyPay.subviews objectAtIndex:0];
//                img1.image = img2.image = _imgUnChk;
//                img1.image = _imgChk;
//
//                self.txtAccount.text = commissionShow.bank_card;
//            }
            self.txtAccount.text = commissionShow.bank_card;
            self.txtRealName.text = commissionShow.realname;
        });
    }
}

//获取银行列表
- (void)getBankList {
    NSArray *array = [[DataViewModel getInstance] getBankList];
    if ([array count]) {
        for (BankModel *model in array) {
            [self.bankArray addObject:model];
        }
        
        [self setBankNumber:(int)self.bankArray.count+1];
        [self performSelectorOnMainThread:@selector(updateOnMainWithBankArray) withObject:nil waitUntilDone:NO];
    }
}

- (void)updateOnMainWithBankArray {
    if ([self.bankArray count]) {
        if (_nType != -1 && [self searchIndex] != -1) {
            [self setBankNumber:1];
            [self.upOrDownImageView setImage:[UIImage imageNamed:@"icon_drop_down"]];
            [self.commissionMethodLabel setText:[self searchBankName]];
            
            NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:1];
            [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

// 查询银行名字
- (NSString*)searchBankName {
    for (int i = 0; i < [self.bankArray count]; i ++) {
        BankModel *model = [self.bankArray objectAtIndex:i];
        if ([model.type intValue] == _nType) {
            return model.name;
        }
    }
    
    return @"";
}

// 查询索引
- (int)searchIndex {
    for (int i = 0; i < [self.bankArray count]; i ++) {
        BankModel *model = [self.bankArray objectAtIndex:i];
        if ([model.type intValue] == _nType) {
            return i + 1;
        }
    }
    
    return -1;
}

//提交
- (void)thread_submit{
    BOOL bRet = NO;
    if (self.propertyType == 1) {
        bRet = [[DataViewModel getInstance] withDraw:_nType withRealName:_szRealName withCardNo:_szAccount commission:self.can_get_commission];
    }else if(self.propertyType == 2){
        //申请退还保证n金
        bRet = [[DataViewModel getInstance] partnerRefundBond:_nType withRealName:_szRealName withCardNo:_szAccount];
    } else {
        bRet = [[DataViewModel getInstance] partnerPayInfo:_nType withRealName:_szRealName withCardNo:_szAccount];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        if (bRet) {
            if (self.propertyType == 1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMain" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                [DLLoading DLToolTipInWindow:@"提现成功"];
//                MyCorpsInfoViewController *myCorpsInfoViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MyCorpsInfoViewController class])];
//                [self.navigationController pushViewController:myCorpsInfoViewCtrl animated:YES];
            }else if(self.propertyType == 2){
                //退还保证金
                if (self.propertyBlockBackSuccess) {
                    self.propertyBlockBackSuccess();
                }
            } else if(self.propertyType == 3){
                //修改提现信息
                [DLLoading DLToolTipInWindow:@"修改提现信息成功"];
            }
            
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
    
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.propertyType == 2) {
        if (indexPath.section == 0) {
            return 0.001f;
        }
        
        if (indexPath.section == 2 && indexPath.row == 2) {
            return 80;
        }
    } else if (self.propertyType == 1) {
        if (indexPath.section == 0 && indexPath.row == 1) {
            return 0.001f;
        }
    } else if (self.propertyType == 3) {
        if (indexPath.section == 0 && indexPath.row == 0) {
            return 0.001f;
        }
    }

    if (indexPath.section == 1) {
        if (indexPath.row > 0) {
            return 44;
        } else {
            if (self.bankNumber == 1 && [self.commissionMethodLabel.text length]) {
                return 100;
            } else {
                return 35;
            }
        }
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.bankNumber;
    }
    
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row > 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UID"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UID"];
            [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        }
        
        if (self.bankNumber >= indexPath.row) {
            BankModel *model = [self.bankArray objectAtIndex:indexPath.row-1];
            [cell.textLabel setText:model.name];
        }
        
        return cell;
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

//cell的缩进级别，动态静态cell必须重写，否则会造成崩溃
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(1 == indexPath.section){// （动态cell）
        return [super tableView:tableView indentationLevelForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
    }
    return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row > 0) {
        [self setBankNumber:1];
        [self.upOrDownImageView setImage:[UIImage imageNamed:@"icon_drop_down"]];
        
        BankModel *model = [self.bankArray objectAtIndex:indexPath.row-1];
        [self.commissionMethodLabel setText:model.name];
        _nType = [model.type intValue];
        
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:indexPath.section];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
