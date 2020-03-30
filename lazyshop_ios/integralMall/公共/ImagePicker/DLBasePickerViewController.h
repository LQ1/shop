//
//  DLBasePickerViewController.h
//  MobileClassPhone
//
//  Created by yangjie on 16/11/7.
//  Copyright © 2016年 CDEL. All rights reserved.
//

/**
 *  本类功能
 *
 *  1.获取拍照照片和相册照片
 *  2.可设置相册的最大获取张数
 *  3.可自动将每个图片压缩至指定大小以内
 *  4.处理宽长图、处理高长图
 *  5.展示图片控制器Page
 *  6.处理照相时获取方图或全图（设置是否编辑）
 *  7.是否关闭照相隐私权限做提示
 */

#import <UIKit/UIKit.h>
#import "NavigationBarController.h"

@interface DLBasePickerViewController : NavigationBarController

/**
 *  获取照片
 *
 *  @param allowsEditing 照相时设置是否可编辑（可编辑获取张方形的照片，不可编辑获取全图）
 *  @param maxNumber     设置获取相册照片的最大张数
 *  @param maxKb         设置获取的每张照片的最大占用空间
 */
- (void)initWithTakePhoneActionSheet:(BOOL)allowsEditing
                           maxNumber:(NSInteger)maxNumber
                               maxKb:(CGFloat)maxKb;

/**
 *  获取相机照相图片
 *
 *  @param allowsEditing 照相时设置是否可编辑（可编辑获取张方形的照片，不可编辑获取全图）
 *  @param maxNumber     设置获取相册照片的最大张数
 *  @param maxKb         设置获取的每张照片的最大占用空间
 */
- (void)initWithTakePhoneCamera:(BOOL)allowsEditing
                      maxNumber:(NSInteger)maxNumber
                          maxKb:(CGFloat)maxKb;

/**
 *  获取手机相册照片
 *
 *  @param maxNumber 设置获取相册照片的最大张数
 *  @param maxKb     设置获取的每张照片的最大占用空间
 */
- (void)initWithTakePhoneAlbum:(NSInteger)maxNumber
                          maxKb:(CGFloat)maxKb;

/**
 *  返回获取的照片
 *
 *  @param imageArrayBlock 获取照片的数据源（照片存在什么地方自己定，所以返回的是照片没有直接返回对应的本地地址）
 */
- (void)setImageArrayBlock:(void(^)(NSMutableArray * imageArray))imageArrayBlock;

/**
 *  点击查看图片详情
 *
 *  @param imageDataArray 图片数组
 *  @param index          点击当前图片的下标
 */
- (void)clickImagePushPageVCImageArray:(NSArray *)imageDataArray
                                 index:(NSInteger)index;

@end
