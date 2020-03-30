//
//  BalanceCenterTableViewController.m
//  integralMall
//
//  Created by liu on 2018/10/13.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "BalanceCenterTableViewController.h"
#import "DataViewModel.h"
#import "ImageLoadingUtils.h"
#import "CashWithdrawViewController.h"
#import "WithdrawInfoViewController.h"
#import "BailViewController.h"

@interface BalanceCenterTableViewController ()

@end

@implementation BalanceCenterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self initControl];
}

- (void)viewDidAppear:(BOOL)animated{
    [_viewScrollArea startAnimationNotice];
}

- (void)initControl{
    self.viewHeaderCorner.layer.cornerRadius = 8;
    self.viewHeaderCorner.layer.masksToBounds = YES;
    
    self.imgAvatar.layer.cornerRadius = self.imgAvatar.frame.size.width*0.5f;
    self.imgAvatar.layer.masksToBounds = YES;
    
    self.imgTeamLogo.layer.cornerRadius = self.imgTeamLogo.frame.size.width*0.5f;
    self.imgTeamLogo.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *gestureWithdraw = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_menu_onClicked:)];
    self.viewWithdraw.userInteractionEnabled = YES;
    [self.viewWithdraw addGestureRecognizer:gestureWithdraw];
    
    UITapGestureRecognizer *gestureCommission = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_menu_onClicked:)];
    self.viewCommission.userInteractionEnabled = YES;
    [self.viewCommission addGestureRecognizer:gestureCommission];
    
    UITapGestureRecognizer *gesturePayInfo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_menu_onClicked:)];
    self.viewPayInfo.userInteractionEnabled = YES;
    [self.viewPayInfo addGestureRecognizer:gesturePayInfo];
    
    UITapGestureRecognizer *gestureBail = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_menu_onClicked:)];
    self.viewBail.userInteractionEnabled = YES;
    [self.viewBail addGestureRecognizer:gestureBail];
    
    UITapGestureRecognizer *gestureCash = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_cash_onClicked:)];
    self.viewCash.userInteractionEnabled = YES;
    [self.viewCash addGestureRecognizer:gestureCash];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(thread_query) name:@"reloadMain" object:nil];
    
    [self initData];
}

- (void)initData{
    self.viewPartner.layer.cornerRadius = 6.0f;
    _viewScrollArea = [[ViewPartnerScrollArea alloc] initWithParentView:self.viewPartner];
    
    [self performSelectorInBackground:@selector(thread_query) withObject:nil];
}

//佣金提现
- (void)gesture_cash_onClicked:(id)sender{
    
    if (self.propertyCommissionCashBlock) {
        self.propertyCommissionCashBlock(_settlementCenter);
    }
}

//菜单点击
- (void)gesture_menu_onClicked:(UITapGestureRecognizer*)sender{
    switch (sender.view.tag) {
        case 1:
        case 2:
        {
            CashWithdrawViewController *cashWithdrawViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([CashWithdrawViewController class])];
            cashWithdrawViewCtrl.propertyTag = (int)sender.view.tag;
            [self.navigationController pushViewController:cashWithdrawViewCtrl animated:YES];
        }
            break;
        case 3:
        {
            WithdrawInfoViewController *withdrawInfoViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([WithdrawInfoViewController class])];
            withdrawInfoViewCtrl.propertyType = 3;//支付信息
            [self.navigationController pushViewController:withdrawInfoViewCtrl animated:YES];
        }
            break;
        case 4:
        {
            BailViewController *bailViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([BailViewController class])];
            [self.navigationController pushViewController:bailViewCtrl animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KScreenHeight;
}

//更新界面
- (void)updateOnMain{
    [ImageLoadingUtils loadImage:self.imgAvatar withURL:_settlementCenter.partner_avatar];
    [ImageLoadingUtils loadImage:self.imgTeamLogo withURL:_settlementCenter.team_sign_thumb];
    self.lblNickName.text = _settlementCenter.realname;
    self.lblCropLevel.text = _settlementCenter.team_title;
    self.lblSaleCommission.text = [NSString stringWithFormat:@"%.2f",_settlementCenter.sale_commission];
    self.lblStoreSellGoods.text = [NSString stringWithFormat:@"%.2f",_settlementCenter.store_sell_goods];
    self.lblRecommend.text = [NSString stringWithFormat:@"%.2f",_settlementCenter.recommend_commission];
    
    [self.webView loadHTMLString:_settlementCenter.commission_desc baseURL:nil];
}

//查询
- (void)thread_query {
    _settlementCenter = [[DataViewModel getInstance] settlementCenter];
    if (_settlementCenter) {
        [self performSelectorOnMainThread:@selector(updateOnMain) withObject:nil waitUntilDone:NO];
    }
}

- (void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadMain" object:nil];
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
