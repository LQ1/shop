//
//  CouponViewController.m
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "CouponViewController.h"
#import "Include.h"
#import "CouponCell.h"

@interface CouponViewController ()

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarView.titleLabel.text = @"可赠优惠券";
    [self.tabView registerClass:[CouponCell class] forCellReuseIdentifier:NSStringFromClass([CouponCell class])];
    [Utility setExtraCellLineHidden:self.tabView];
    
    self.viewContainer.layer.cornerRadius = 6.0f;
    self.viewContainer.layer.masksToBounds = YES;
    
    _arrayDatas = [NSMutableArray new];
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_queryData) withObject:nil];
}

- (void)getData{
    
}

#pragma mark uitableview delegate
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 110;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayDatas.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CouponListModel *model = [_arrayDatas objectAtIndex:indexPath.row];
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CouponCell class])];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell loadData:model];
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CouponListModel *model = [_arrayDatas objectAtIndex:indexPath.row];
    model.isChecked = !model.isChecked;
    [self.tabView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (IBAction)btnCancel_onClicked:(id)sender {
    self.viewAlpha.hidden = YES;
}

- (IBAction)btnConfirm_onClicked:(id)sender {
    if (![Utility isPhoneNum:self.txtMobile.text]) {
        [DLLoading DLToolTipInWindow:@"请输入正确的手机号"];
        return;
    }
    
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_giveCoupon:) withObject:self.txtMobile.text];
}

//赠送
- (IBAction)btnGive_onClicked:(id)sender {
    _szIds = @"";
    for (CouponListModel *m in _arrayDatas) {
        if (m.isChecked) {
            _szIds = [_szIds stringByAppendingFormat:@"%d,",m.user_coupon_id];
        }
    }
    
    if (_szIds.length == 0) {
        [DLLoading DLToolTipInWindow:@"请选择要赠送的优惠券"];
        return;
    }
    
    _szIds = [_szIds substringWithRange:NSMakeRange(0, _szIds.length-1)];
    self.viewAlpha.hidden = NO;
}

//查询数据
- (void)thread_queryData {
    NSMutableArray *arrayTmp = [[DataViewModel getInstance] partnerCouponList];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        
        if (arrayTmp) {
            [_arrayDatas addObjectsFromArray:arrayTmp];
            [self.tabView reloadData];
        }
    });
}

//赠送优惠券
- (void)thread_giveCoupon:(NSString*)szMobile{
    BOOL bRet = [[DataViewModel getInstance] partnerCouponGive:_szIds withMobile:szMobile];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        
        if (bRet) {
            [DLLoading DLToolTipInWindow:@"赠送成功"];
            //移除+刷新？？？
            [self.txtMobile resignFirstResponder];
            [self.viewAlpha setHidden:YES];
            [self removeAndReloadTableView];
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
}

- (void)removeAndReloadTableView {
    for (int i = 0; i < _arrayDatas.count; i++) {
        CouponListModel *m = [_arrayDatas objectAtIndex:i];
        if (m.isChecked) {
            [_arrayDatas removeObject:m];
            i --;
        }
    }
    
    [self.tabView reloadData];
}

@end
