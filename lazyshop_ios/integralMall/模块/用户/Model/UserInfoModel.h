//
//  UserInfoModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>
#import "PartnerModel.h"

typedef NS_ENUM(NSInteger,UserSexType)
{
    UserSexType_UnKnown = 0,
    UserSexType_Man,
    UserSexType_Woman
};

typedef NS_ENUM(NSInteger,UserVipLevel)
{
    UserVipLevel_Regis = 0,
    UserVipLevel_Tong,
    UserVipLevel_Yin,
    UserVipLevel_Jin,
    UserVipLevel_Zuan
};


@interface UserInfoModel : BaseModel

/*
 *  手机号
 */
@property (nonatomic,copy)NSString *mobilePhone;

/*
 *  token
 */
@property (nonatomic,copy)NSString *token;

/*
 *  最后登录时间
 */
@property (nonatomic, strong) NSDate *lastLoginTime;

/*
 *  是否设置了密码
 */
@property (nonatomic,assign)BOOL isInitPassword;

/***************  个人资料  ***************/

/*
 *  性别
 */
@property (nonatomic,assign)UserSexType sex;
/*
 *  出生日期
 */
@property (nonatomic,copy)NSString *birthDay;


/***************  账 户 信 息 以 外 字 段  ***************/

/*
 *  待支付订单数量
 */
@property (nonatomic,assign)NSInteger waitToPayOrdersNumber;
/*
 *  待收货订单数量
 */
@property (nonatomic,assign)NSInteger waitToSendOrdersNumber;
/*
 *  待评价订单数量
 */
@property (nonatomic,assign)NSInteger waitToRecommendOrdersNumber;
/*
 * 退款/维权订单数量
 */
@property (nonatomic,assign)NSInteger waitToRefoundOrdersNumber;

/*
 *  优惠券数量
 */
@property (nonatomic,assign)NSInteger couponTotalNumber;

/*
 * 我的拼团数量
 */
@property (nonatomic,assign)NSInteger myGroupByOrdersNumber;
/*
 * 我的砍价数量
 */
@property (nonatomic,assign)NSInteger myBargainOrdersNumber;

/*
 *  头像
 */
@property (nonatomic,copy)NSString *headImageUrl;
/*
 *  昵称
 */
@property (nonatomic,copy)NSString *nickName;

/*
 *  会员等级
 */
@property (nonatomic,assign)UserVipLevel vipLevel;
/*
 *  积分
 */
@property (nonatomic,assign)NSInteger integralTotalNumber;


//合伙人
@property (nonatomic)PartnerModel *partner;

/***************  方 法  ***************/
/*
 *  性别名称
 */
- (NSString *)sexName;
/*
 *  会员等级名称(可指定level)
 */
- (NSString *)vipLevelNameWithLevel:(UserVipLevel)level;
/*
 *  会员等级名称
 */
- (NSString *)vipLevelName;
/*
 *  会员等级图片
 */
- (NSString *)vipLevelImageName;

@end
