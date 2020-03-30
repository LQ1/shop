//
//  MyCorpsInfoTableViewController.m
//  integralMall
//
//  Created by liu on 2018/10/13.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "MyCorpsInfoTableViewController.h"
#import "MakeMoneyViewController.h"
#import "MyRecommendViewController.h"
#import "StudyViewController.h"
#import "BalanceCenterViewController.h"
#import "PrePaidBuyViewController.h"
#import "DataViewModel.h"
#import "Utility.h"
#import "ImageLoadingUtils.h"
#import "UIColor+YYAdd.h"
#import "CorpsLevelViewController.h"
#import "SimpleImgCell.h"
#import "PublicEventManager.h"
#import "HomeLinkModel.h"
#import "QRCodeView.h"
#import "WebViewController.h"
#import "PersonalMessageViewController.h"
#import "StorageBuyViewController.h"

@interface MyCorpsInfoTableViewController ()

@end

@implementation MyCorpsInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self initControl];
}

- (void)viewDidAppear:(BOOL)animated{
    if (_viewScrollArea) {
        [_viewScrollArea startAnimationNotice];
    }
    
    if (!_isFirstLoad) {
        //这里要重复查询 ，因为有些数据t需要重新初始化
        [self performSelectorInBackground:@selector(thread_queryCorps) withObject:nil];
    }
    _isFirstLoad = NO;
}

- (void)initControl{
    [Utility setExtraCellLineHidden:self.tableView];
    
    self.btnEmBuy.layer.cornerRadius = 12.0f;
    self.btnEmBuy.layer.masksToBounds = YES;
    
    self.viewHeader.layer.cornerRadius = 6;
    self.viewHeader.layer.masksToBounds = YES;
    
    self.viewMenu.layer.cornerRadius = 6;
    self.viewMenu.layer.masksToBounds = YES;
    
    self.viewPartner.layer.cornerRadius = 6;
    self.viewPartner.layer.masksToBounds = YES;
    
    self.imgAvatar.layer.cornerRadius = self.imgAvatar.frame.size.width*0.5;
    self.imgAvatar.layer.masksToBounds = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SimpleImgCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SimpleImgCell class])];
    
    UITapGestureRecognizer *gesture_corpLevel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_corpLevel_onClicked:)];
    self.viewCropLevel.userInteractionEnabled = YES;
    [self.viewCropLevel addGestureRecognizer:gesture_corpLevel];
    
    UITapGestureRecognizer *gesture_avatar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_avatar_onClicked:)];
    self.imgAvatar.userInteractionEnabled = YES;
    [self.imgAvatar addGestureRecognizer:gesture_avatar];
    
    UITapGestureRecognizer *gesture_share = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_share_onClicked:)];
    self.imgShareApp.userInteractionEnabled = YES;
    [self.imgShareApp addGestureRecognizer:gesture_share];
    
    UITapGestureRecognizer *gesture_makeMoney = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_makeMoney_onClicked:)];
    self.viewMakeMoney.userInteractionEnabled = YES;
    [self.viewMakeMoney addGestureRecognizer:gesture_makeMoney];
    
    UITapGestureRecognizer *gesture_recommend = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_recommend_onClicked:)];
    self.viewRecommend.userInteractionEnabled = YES;
    [self.viewRecommend addGestureRecognizer:gesture_recommend];
    
    UITapGestureRecognizer *gesture_balanceCenter = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_balanceCenter_onClicked:)];
    self.viewBalanceCenter.userInteractionEnabled = YES;
    [self.viewBalanceCenter addGestureRecognizer:gesture_balanceCenter];
    
    UITapGestureRecognizer *gesture_study = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_study_onClicked:)];
    self.viewStudy.userInteractionEnabled = YES;
    [self.viewStudy addGestureRecognizer:gesture_study];
    
    UITapGestureRecognizer *gesture_storageCard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_storagecardbuy_onClicked:)];
    self.imgSCBuy.userInteractionEnabled = YES;
    [self.imgSCBuy addGestureRecognizer:gesture_storageCard];
    
    [self initData];
}

- (void)initData{
    _isFirstLoad = YES;
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(thread_queryCorps) name:@"reloadMain" object:nil];
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_queryCorps) withObject:nil];
    
    [self performSelectorInBackground:@selector(thread_queryPartnerScrollInfo) withObject:nil];
}

//h战队等级
- (void)gesture_corpLevel_onClicked:(id)sender{
    CorpsLevelViewController *corpsLevViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([CorpsLevelViewController class])];
    [self.navigationController pushViewController:corpsLevViewCtrl animated:YES];
}

//头像点击
- (void)gesture_avatar_onClicked:(id)sender{
    PersonalMessageViewController *personalViewCtrl = [PersonalMessageViewController new];
    [self.navigationController pushViewController:personalViewCtrl animated:YES];
}

//分享好友下载
- (void)gesture_share_onClicked:(id)sender{
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_shareApp) withObject:nil];
}

//我要赚钱
- (void)gesture_makeMoney_onClicked:(id)sender{
    MakeMoneyViewController *makeMoneyViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MakeMoneyViewController class])];
    [self.navigationController pushViewController:makeMoneyViewCtrl animated:YES];
}
//我要推荐
- (void)gesture_recommend_onClicked:(id)sender{
    MyRecommendViewController *myRecomViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MyRecommendViewController class])];
    [self.navigationController pushViewController:myRecomViewCtrl animated:YES];
}
//结算中心
- (void)gesture_balanceCenter_onClicked:(id)sender{
    BalanceCenterViewController *balanceViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([BalanceCenterViewController class])];
    [self.navigationController pushViewController:balanceViewCtrl animated:YES];
}
//学习天地
- (void)gesture_study_onClicked:(id)sender{
    StudyViewController *studyViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([StudyViewController class])];
    [self.navigationController pushViewController:studyViewCtrl animated:YES];
}

//立即购买
- (void)gesture_storagecardbuy_onClicked:(id)sender{
    PrePaidBuyViewController *prePaidBuyViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PrePaidBuyViewController class])];
    [self.navigationController pushViewController:prePaidBuyViewCtrl animated:YES];
}

//底u部商品w推荐
- (void)gesture_goods_detail_onClicked:(UITapGestureRecognizer*)sender{
    NSInteger nIndex = sender.view.tag;
    PartnerMyPageFooterModel *model = [_partnerMyPage.footer_banner objectAtIndex:nIndex];
    if([@"h5" isEqualToString:model.link.mode]) {
        NSString *szUrl = [model.link.options objectForKey:@"wz"];
        //跳转到H5页面
        WebViewController *webViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([WebViewController class])];
        webViewCtrl.propertyUrl = szUrl;
        [self.navigationController pushViewController:webViewCtrl animated:YES];
    } else {
        if ([@"card_index" isEqualToString:model.link.page]) {
            PrePaidBuyViewController *prePaidBuyViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PrePaidBuyViewController class])];
            [self.navigationController pushViewController:prePaidBuyViewCtrl animated:YES];
        } else if ([@"card_detail" isEqualToString:model.link.page]) {
            int store_card_id = [[model.link.options objectForKey:@"id"] intValue];
            
            StorageBuyViewController *storeBuyViewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([StorageBuyViewController class])];
            storeBuyViewCtrl.store_card_id = store_card_id;
            [self.navigationController pushViewController:storeBuyViewCtrl animated:YES];
        } else {
            int nGid = [[model.link.options objectForKey:@"id"] intValue];
            HomeLinkModel *homeLinkModel = [HomeLinkModel new];
            homeLinkModel.mode = model.link.mode;
            homeLinkModel.page = model.link.page;
            homeLinkModel.options = [HomeLinkNativeModel new];
            homeLinkModel.options.linkNativeID = [NSString stringWithFormat:@"%d",nGid];
            
            [PublicEventManager gotoNativeModuleWithLinkModel:homeLinkModel navigationController:self.navigationController];
        }
    }
}


//主线程更新
- (void)updateOnMain{
    [self.view DLLoadingHideInSelf];
    
    self.lblNickName.text = _partnerMyPage.realname;
    self.lblAmount.text = [NSString stringWithFormat:@"%.2f",_partnerMyPage.amount];
    self.lblTeamNum.text = [NSString stringWithFormat:@"%d人",_partnerMyPage.team_num];
    self.lblCommission.text = [NSString stringWithFormat:@"%.2f",_partnerMyPage.commission];
    self.lblBond.text = [NSString stringWithFormat:@"%.2f",_partnerMyPage.bond];
    [ImageLoadingUtils loadImage:self.imgAvatar withURL:_partnerMyPage.partner_avatar];
    //[ImageLoadingUtils loadImage:self.imgFootbanner withURL:_partnerMyPage.footer_banner.image];
    if (_isFirstLoad) {
        [self.tableView reloadData];
    }
}

//滚动区域
- (void)updatePartnerScrollInfo:(NSMutableArray*)arrayPartners{
    [GlobalSetting getThis].arrayPartnerScrollInfos = arrayPartners;
    
    //合伙人滚动区域
    self.viewPartner.layer.cornerRadius = 6.0f;
    _viewScrollArea = [[ViewPartnerScrollArea alloc] initWithParentView:self.viewPartner];
    
    [_viewScrollArea startAnimationNotice];
}

//查询数据
- (void)thread_queryCorps{
    _partnerMyPage = [[DataViewModel getInstance] partnerMy];
    
    [self performSelectorOnMainThread:@selector(updateOnMain) withObject:nil waitUntilDone:NO];
}

//查询合伙人滚动区域信息
- (void)thread_queryPartnerScrollInfo{
    NSMutableArray *arrayTmp = [[DataViewModel getInstance] partnerScrollNotice];
    if (arrayTmp) {        
        [self performSelectorOnMainThread:@selector(updatePartnerScrollInfo:) withObject:arrayTmp waitUntilDone:NO];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    return 230;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 1){
        return _partnerMyPage.card_banner.count;
    }else if(section == 2){
        return _partnerMyPage.footer_banner.count;
    }
    
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 0) {
        PartnerMyPageFooterModel *model = nil;
        BOOL btnVisible = NO;
        UITapGestureRecognizer *gesture_img = nil;
        if (indexPath.section == 1) {
            model = [_partnerMyPage.card_banner objectAtIndex:indexPath.row];
            btnVisible = YES;
            gesture_img = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_storagecardbuy_onClicked:)];
        }else{
            model = [_partnerMyPage.footer_banner objectAtIndex:indexPath.row];
            gesture_img = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_goods_detail_onClicked:)];
        }
        
        SimpleImgCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SimpleImgCell class])];
        
        [cell loadData:model withHasBtn:btnVisible];
        cell.imgBackground.userInteractionEnabled = YES;
        cell.imgBackground.tag = indexPath.row;
        [cell.imgBackground addGestureRecognizer:gesture_img];
        
        return cell;
    }

    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

//cell的缩进级别，动态静态cell必须重写，否则会造成崩溃
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section > 0){  // （动态cell）
        return [super tableView:tableView indentationLevelForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
    }
    return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}

- (void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadMain" object:nil];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 1) {
//        //购买储值卡
//        [self gesture_storagecardbuy_onClicked:nil];
//    }else{
//        //跳转到商品详情
//    }
//}


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


//一键推荐
- (void)thread_recomment{
    NSString *szQRCodeUrl = [[DataViewModel getInstance] partnerQRCode:2 withGoodsId:@""];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        
        if (![Utility isStringEmptyOrNull:szQRCodeUrl]) {
            NSArray *arrayViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([QRCodeView class]) owner:nil options:nil];
            QRCodeView *viewQRCode = [arrayViews objectAtIndex:0];
            [viewQRCode setFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
            [viewQRCode initEvent];
            [viewQRCode loadImage:szQRCodeUrl];
            
            CABasicAnimation *aniScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            aniScale.duration = 0.5f;
            aniScale.fromValue = [NSNumber numberWithFloat:0.1f];
            aniScale.toValue = [NSNumber numberWithFloat:1.0f];
            [viewQRCode.layer addAnimation:aniScale forKey:@"ANI_SCALE"];
            
            [self.view addSubview:viewQRCode];
            
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
}

//分享APP
- (void)thread_shareApp{
    ShareAppModel *shareApp = [[DataViewModel getInstance] htmlShareInfo];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        if (shareApp) {
            [PublicEventManager shareWithAlertTitle:@"分享" title:shareApp.title detailTitle:shareApp.description1 image:shareApp.image htmlString:shareApp.url];
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
    
}

@end
