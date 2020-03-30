//
//  GoodsDetailCommentItemViewModel.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYItemUIBaseViewModel.h"

@interface CommentRowItemViewModel : LYItemUIBaseViewModel

@property (nonatomic,copy)NSString *headerImgUrl;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *commentDetail;
@property (nonatomic,copy)NSString *created_at;
@property (nonatomic,strong)NSArray *commentImageUrls;

- (instancetype)initWithHeaderImgUrl:(NSString *)imgUrl
                            userName:(NSString *)userName
                       commentDetail:(NSString *)commentDetail
                    commentImageUrls:(NSArray *)commentImageUrls
                          created_at:(NSString *)created_at;

- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (NSString *)imageUrlAtIndexPath:(NSIndexPath *)indexPath;

@end
