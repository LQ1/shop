//
//  JoinPaySucTableViewController.m
//  integralMall
//
//  Created by liu on 2018/10/13.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "JoinPaySucTableViewController.h"
#import "MyCorpsInfoViewController.h"
#import "DataViewModel.h"
#import "Utility.h"

@interface JoinPaySucTableViewController ()

@property (strong, nonatomic) NSMutableArray *bankArray;
@property (assign, nonatomic) int bankNumber;
@property (assign, nonatomic) BOOL isAgree;

@end

@implementation JoinPaySucTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.layer.cornerRadius = 8;
    self.tableView.layer.masksToBounds = YES;
    [self setBankNumber:1];
    [self setIsAgree:NO];
    [self.commissionMethodLabel setText:@""];
    [Utility setExtraCellLineHidden:self.tableView];
    
    _imgChk = [UIImage imageNamed:@"已勾选_chked.png"];
    _imgUnChk = [UIImage imageNamed:@"未勾选.png"];
    
    _nType = -1;
    _nReturnType = 0;
    _nDealYear = 1;
    
//    UITapGestureRecognizer *gestureCommissionAlipy = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_commission_type_onClicked:)];
//    self.viewAlipy.userInteractionEnabled = YES;
//    [self.viewAlipy addGestureRecognizer:gestureCommissionAlipy];
//    UITapGestureRecognizer *gestureCommissionCard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_commission_type_onClicked:)];
//    self.viewCard.userInteractionEnabled = YES;
//    [self.viewCard addGestureRecognizer:gestureCommissionCard];
    
    UITapGestureRecognizer *gestureProtocol = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_Protocol_onClicked:)];
    self.protocolImageView.userInteractionEnabled = YES;
    [self.protocolImageView addGestureRecognizer:gestureProtocol];
    
    UITapGestureRecognizer *gestureUpOrDown = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_UpOrDown_onClicked:)];
    self.upOrDownImageView.userInteractionEnabled = YES;
    [self.upOrDownImageView addGestureRecognizer:gestureUpOrDown];
    
    UITapGestureRecognizer *gestureRewardSingle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_reward_type_onClicked:)];
    self.viewRewardBySingle.userInteractionEnabled = YES;
    [self.viewRewardBySingle addGestureRecognizer:gestureRewardSingle];
    UITapGestureRecognizer *gestureRewardGroup = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_reward_type_onClicked:)];
    self.viewRewardByGroup.userInteractionEnabled = YES;
    [self.viewRewardByGroup addGestureRecognizer:gestureRewardGroup];
    
    UITapGestureRecognizer *gestureYear1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_year_onClicked:)];
    self.viewYear1.userInteractionEnabled = YES;
    [self.viewYear1 addGestureRecognizer:gestureYear1];
    UITapGestureRecognizer *gestureYear2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_year_onClicked:)];
    self.viewYear2.userInteractionEnabled = YES;
    [self.viewYear2 addGestureRecognizer:gestureYear2];
    UITapGestureRecognizer *gestureYear3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_year_onClicked:)];
    self.viewYear3.userInteractionEnabled = YES;
    [self.viewYear3 addGestureRecognizer:gestureYear3];
    
    [self performSelectorInBackground:@selector(thread_queryInfo) withObject:nil];
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

//提佣金方式
- (void)gesture_commission_type_onClicked:(UITapGestureRecognizer*)sender {
    UIImageView *img1 = [self.viewAlipy.subviews objectAtIndex:0];
    UIImageView *img2 = [self.viewCard.subviews objectAtIndex:0];
    img1.image = img2.image = _imgUnChk;
    
    UIView *view = sender.view;
    UIImageView *imgView = [view.subviews objectAtIndex:0];
    imgView.image = _imgChk;
    
    _nType = (int)view.tag;
}

//奖励方式
- (void)gesture_reward_type_onClicked:(UITapGestureRecognizer*)sender{
    UIImageView *img1 = [self.viewRewardBySingle.subviews objectAtIndex:0];
    UIImageView *img2 = [self.viewRewardByGroup.subviews objectAtIndex:0];
    img1.image = img2.image = _imgUnChk;
    
    UIView *view = sender.view;
    UIImageView *imgView = [view.subviews objectAtIndex:0];
    imgView.image = _imgChk;
    
    _nReturnType = (int)view.tag;
    
    if (_nReturnType == 0) {
        //按单人
        self.txtDesc.text = [Utility getSafeString:_partnerInfoModel.reward_desc];
    } else {
        //按团队
        self.txtDesc.text = [Utility getSafeString:_partnerInfoModel.reward_desc_team];
    }
    
    [self.tableView reloadData];
}

//签约年份
- (void)gesture_year_onClicked:(UITapGestureRecognizer*)sender{
    UIImageView *img1 = [self.viewYear1.subviews objectAtIndex:0];
    UIImageView *img2 = [self.viewYear2.subviews objectAtIndex:0];
    UIImageView *img3 = [self.viewYear3.subviews objectAtIndex:0];
    img1.image = img2.image = img3.image = _imgUnChk;
    UIView *view = sender.view;
    UIImageView *imgView = [view.subviews objectAtIndex:0];
    imgView.image = _imgChk;
    
    _nDealYear = (int)view.tag;
}

//主线程更新
- (void)updateOnMain:(PartnerInfoModel*)partnerInfo {
    _partnerInfoModel = partnerInfo;
    self.lblName.text = [Utility getSafeString:partnerInfo.realname];
    self.lblPhoneNum.text = [NSString stringWithFormat:@"%ld",partnerInfo.mobile];
    [self.txtDesc setText:[Utility getSafeString:partnerInfo.reward_desc]];
    [self.tableView reloadData];
}

- (void)updateOnMainWithBankArray {
    [self.tableView reloadData];
}

//检查并且提交数据
- (void)btnChkAndSubmit{
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
    
    if ([Utility isStringEmptyOrNull:self.txtAccount.text]) {
        [DLLoading DLToolTipInWindow:@"请输入银行卡"]; // 或支付宝账号
        return;
    }
    
    _szAccount = self.txtAccount.text;
    
    [self.view DLLoadingInSelf];
    [self.bankDescLabel setTextColor:[UIColor blackColor]];
    [self performSelectorInBackground:@selector(thread_submit) withObject:nil];
}

//查询
- (void)thread_queryInfo{
    _pim = [[DataViewModel getInstance] partnerInfo];
    if (_pim) {
        [self performSelectorOnMainThread:@selector(updateOnMain:) withObject:_pim waitUntilDone:NO];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"1111111 %@",[DataViewModel getInstance].ERROR_MSG);
            //[DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
            [Utility showMessage:[DataViewModel getInstance].ERROR_MSG];
        });
    }
    
    [self getBankList];
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

//提交数据
- (void)thread_submit{
    if (_pim) {
        BOOL bRet = [[DataViewModel getInstance] partnerCommissionType:_nType withCardNo:_szAccount withReturnType:_nReturnType withYear:_nDealYear];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view DLLoadingHideInSelf];
            if (bRet) {
                MyCorpsInfoViewController *corpsViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MyCorpsInfoViewController class])];
                [self.navigationController pushViewController:corpsViewCtrl animated:YES];
            }else{
                [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
            }
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [Utility showMessage:@"请检查网络设置"];
        });
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.bankNumber;
    }
    
    return [super tableView:tableView numberOfRowsInSection:section];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 2) {
        return [self getAdaptiveRewardMethodHeight];
    } else if (indexPath.section == 1) {
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

#pragma mark - 描述自适应高度
- (CGFloat)getAdaptiveRewardMethodHeight {
    CGSize size = [self.txtDesc.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-92, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return size.height + 30;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

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
