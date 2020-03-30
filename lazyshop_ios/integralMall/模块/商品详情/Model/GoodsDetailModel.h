//
//  GoodsDetailModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/15.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "BaseStringProModel.h"

#import "GoodsDetailActivityModel.h"

@interface GoodsDetailModel : BaseStringProModel

/*
 *  商品标题
 */
@property (nonatomic, copy) NSString *goods_title;
/*
 *  商品分类ID
 */
@property (nonatomic, copy) NSString *goods_cat_id;
/*
 *  商品价格
 */
@property (nonatomic, copy) NSString *price;
/*
 *  返现比例
 */
@property (nonatomic, copy) NSString *rebate_percent;
/*
 *  返现次数
 */
@property (nonatomic, copy) NSString *rebate_times;
/*
 *  商品运费
 */
@property (nonatomic, copy) NSString *postage;
/*
 *  商品标签
 */
@property (nonatomic,strong) NSArray *goods_tag;
/*
 *  商品评论
 */
@property (nonatomic,strong) NSArray *goods_comment;
/*
 *  商品评价数量
 */
@property (nonatomic,copy) NSString *comments;
/*
 *  商品图片
 */
@property (nonatomic,strong) NSArray *goods_image;
/*
 *  是否有优惠券
 */
@property (nonatomic,copy) NSString *is_coupon;
/*
 *  是否支持积分
 */
@property (nonatomic,copy) NSString *use_score;
/*
 *  商品缩略图
 */
@property (nonatomic,copy) NSString *thumb;
/*
 *  积分商品价格
 */
@property (nonatomic,copy) NSString *score;
/*
 *  音频链接
 */
@property (nonatomic,copy) NSString *audio;
/*
 *  音频时间
 */
@property (nonatomic,copy) NSString *audio_time;
/*
 *  视频链接
 */
@property (nonatomic,copy) NSString *video;
/*
 *  视频时间
 */
@property (nonatomic,copy) NSString *video_time;
/*
 *  活动商品sku_id
 */
@property (nonatomic,copy) NSString *goods_sku_id;
/*
 *  活动商品货仓id
 */
@property (nonatomic,copy) NSString *storehouse_id;
/*
 *  活动商品sku字符串
 */
@property (nonatomic,copy) NSString *attr_values;
/*
 *  活动信息
 */
@property (nonatomic,strong) GoodsDetailActivityModel *activity;

@end
