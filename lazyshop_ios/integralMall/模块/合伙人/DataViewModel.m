//
//  DataViewModel.m
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "DataViewModel.h"
#import "ImageLoadingUtils.h"

#define RSURL(szMethod) [NSString stringWithFormat:@"ios/v2.0.0/%@",(szMethod)]

static DataViewModel *_this;

@implementation DataViewModel

+ (DataViewModel*)getInstance{
    if (!_this) {
        _this = [DataViewModel new];
    }
    return _this;
}

//合伙人介绍
- (PartnerPage1*)partnerIndex{
    NSString *szTag = @"partnerIndex";
    PartnerPage1 *pp1 = nil;
    [self initArrayParams:szTag];
    NSString *s = RSURL(@"partner/index");
    if ([self getDataFromService_GET:szTag withPage:s]) {
        pp1 = [PartnerPage1 new];
        [EntityJson JsonToEntity:[self getJsonByResultObject] withEntity:pp1];
    }
    return pp1;
}

//注册页面问题
- (NSMutableArray*)partnerQuestion{
    NSString *szTag = @"partnerQuestion";
    NSMutableArray *arrayDatas = nil;
    [self initArrayParams:szTag];
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"partner/question")]) {
        arrayDatas = [NSMutableArray new];
        NSArray *jArray = [self getJsonArrayByResultObject];
        for (int i=0; i<jArray.count; i++) {
            JoinPartnerQuestion *jpq = [JoinPartnerQuestion new];
            [EntityJson JsonToEntity:[jArray objectAtIndex:i] withEntity:jpq];
            jpq.question_no = i+1;
            [arrayDatas addObject:jpq];
        }
    }
    return arrayDatas;
}

//合伙人注册
- (int)partnerReg:(NSString*)refereeId withRealName:(NSString*)realName withIdCard:(NSString*)idCard withQuestions:(NSArray*)arrayQuestions{
    int nOrderId = 0;
    NSString *szTag = @"partnerReg";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"referee_id" withStringValue:refereeId];
    [self addParams:szTag withKey:@"realname" withStringValue:realName];
    [self addParams:szTag withKey:@"id_card" withStringValue:idCard];
    NSString *szJsonQuestion = @"[";
    for (JoinPartnerQuestion *qst in arrayQuestions) {
        szJsonQuestion = [szJsonQuestion stringByAppendingFormat:@"{\"question_id\":%d,\"option_id\":%d},",qst.question_id,qst.option_id];
    }
    NSRange range = {0,szJsonQuestion.length-1};
    szJsonQuestion = [szJsonQuestion substringWithRange:range];
    szJsonQuestion = [szJsonQuestion stringByAppendingString:@"]"];
    
    [self addParams:szTag withKey:@"question_ids" withStringValue:szJsonQuestion];
    if ([self getDataFromService:szTag withPage:RSURL(@"partner/register")]) {
        NSDictionary *dctValue = [self getJsonByResultObject];
        nOrderId = [[dctValue objectForKey:@"partner_order_id"] intValue];
    }
    return nOrderId;
}


//合伙人合同及确认支付
- (PartnerCompactModel*)partnerCompact:(int)nPartnerOrderId{
    PartnerCompactModel *partnerComp = nil;
    NSString *szTag = @"partnerCompact";
    [self initArrayParams:szTag];
    //self addParams:szTag withKey:@"token" withStringValue:<#(NSString *)#>
    [self addParams:szTag withKey:@"partner_order_id" withIntValue:nPartnerOrderId];
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"partner/contract")]) {
        partnerComp = [PartnerCompactModel new];
        [EntityJson JsonToEntity:[self getJsonByResultObject] withEntity:partnerComp];
    }
    return partnerComp;
}

//合伙人 我的
- (PartnerMyPageModel*)partnerMy{
    NSString *szTag = @"PartnerMyPageModel";
    [self initArrayParams:szTag];
    PartnerMyPageModel *pmpm = nil;
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"partner/my")]) {
        pmpm = [PartnerMyPageModel new];
        NSDictionary *dctValue = [self getJsonByResultObject];
        [EntityJson JsonToEntity:dctValue withEntity:pmpm];
        pmpm.footer_banner = [NSMutableArray new];
        pmpm.card_banner = [NSMutableArray new];
        
        NSArray *arrayFooterBanner = [dctValue objectForKey:@"footer_banner"];
        if (arrayFooterBanner && [arrayFooterBanner isKindOfClass:[NSArray class]]) {
            for (int i=0; i<arrayFooterBanner.count; i++) {
                NSDictionary *dctFooterBanner = [arrayFooterBanner objectAtIndex:i];
                PartnerMyPageFooterModel *footModel = [PartnerMyPageFooterModel new];
                [EntityJson JsonToEntity:dctFooterBanner withEntity:footModel];
                
                if ([dctFooterBanner objectForKey:@"link"]) {
                    footModel.link = [LinkModel new];
                    [EntityJson JsonToEntity:[dctFooterBanner objectForKey:@"link"] withEntity:footModel.link];
                }
                [pmpm.footer_banner addObject:footModel];
            }
            
        }
        
        NSArray *arrayCardBanner = [dctValue objectForKey:@"card_banner"];
        if (arrayCardBanner && [arrayCardBanner isKindOfClass:[NSArray class]]) {
            for (int i=0; i<arrayCardBanner.count; i++) {
                NSDictionary *dctCardBanner = [arrayCardBanner objectAtIndex:i];
                PartnerMyPageFooterModel *cardModel = [PartnerMyPageFooterModel new];
                [EntityJson JsonToEntity:dctCardBanner withEntity:cardModel];
                
                if ([dctCardBanner objectForKey:@"link"]) {
                    cardModel.link = [LinkModel new];
                    [EntityJson JsonToEntity:[dctCardBanner objectForKey:@"link"] withEntity:cardModel.link];
                }
                [pmpm.card_banner addObject:cardModel];
            }
            
        }
    }
    return pmpm;
}

//合伙人保证金支付成功后获取信息
- (PartnerInfoModel*)partnerInfo{
    PartnerInfoModel *pim = nil;
    NSString *szTag = @"partnerInfo";
    [self initArrayParams:szTag];
    NSLog(@"**********************************支付成功,获取成功信息 %@",[dictParams objectForKey:szTag]);
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"partner/get/info")]) {
        pim = [PartnerInfoModel new];
        [EntityJson JsonToEntity:[self getJsonByResultObject] withEntity:pim];
    }
    return pim;
}

//合伙人支付成功提佣金方式
- (BOOL)partnerCommissionType:(int)nType withCardNo:(NSString*)szCardNo withReturnType:(int)nRetType withYear:(int)nYear{
    NSString *szTag = @"partnerCommissionType";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"bank_type" withIntValue:nType];
    [self addParams:szTag withKey:@"bank_card" withStringValue:szCardNo];
    [self addParams:szTag withKey:@"return_type" withIntValue:nRetType];
    [self addParams:szTag withKey:@"contract_year" withIntValue:nYear];
    return [self getDataFromService:szTag withPage:RSURL(@"partner/commission/type")];
}

//合伙人银行接口
- (NSMutableArray*)getBankList {
    NSMutableArray *arrayDatas = nil;
    NSString *szTag = @"bankList";
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"html/banklist")]) {
        NSArray *array = [self getJsonArrayByResultObject];
        arrayDatas = [NSMutableArray new];
        for (int i=0; i<array.count; i++) {
            BankModel *bankModel = [BankModel new];
            [EntityJson JsonToEntity:[array objectAtIndex:i] withEntity:bankModel];
            [arrayDatas addObject:bankModel];
        }
    }
    
    return arrayDatas;
}

////订货卡列表（储值卡列表）
- (NSMutableArray*)storageCardList:(int)nPage{
    NSMutableArray *arrayDatas = nil;
    NSString *szTag = @"storageCardList";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"page" withIntValue:nPage];
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"storecard/list")]) {
        NSDictionary *dctValue = [self getJsonByResultObject];
        if ([dctValue objectForKey:@"store_card"]) {
            arrayDatas = [NSMutableArray new];
            NSArray *jArray = [dctValue objectForKey:@"store_card"];
            for (int i=0; i<jArray.count; i++) {
                StorageCardModel *scm = [StorageCardModel new];
                [EntityJson JsonToEntity:[jArray objectAtIndex:i] withEntity:scm];
                [arrayDatas addObject:scm];
            }
        }
    }
    return arrayDatas;
}

//订货卡详情（储值卡详情）
- (StorageCardModel*)storageCardDetail:(int)nStoreCardId{
    StorageCardModel *model = nil;
    
    NSString *szTag = @"storageCardDetail";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"store_card_id" withIntValue:nStoreCardId];
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"storecard/detail")]) {
        model = [StorageCardModel new];
        
        NSDictionary *dctValue = [self getJsonByResultObject];
        [EntityJson JsonToEntity:dctValue withEntity:model];
    }
    return model;
}

//购买储值卡
- (StorageCardPayModel*)storeCardBuy:(int)nStoreCardId{
    StorageCardPayModel *model = nil;
    NSString *szTag = @"storeCardBuy";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"store_card_id" withIntValue:nStoreCardId];
    if ([self getDataFromService:szTag withPage:RSURL(@"storecard/buy")]) {
        NSDictionary *dctValue = [self getJsonByResultObject];
        model = [StorageCardPayModel new];
        [EntityJson JsonToEntity:dctValue withEntity:model];
    }
    return model;
}

//合伙人滚动区域通知
- (NSMutableArray*)partnerScrollNotice{
    NSString *szTag = @"partnerScrollNotice";
    [self initArrayParams:szTag];
    NSMutableArray *arrayDatas = nil;
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"partner/scoll/notice")]) {
        arrayDatas = [NSMutableArray new];
        NSArray *jArray = [self getJsonArrayByResultObject];
        for (int i=0; i<jArray.count; i++) {
            PartnerScrollModel *psm = [PartnerScrollModel new];
            [EntityJson JsonToEntity:[jArray objectAtIndex:i] withEntity:psm];
            [arrayDatas addObject:psm];
        }
    }
    return arrayDatas;
}

//我要赚钱
- (MakeMoneyModel*)makeMoney:(int)nPageNum{
    NSString *szTag = @"makeMoney";
    MakeMoneyModel *model = nil;
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"page" withIntValue:nPageNum];
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"partner/makemoney")]) {
        model = [MakeMoneyModel new];
        NSDictionary *dctValue = [self getJsonByResultObject];
        [EntityJson JsonToEntity:dctValue withEntity:model];
        
        if ([dctValue objectForKey:@"recommend"]) {
            model.recommend = [NSMutableArray new];
            NSArray *jArray = [dctValue objectForKey:@"recommend"];
            for (int i=0; i<jArray.count; i++) {
                MakeMoneyBuyInfoModel *mmbi = [MakeMoneyBuyInfoModel new];
                [EntityJson JsonToEntity:[jArray objectAtIndex:i] withEntity:mmbi];
                [model.recommend addObject:mmbi];
            }
        }
    }
    
    return model;
}

//我要推荐
- (MyRecommendInfoModel*)myRecommend{
    NSString *szTag = @"myRecommend";
    [self initArrayParams:szTag];
    MyRecommendInfoModel *mrim = nil;
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"partner/recommend")]) {
        mrim = [MyRecommendInfoModel new];
        NSDictionary *dctValue = [self getJsonByResultObject];
        [EntityJson JsonToEntity:dctValue withEntity:mrim];
        
        mrim.team_first = [NSMutableArray new];
        NSArray *arrayTeamFirst = [dctValue objectForKey:@"team_first"];
        for (int i=0; i<arrayTeamFirst.count; i++) {
            RecommendInfoModel *rim = [RecommendInfoModel new];
            [EntityJson JsonToEntity:[arrayTeamFirst objectAtIndex:i] withEntity:rim];
            [mrim.team_first addObject:rim];
        }
        
        mrim.team_second = [NSMutableArray new];
        NSArray *arrayTeamSecond = [dctValue objectForKey:@"team_second"];
        for (int i=0; i<arrayTeamSecond.count; i++) {
            RecommendInfoModel *rim = [RecommendInfoModel new];
            [EntityJson JsonToEntity:[arrayTeamSecond objectAtIndex:i] withEntity:rim];
            [mrim.team_second addObject:rim];
        }
        
    }
    return mrim;
}

//结算中心
- (SettlementCenterModel*)settlementCenter{
    NSString *szTag = @"settlementCenter";
    [self initArrayParams:szTag];
    SettlementCenterModel *scm = nil;
    if ([self getDataFromService:szTag withPage:RSURL(@"partner/settlement/center")]) {
        scm = [SettlementCenterModel new];
        [EntityJson JsonToEntity:[self getJsonByResultObject] withEntity:scm];
    }
    return scm;
}


//合伙人二维码
//1合伙人二维码(我要挣钱) 2app下载二维码(一键推荐)  3推荐单品
- (NSString*)partnerQRCode:(int)nType withGoodsId:(NSString*)szGoodsId{
    NSString *szTag = @"partnerQRCode";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"type" withIntValue:nType];
    [self addParams:szTag withKey:@"goods_id" withStringValue:szGoodsId];
    //self addParams:szTag withKey:@"user_id" withIntValue:[Pu]
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"partner/qrcode")]) {
        NSDictionary *dctValue = [self getJsonByResultObject];
        return [dctValue objectForKey:@"qrcode_url"];
    }
    return @"";
}

//学习天地
- (NSMutableArray*)studyCenter:(int)page {
    NSString *szTag = @"studyCenter";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"page" withIntValue:page];
    NSMutableArray *arrayDatas = nil;
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"partner/study/center")]) {
        arrayDatas = [NSMutableArray new];
        NSArray *jArray = [self getJsonArrayByResultObject];
        for (int i=0; i<jArray.count; i++) {
            StudyModel *sm = [StudyModel new];
            [EntityJson JsonToEntity:[jArray objectAtIndex:i] withEntity:sm];
           // sm.videoImage = [ImageLoadingUtils getVideoPreViewImage:[NSURL URLWithString:sm.thumb]];
            [arrayDatas addObject:sm];
        }
    }
    return arrayDatas;
}

// 提现
- (BOOL)withDraw:(int)nType withRealName:(NSString*)szRealName withCardNo:(NSString*)szCardNo commission:(CGFloat)get_commission {
    NSString *szTag = @"withDraw";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"bank_type" withIntValue:nType];
    [self addParams:szTag withKey:@"realname" withStringValue:szRealName];
    [self addParams:szTag withKey:@"get_commission" withDoubleValue:get_commission];
    [self addParams:szTag withKey:@"bank_card" withStringValue:szCardNo];

    return [self getDataFromService:szTag withPage:RSURL(@"commission/get")];
}

//提现信息  提佣金方式
- (BOOL)partnerPayInfo:(int)nType withRealName:(NSString*)szRealName withCardNo:(NSString*)szCardNo {
    NSString *szTag = @"partnerPayInfo";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"bank_type" withIntValue:nType];
    [self addParams:szTag withKey:@"realname" withStringValue:szRealName];
    [self addParams:szTag withKey:@"bank_card" withStringValue:szCardNo];
    
    return [self getDataFromService:szTag withPage:RSURL(@"partner/pay/info")];
}

//申请退还保证金
- (BOOL)partnerRefundBond:(int)nType withRealName:(NSString*)szRealName withCardNo:(NSString*)szCardNo{
    NSString *szTag = @"partnerRefundBond";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"bank_type" withIntValue:nType];
    [self addParams:szTag withKey:@"realname" withStringValue:szRealName];
    [self addParams:szTag withKey:@"bank_card" withStringValue:szCardNo];
    
    return [self getDataFromService:szTag withPage:RSURL(@"partner/refund/bond")];
}

//我要续约
- (NSString*)partnerRenewContract{
    NSString *szTag = @"partnerRenewContract";
    [self initArrayParams:szTag];

    if([self getDataFromService:szTag withPage:RSURL(@"partner/renew/contract")]){
        return [self getSingleValueByResultObject];
    }
    return nil;
}

//q佣金记录
- (NSMutableArray*)commissionRecord:(int)nPageNum{
    NSString *szTag = @"commissionRecord";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"page" withIntValue:nPageNum];
    NSMutableArray *arrayDatas = nil;
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"commission/record")]) {
        arrayDatas = [NSMutableArray new];
        NSArray *jArray = [self getJsonArrayByResultObject];
        for (int i=0; i<jArray.count; i++) {
            CommissionRecordModel *model = [CommissionRecordModel new];
            [EntityJson JsonToEntity:[jArray objectAtIndex:i] withEntity:model];
            model.content = model.comm_type; //[model getCommTypeDesc];
            [arrayDatas addObject:model];
        }
    }
    return arrayDatas;
}

//提现记录
- (NSMutableArray*)commissionGetRecord:(int)nPageNum{
    NSString *szTag = @"commissionGetRecord";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"page" withIntValue:nPageNum];
    NSMutableArray *arrayDatas = nil;
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"commission/get/record")]) {
        arrayDatas = [NSMutableArray new];
        NSArray *jArray = [self getJsonArrayByResultObject];
        for (int i=0; i<jArray.count; i++) {
            CommissionRecordModel *model = [CommissionRecordModel new];
            NSDictionary *dctValue = [jArray objectAtIndex:i];
            model.commission = [[dctValue objectForKey:@"get_commission"] doubleValue];
            model.created_at = [dctValue objectForKey:@"get_at"];
            model.content = [dctValue objectForKey:@"comm_type"];
            
            [arrayDatas addObject:model];
        }
    }
    return arrayDatas;
}


//保证金
- (BondModel*)partnerBond{
    NSString *szTag = @"partnerBond";
    [self initArrayParams:szTag];
    BondModel *model = nil;
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"partner/bond")]) {
        model = [BondModel new];
        [EntityJson JsonToEntity:[self getJsonByResultObject] withEntity:model];
    }
    return model;
}

//佣金提现的弹窗信息
- (CommissionPopupModel*)commissionPopup{
    NSString *szTag = @"commissionPopup";
    [self initArrayParams:szTag];
    CommissionPopupModel *model = nil;
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"commission/get/popup")]) {
        model = [CommissionPopupModel new];
        [EntityJson JsonToEntity:[self getJsonByResultObject] withEntity:model];
    }
    return model;
}


//优惠券列表
- (NSMutableArray*)partnerCouponList{
    NSString *szTag = @"partnerCouponList";
    [self initArrayParams:szTag];
    NSMutableArray *arrayDatas = nil;
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"partner/coupon/list")]) {
        arrayDatas = [NSMutableArray new];
        [self getJsonByResultObject];
        NSArray *jArray = [self getJsonArray:@"data"];
        for (int i=0; i<jArray.count; i++) {
            CouponListModel *model = [CouponListModel new];
            [EntityJson JsonToEntity:[jArray objectAtIndex:i] withEntity:model];
            [arrayDatas addObject:model];
        }
    }
    
    return arrayDatas;
}

//赠送优惠券
- (BOOL)partnerCouponGive:(NSString*)szIds withMobile:(NSString*)szMobile{
    NSString *szTag = @"partnerCouponGive";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"user_coupon_id" withStringValue:szIds];
    [self addParams:szTag withKey:@"mobile" withStringValue:szMobile];
    
    return [self getDataFromService:szTag withPage:RSURL(@"partner/coupon/give")];
}

//合伙人级别
- (PartnerLevelModel*)partnerLevel{
    NSString *szTag = @"partnerLevel";
    [self initArrayParams:szTag];
    PartnerLevelModel *model = nil;
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"partner/level")]) {
        model = [PartnerLevelModel new];
        [EntityJson JsonToEntity:[self getJsonByResultObject] withEntity:model];
    }
    return model;
}

//客服列表
- (CustomInfoModel*)customerList{
    NSString *szTag = @"customerList";
    [self initArrayParams:szTag];
    CustomInfoModel *model = nil;
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"partner/customer/list")]) {
        model = [CustomInfoModel new];
        [EntityJson JsonToEntity:[self getJsonByResultObject] withEntity:model];
        
        model.service_list = [NSMutableArray new];
        NSArray *array = [[self getJsonByResultObject] objectForKey:@"service_list"];
        if ([array isKindOfClass:[NSArray class]]) {
            for (int i=0; i<array.count; i++) {
                CustomInfoListModel *custom = [CustomInfoListModel new];
                [EntityJson JsonToEntity:[array objectAtIndex:i] withEntity:custom];
                [model.service_list addObject:custom];
            }
        }
    }
    return model;
}

//检查合伙人是否允许退保证金
- (BOOL)partnerChkRefund{
    NSString *szTag = @"partnerChkRefund";
    [self initArrayParams:szTag];
    NSString *szMsg = nil;
    return ([self getDataFromService:szTag withPage:RSURL(@"partner/check/refund")]);
}

//佣金提现页面（提现内容/添加没有支付信息,返回空值
- (CommissionShowModel*)commissionGetShow{
    NSString *szTag = @"commissionGetShow";
    [self initArrayParams:szTag];
    CommissionShowModel *model = nil;
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"commission/get/show")]) {
        model = [CommissionShowModel new];
        [EntityJson JsonToEntity:[self getJsonByResultObject] withEntity:model];
    }
    return model;
}

//分享
-(ShareAppModel*)htmlShareInfo{
    NSString *szTag = @"htmlShareInfo";
    [self initArrayParams:szTag];
    ShareAppModel *model = nil;
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"html/shareinfo")]) {
        model = [ShareAppModel new];
        [EntityJson JsonToEntity:[self getJsonByResultObject] withEntity:model];
        model.description1 = [[self getJsonByResultObject] objectForKey:@"description"];
    }
    return model;
}

//微信支付参数
//nOrderType 订单类型 1保证金订单 2储值卡订单
- (WxPayModel*)payByWx:(int)nOrderId withOrderType:(int)nOrderType{
    NSString *szTag = @"payByWx";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"partner_order_id" withIntValue:nOrderId];
    [self addParams:szTag withKey:@"partner_order_type" withIntValue:nOrderType];
    WxPayModel *wxPay = nil;
    if ([self getDataFromService:szTag withPage:RSURL(@"partner/pay/wxpay/orderstring")]) {
        wxPay = [WxPayModel new];
        [EntityJson JsonToEntity:[self getJsonByResultObject] withEntity:wxPay];
    }
    return wxPay;
}

//支付宝支付
- (NSString*)payByAlipy:(int)nOrderId withOrderType:(int)nOrderType{
    NSString *szTag = @"payByAlipy";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"partner_order_id" withIntValue:nOrderId];
    [self addParams:szTag withKey:@"partner_order_type" withIntValue:nOrderType];
    if ([self getDataFromService:szTag withPage:RSURL(@"partner/pay/alipay/orderstring")]) {
        NSDictionary *dctValue = [self getJsonByResultObject];
        return [dctValue objectForKey:@"partner_order_string"];
    }
    return @"";
}

//银联支付
- (NSString*)payByUnion:(int)nOrderId withOrderType:(int)nOrderType{
    NSString *szTag = @"payByUnion";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"partner_order_id" withIntValue:nOrderId];
    [self addParams:szTag withKey:@"partner_order_type" withIntValue:nOrderType];
    if ([self getDataFromService:szTag withPage:RSURL(@"partner/pay/unionpay/orderstring")]) {
        NSDictionary *dctValue = [self getJsonByResultObject];
        return [dctValue objectForKey:@"tn"];
    }
    return @"";
}

//合伙人联盟合作协议书
- (PartnerCompactProtocolModel*)getParterCompactProtocol{
    NSString *szTag = @"parterCompactProtocol";
    [self initArrayParams:szTag];
    PartnerCompactProtocolModel *model = nil;
    if ([self getDataFromService_GET:szTag withPage:RSURL(@"partner/agreement")]) {
        model = [PartnerCompactProtocolModel new];
        [EntityJson JsonToEntity:[self getJsonByResultObject] withEntity:model];
        NSRange styleRange = [model.content rangeOfString:@"<style"];
        if (styleRange.location == NSNotFound) {
            NSString *styleStr = @" <style type=\"text/css\"> img{ width: 100%; height: auto; display: block; } </style> ";
            model.content = [styleStr stringByAppendingString:model.content];
        }
    }
    return model;
}

//线下支付
- (NSDictionary*)offlinePayments:(int)nOrderId {
    NSString *szTag = @"offlinePayment";
    [self initArrayParams:szTag];
    [self addParams:szTag withKey:@"partner_order_id" withIntValue:nOrderId];
    if ([self getDataFromService:szTag withPage:RSURL(@"partner/pay/offline")]) {
        return [self getJsonByResultObject];
    }
    return @{};
}


@end


