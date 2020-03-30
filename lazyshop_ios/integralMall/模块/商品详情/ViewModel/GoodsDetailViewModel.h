//
//  GoodsDetailViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/14.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import <BaseWithRAC/BaseWithRAC.h>

@class LYItemUIBaseViewModel;
@class GoodsDetailPramsDetailViewModel;

typedef NS_ENUM(NSInteger, GoodsDetailViewModel_Signal_Type)
{
    GoodsDetailViewModel_Signal_Type_TipLoading = 0,
    GoodsDetailViewModel_Signal_Type_GetDataSuccess,
    GoodsDetailViewModel_Signal_Type_GetDataFail,
    GoodsDetailViewModel_Signal_Type_GotoPattrnChoose,
    GoodsDetailViewModel_Signal_Type_GotoCouponChoose,
    GoodsDetailViewModel_Signal_Type_GotoGoodsTagsDetail,
    GoodsDetailViewModel_Signal_Type_GotoConfirmOrder,
    GoodsDetailViewModel_Signal_Type_ChangeNavViewIndex,
    GoodsDetailViewModel_Signal_Type_GotoMyBargain,
    GoodsDetailViewModel_Signal_Type_PlayVideo,
};

@interface GoodsDetailViewModel : BaseViewModel

@property (nonatomic,assign)GoodsDetailViewModel_Signal_Type currentSignalType;

@property (nonatomic,readonly)RACSubject *tipLoadingSignal;

@property (nonatomic,readonly)GoodsDetailType detailType;

// 是否来自扫一扫
@property (nonatomic,assign)BOOL fromScan;
// 扫到的sku
@property (nonatomic,copy)NSString *scan_goods_sku_id;
@property (nonatomic,copy)NSString *scan_attr_values;
//扫一扫推荐的用户的id
@property (nonatomic,assign)NSString *referee_id;

/*
 *  商品ID
 */
@property(nonatomic,copy) NSString *productID;
/*
 *  商品图片数组
 */
@property(nonatomic,strong) NSArray *productImageUrls;
/*
 *  商品音频描述
 */
@property(nonatomic,copy )NSString *productAudioDescUrl;
/*
 *  音频时间
 */
@property (nonatomic,assign) NSInteger audio_time;
/*
 *  商品视频描述
 */
@property(nonatomic,copy) NSString *productVideoDescUrl;
/*
 *  视频时间
 */
@property (nonatomic,assign) NSInteger video_time;
/*
 *  商品名称
 */
@property(nonatomic,copy) NSString *productName;
/*
 *  商品价格
 */
@property(nonatomic,assign) float productPrice;
/*
 *  积分商品价格
 */
@property(nonatomic,copy) NSString *score;
/*
 *  商品缩略图
 */
@property (nonatomic,copy) NSString *thumb;

/*
 *  拼团剩余人数
 */
@property(nonatomic,assign) NSInteger groupMissNum;
/*
 *  活动剩余时间
 */
@property(nonatomic,assign) NSInteger activityRemainingTime;

/*
 *  初始化
 */
- (instancetype)initWithProductID:(NSString *)productID
                  goodsDetailType:(GoodsDetailType)detailType
                activity_flash_id:(NSString *)activity_flash_id
              activity_bargain_id:(NSString *)activity_bargain_id
                activity_group_id:(NSString *)activity_group_id;

/*
 *  获取数据
 */
- (void)getData;

/**
 绑定合伙人
 */
- (void)bindPartner;

/*列表相关*/
- (NSInteger)numberOfSections;
- (LYItemUIBaseViewModel *)baseUIVMInSection:(NSInteger)section;
- (CGFloat)heightForHeaderInSection:(NSInteger)section;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (LYItemUIBaseViewModel *)baseUIVMAtIndexPath:(NSIndexPath *)indexPath;

/*
 *  跳转sku选择
 */
- (void)gotoPattrnChooseWithConfirmStyle:(BOOL)confirm
                           confirmAction:(int)confirmAction;
/*
 *  跳转优惠券选择
 */
- (void)gotoCouponChoose;
/*
 *  跳转标签详情
 */
- (void)gotoGoodsTagsDetailAtIndexPath:(NSIndexPath *)indexPath;
/*
 *  加入购物车
 */
- (void)addToCart;
/*
 *  立即XX 根据商品类型有所不同
 */
- (void)immediatelyAction;

/*
 *  评论列表vm
 */
- (id)fetchCommentListVM;

/*
 *  商品介绍vm
 */
- (id)fetchIntrodecuVM;

/*
 *  切换视图显示
 */
- (void)changeNavViewToIndex:(NSInteger)index;

/*
 *  停止多媒体播放
 */
- (void)stopPlay;
/*
 *  播放音频
 */
- (void)playAudio;

/*
 *  播放视频
 */
- (void)playVideo;

@end
