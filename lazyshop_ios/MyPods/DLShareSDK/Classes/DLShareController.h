//
//  DLShareController.h
//  DLShareSDK
//
//  Created by LY on 16/7/6.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DLShareView;
// 分享风格
typedef enum {
    DLShareStyleNews = 0, // 分享风格_新闻
    DLShareStyleImage     // 分享风格_图片
}DLShareStyle;

@interface DLShareController : NSObject

/**
 *  设置属性后自动注册微信SDK
 */
@property(nonatomic,copy)NSString* WXAppKey;

/**
 *  自定义的分享视图 分享调用前设置此属性有效
 */
@property (nonatomic,strong) DLShareView*customShareView;

/**
 *  重写appDelegate中相应方法调用
 */
- (BOOL)applicationHandleOpenURL:(NSURL *)url;
- (BOOL)applicationOpenURL:(NSURL *)url;

/**
 *  单例
 */
+ (DLShareController *)shareInstance;

/**
 *  所有参数都必传且非空 默认只注册QQKey 如需注册微信需设置WXAppKey
 */
- (void)registerShareSDKWithQQAppKey:(NSString*)QQKey
                        previewImage:(UIImage*)previewImage
                             htmlStr:(NSString *)htmlStr
                            titleStr:(NSString *)titleStr
                           detailStr:(NSString *)detailStr;
/**
 *  调用API 请使用单例调用当前方法
 *
 *  @param mainTitle    分享标题
 *  @param detailTitle  分享详细
 *  @param imageObject  分享图片(支持UIImage、NSURL对象 且缩略图会自动压缩到可分享的大小)
 *  @param htmlStr      分享web
 *  @param isAppAgree   isAppAgree
 *  @param shareStyle   分享风格
 */
- (void)displayTitle:(NSString *)mainTitle
         DetailTitle:(NSString *)detailTitle
        previewImage:(id)imageObject
             HtmlStr:(NSString*)htmlStr
          isAppAgree:(BOOL)isAppAgree
          shareStyle:(DLShareStyle)shareStyle;

@end
