//
//  DataViewModel.h
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "BaseViewModel1.h"
#import "EntityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataViewModel : BaseViewModel1

+ (DataViewModel*)getInstance;

//合伙人页面
- (PartnerPage1*)partnerIndex;

//注册页面问题
- (NSMutableArray*)partnerQuestion;

//合伙人注册
- (int)partnerReg:(NSString*)refereeId withRealName:(NSString*)realName withIdCard:(NSString*)idCard withQuestions:(NSArray*)arrayQuestions;

//合伙人合同及确认支付
- (PartnerCompactModel*)partnerCompact:(int)nPartnerOrderId;

//合伙人 我的
- (PartnerMyPageModel*)partnerMy;


//合伙人保证金支付成功后获取信息
- (PartnerInfoModel*)partnerInfo;

//合伙人支付成功提佣金方式
- (BOOL)partnerCommissionType:(int)nType withCardNo:(NSString*)szCardNo withReturnType:(int)nRetType withYear:(int)nYear;

//银行接口
- (NSMutableArray*)getBankList;

//订货卡列表（储值卡列表）
- (NSMutableArray*)storageCardList:(int)nPage;

//订货卡详情（储值卡详情）
- (StorageCardModel*)storageCardDetail:(int)nStoreCardId;

//购买储值卡
- (StorageCardPayModel*)storeCardBuy:(int)nStoreCardId;

//合伙人滚动区域通知
- (NSMutableArray*)partnerScrollNotice;

//我要赚钱
- (MakeMoneyModel*)makeMoney:(int)nPageNum;

//合伙人二维码
- (NSString*)partnerQRCode:(int)nType withGoodsId:(NSString*)szGoodsId;

//我要推荐
- (MyRecommendInfoModel*)myRecommend;

//结算中心
- (SettlementCenterModel*)settlementCenter;

// 提现
- (BOOL)withDraw:(int)nType withRealName:(NSString*)szRealName withCardNo:(NSString*)szCardNo commission:(CGFloat)get_commission;

//提现信息  提佣金方式
- (BOOL)partnerPayInfo:(int)nType withRealName:(NSString*)szRealName withCardNo:(NSString*)szCardNo;

//申请退还保证金
- (BOOL)partnerRefundBond:(int)nType withRealName:(NSString*)szRealName withCardNo:(NSString*)szCardNo;

//我要续约
- (NSString*)partnerRenewContract;

//q佣金记录
- (NSMutableArray*)commissionRecord:(int)nPageNum;

//佣金提现记录
- (NSMutableArray*)commissionGetRecord:(int)nPageNum;

//保证金
- (BondModel*)partnerBond;

//学习天地
- (NSMutableArray*)studyCenter:(int)page;

//佣金提现的弹窗
- (CommissionPopupModel*)commissionPopup;

//优惠券列表
- (NSMutableArray*)partnerCouponList;

//赠送优惠券
- (BOOL)partnerCouponGive:(NSString*)szIds withMobile:(NSString*)szMobile;

//合伙人级别
- (PartnerLevelModel*)partnerLevel;

//客服列表
- (CustomInfoModel*)customerList;

//佣金提现页面（提现内容/添加没有支付信息,返回空值
- (CommissionShowModel*)commissionGetShow;

//检查合伙人是否允许退保证金
- (BOOL)partnerChkRefund;

//分享APP
-(ShareAppModel*)htmlShareInfo;

//微信支付参数
- (WxPayModel*)payByWx:(int)nOrderId withOrderType:(int)nOrderType;

//支付宝支付
- (NSString*)payByAlipy:(int)nOrderId withOrderType:(int)nOrderType;

//银联支付
- (NSString*)payByUnion:(int)nOrderId withOrderType:(int)nOrderType;

//合伙人协议
- (PartnerCompactProtocolModel*)getParterCompactProtocol;

//线下支付
- (NSDictionary*)offlinePayments:(int)nOrderId;

@end

NS_ASSUME_NONNULL_END
