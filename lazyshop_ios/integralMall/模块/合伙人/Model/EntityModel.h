//
//  EntityModel.h
//  integralMall
//
//  Created by liu on 2018/10/11.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "EntityJson.h"
NS_ASSUME_NONNULL_BEGIN

@interface EntityModel : NSObject

@end

//合伙人第一个界面，简单信息
@interface PartnerPage1 : NSObject

@property(nonatomic,strong) NSString *title;

@property(nonatomic,strong) NSString *content;

@end


//***合伙人问题
@interface JoinPartnerQuestion : NSObject

@property(nonatomic) int question_no;

@property(nonatomic) int question_id;

@property(nonatomic,strong) NSString *question_title;

//选项
@property(nonatomic,strong) NSArray *options;
//选中的答案  每个问题选项id为1,2,3,4
@property(nonatomic) int option_id;

@end

//***合伙人合同
@interface PartnerCompactModel : NSObject

@property(nonatomic,strong) NSString *title;

@property(nonatomic,strong) NSString *content;

@property(nonatomic,strong) NSString *year;

@property(nonatomic,strong) NSString *month;

@property(nonatomic,strong) NSString *day;

@property(nonatomic) int partner_order_id;

@end


//***合伙人协议
@interface PartnerCompactProtocolModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

@end


//***合伙人我的页面--底部-link
@interface LinkModel : NSObject

@property(nonatomic,strong) NSString *mode;

@property(nonatomic,strong) NSString *page;

@property(nonatomic,strong) NSDictionary *options;//只有一个id项

@end

//***合伙人我的页面--底部
@interface PartnerMyPageFooterModel : NSObject

@property(nonatomic) int advert_id;

@property(nonatomic) int placeholder_id;

@property(nonatomic,strong) NSString *image;

@property(nonatomic) int link_type;

@property(nonatomic,strong) LinkModel *link;

@end

//***合伙人我的页面
@interface PartnerMyPageModel : NSObject

//跳转页面 1合伙人功能页面 2填写提佣金方式页面 3跳转支付页面(收银台) 4注册页面
@property(nonatomic) int go_to_page;

//合伙人订单id go_to_page=3时使用(124无此字段)
@property(nonatomic) int partner_order_id;

//合伙人头像
@property(nonatomic,strong) NSString *partner_avatar;

@property(nonatomic,strong) NSString *partner_nickname;

@property(nonatomic,strong) NSString *realname;
//账户余额
@property(nonatomic) double amount;
//战队人数
@property(nonatomic) int team_num;
//战队等级
@property(nonatomic,strong) NSString *team_title;
//佣金
@property(nonatomic) double commission;
//权益金
@property(nonatomic) double bond;
//储值卡图片
@property(nonatomic,strong) NSMutableArray *card_banner;
//底部banner
@property(nonatomic,strong) NSMutableArray *footer_banner;
//占位id 6储值卡图片 3底部banner
@property(nonatomic) int placeholder_id;
//图片地址
@property(nonatomic,strong) NSString *image;
//链接类型(0网址、1App 界面)
@property(nonatomic) int link_type;

@property(nonatomic,strong) NSString *link;

@end


//***合伙人保证金支付成功后的信息
@interface PartnerInfoModel : NSObject

@property(nonatomic) long mobile;

@property(nonatomic,strong) NSString *realname;
//推荐成功奖励说明
@property(nonatomic,strong) NSString *reward_desc;

@property(nonatomic,strong) NSString *reward_desc_team;

@end


//***储值卡订货卡
@interface StorageCardModel : NSObject

@property(nonatomic) double money;

@property(nonatomic) int store_card_id;
//储值卡图片
@property(nonatomic,strong) NSString *store_card_thumb;

@property(nonatomic,strong) NSString *title;

@property(nonatomic,strong) NSString *store_card_title;

@property(nonatomic,strong) NSString *image;

@property(nonatomic) double return_money;

@property(nonatomic,strong) NSString *detail;

@end

//储值卡购买付款参数
@interface StorageCardPayModel : NSObject

@property(nonatomic) int partner_order_id;

@property(nonatomic) double pay_money;

@end

//***合伙人滚动区域通知
@interface PartnerScrollModel : NSObject

@property(nonatomic,strong) NSString *nickname;

@property(nonatomic,strong) NSString *avatar;

@property(nonatomic,strong) NSString *msg;

@end

//***我要赚
@interface MakeMoneyModel : NSObject

@property(nonatomic,strong) NSString *first_level;

@property(nonatomic,strong) NSString *second_level;

@property(nonatomic,strong) NSMutableArray *recommend;

@end

//***我要赚钱--购买情况
@interface MakeMoneyBuyInfoModel : NSObject

@property(nonatomic,strong) NSString *avatar;

@property(nonatomic,strong) NSString *nickname;
//合伙人发展用户
@property(nonatomic,strong) NSMutableArray *recommend;
//购物情况
@property(nonatomic,strong) NSString *buy_text;
//是否购物 0未购物 1已购物
@property(nonatomic) int is_buy;
//截止时间
@property(nonatomic,strong) NSString *end_at;

@end

//***我的推荐的人信息
@interface RecommendInfoModel : NSObject

@property(nonatomic,strong) NSString *avatar;
@property(nonatomic,strong) NSString *nickname;

@end

//***我要推荐
@interface MyRecommendInfoModel : NSObject
//一级列表
@property(nonatomic,strong) NSMutableArray *team_first;
//二级列表
@property(nonatomic,strong) NSMutableArray *team_second;
//战队人数
@property(nonatomic) int team_num;
//等级标题
@property(nonatomic,strong) NSString *team_title;
//合伙人昵称
@property(nonatomic,strong) NSString *partner_nickname;

@property(nonatomic,strong) NSString *realname;
//合伙人头像
@property(nonatomic,strong) NSString *partner_avatar;
//战队标志图片
@property(nonatomic,strong) NSString *team_sign_thumb;
//合伙人id
@property(nonatomic) int partner_id;

@end


//***结算中心
@interface SettlementCenterModel : NSObject

@property(nonatomic,strong) NSString *partner_avatar;

@property(nonatomic,strong) NSString *realname;
//战队等级
@property(nonatomic,strong) NSString *team_title;
//战队标志图片
@property(nonatomic,strong) NSString *team_sign_thumb;
//文案
@property(nonatomic,strong) NSString *msg;

@property(nonatomic,strong) NSString *partner_nickname;
//销售佣金
@property(nonatomic) double sale_commission;
//推荐佣金
@property(nonatomic) double recommend_commission;
//储值卖货
@property(nonatomic) double store_sell_goods;
//佣金解释(富文本)
@property(nonatomic,strong) NSString *commission_desc;

@end

//***学习天地
@interface StudyModel : NSObject

@property(nonatomic) int content_id;

@property(nonatomic,strong) NSString *title;
//作者
@property(nonatomic,strong) NSString *writer;
//图片地址
@property(nonatomic,strong) NSString *thumb;

@property (nonatomic,strong) UIImage *videoImage;

@end

//***佣金记录
@interface CommissionRecordModel : NSObject

@property(nonatomic) int record_id;
//佣金
@property(nonatomic) double commission;
//来源 0商品一级佣金1商品二级佣金2推荐合伙人单个人推荐费3推荐合伙人满额推荐费其他都是卡号或账号
@property(nonatomic,strong) NSString *comm_type;
//日期
@property(nonatomic,strong) NSString *created_at;

@property(nonatomic,strong) NSString *content;

@property(nonatomic,strong) NSString *status;

//佣金来源描述
//- (NSString*)getCommTypeDesc;

@end


//***保证金
@interface BondModel : NSObject
//头合伙人像
@property(nonatomic,strong) NSString *partner_avatar;
//战队等级
@property(nonatomic,strong) NSString *team_title;
//战队标志图标
@property(nonatomic,strong) NSString *team_sign_thumb;
//合伙人昵称
@property(nonatomic,strong) NSString *partner_nickname;
//保证金购买日期
@property(nonatomic,strong) NSString *buy_time;
//保证金到期日期
@property(nonatomic,strong) NSString *exp_time;
//保证金
@property(nonatomic) double bond;
//保证金解释(富文本)
@property(nonatomic,strong) NSString *bond_desc;

@end

//****佣金提现的弹窗
@interface CommissionPopupModel : NSObject

//冻结佣金
@property(nonatomic) double frozen_commission;
//可提现佣金
@property(nonatomic) double can_get_commission;
//冻结佣金描述
@property(nonatomic,strong) NSString *frozen_desc;

@end


//***优惠券列表
@interface CouponListModel : NSObject
//用户优惠券id
@property(nonatomic) int user_coupon_id;
//使用时间 为空表示未使用
@property(nonatomic,strong) NSString *use_at;
//优惠券id
@property(nonatomic) int coupon_id;
//商品分类id
@property(nonatomic) int goods_cat_id;
//抵扣金额
@property(nonatomic,strong) NSString *coupon_price;
//标题
@property(nonatomic,strong) NSString *coupon_title;
//描述
@property(nonatomic,strong) NSString *coupon_description;
//使用开始时间
@property(nonatomic,strong) NSString *use_start_at;
//使用截止时间
@property(nonatomic,strong) NSString *use_end_at;

//是否选中
@property(nonatomic) BOOL isChecked;

@end


//***合伙人级别
@interface PartnerLevelModel : NSObject
//级别 队长 排长 连长....
@property(nonatomic,strong) NSString *team_title;
//已推荐人数
@property(nonatomic) int team_num;
//晋级提示说明
@property(nonatomic,strong) NSString *next_level_text;
//战队等级说明 富文本
@property(nonatomic,strong) NSString *team_content;

@property(nonatomic,strong) NSString *team_image;

@end


typedef enum{
    PAY_TYPE_JOINPARTNER,//合伙人支付
    PAY_TYPE_BUY_STOAGECARD,//购买储值卡支付
}EnumPayType;

//支付信息类
@interface PayInfoModel : NSObject

@property(nonatomic) int partner_order_id;

@property(nonatomic) double pay_money;

@property(nonatomic) EnumPayType payTypeEnum;

@end


//客服信息
@interface CustomInfoModel : NSObject

@property(nonatomic,strong) NSString *service_img;

@property(nonatomic,strong) NSMutableArray *service_list;

@end

//客服列表
@interface CustomInfoListModel : NSObject

@property(nonatomic,strong) NSString *headImg;

@property(nonatomic,strong) NSString *name;

@property(nonatomic,strong) NSString *phone;

@property(nonatomic,strong) NSString *wechat;

@end

//分享
@interface ShareAppModel : NSObject

@property(nonatomic,strong) NSString *title;

@property(nonatomic,strong) NSString *description1;

@property(nonatomic,strong) NSString *url;

@property(nonatomic,strong) NSString *image;

@end


//佣金提现页面初始化参数
@interface CommissionShowModel : NSObject

@property(nonatomic) double can_get_commission;

@property(nonatomic) int bank_type;

@property(nonatomic,strong) NSString *realname;

@property(nonatomic,strong) NSString *zfb_account;

@property(nonatomic,strong) NSString *bank_card;

@end


//***微信支付参数
@interface WxPayModel : NSObject

@property(nonatomic,strong) NSString *appid;

@property(nonatomic,strong) NSString *noncestr;

@property(nonatomic,strong) NSString *package_value;

@property(nonatomic,strong) NSString *partnerid;

@property(nonatomic,strong) NSString *prepayid;

@property(nonatomic,strong) NSString *timestamp;

@property(nonatomic,strong) NSString *sign;

@end

//银行信息
@interface BankModel : NSObject

@property(nonatomic,strong) NSString *type;

@property(nonatomic,strong) NSString *name;

@end


NS_ASSUME_NONNULL_END
