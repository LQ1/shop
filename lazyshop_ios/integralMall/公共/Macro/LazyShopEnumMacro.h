//
//  LazyShopEnumMacro.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/3.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#ifndef LazyShopEnumMacro_h
#define LazyShopEnumMacro_h

// 商品类型
typedef NS_ENUM(NSInteger, GoodsDetailType)
{
    // 储值商品
    GoodsDetailType_Normal = 0,
    // 积分商品
    GoodsDetailType_Store,
    // 秒杀商品
    GoodsDetailType_SecKill,
    // 拼团商品
    GoodsDetailType_GroupBy,
    // 砍价商品
    GoodsDetailType_Bargain,
    //合伙人
    GoodsPartnerType_Join,
};

// 订单状态
typedef NS_ENUM(NSInteger, OrderStatus)
{
    // 待支付
    OrderStatus_ToPay = 0,
    // 待发货
    OrderStatus_NotSend,
    // 待收货
    OrderStatus_ToReceive,
    // 待成团
    OrderStatus_ToBecameGroup,
    // 已完成
    OrderStatus_Complete,
    // 已取消
    OrderStatus_Cancel,
    // 拼团失败-待退款
    OrderStatus_ToGroupRefound,
    // 已退款
    OrderStatus_HaveRefounded,
    // 拼团失败-已退款
    OrderStatus_GroupHaveRefounded,
    // 拼团订单-已完成
    OrderStatus_GroupComplete,
    // 等待商家线下收款
    OrderStatus_WaitStorePay,
    // 全部
    OrderStatus_All,
    // 退款维权
    OrderStatus_Refound,
    // 待评价
    OrderStatus_ToComment
};

// 订单类型
typedef NS_ENUM(NSInteger, OrderType)
{
    // 积分订单
    OrderType_Score = 1,
    // 普通订单
    OrderType_Normal,
    // 秒杀订单
    OrderType_SecKill,
    // 拼团订单
    OrderType_Group,
    // 砍价订单
    OrderType_Bargain
};

// 支付方式
typedef NS_ENUM(NSInteger,PayMentType)
{
    PayMentType_WXPay = 0,
    PayMentType_AliPay,
    PayMentType_UnionPay,
    PayMentType_ShopPay,
    PayMentType_Score
};

// 消息类型
typedef NS_ENUM(NSInteger,MessageType)
{
    MessageType_System = 0,
    MessageType_Coupon,
    MessageType_Score,
    MessageType_Order
};

#endif /* LazyShopEnumMacro_h */
