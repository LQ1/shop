//
//  RegPartnerCell.h
//  integralMall
//
//  Created by liu on 2018/10/9.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^OnItemClicked)();

@interface RegPartnerCell : UITableViewCell{
    JoinPartnerQuestion *_data;
    UIImage *_imgChk,*_imgUnChk;
    OnItemClicked _onItemClicked;
}
@property (weak, nonatomic) IBOutlet UILabel *lblQuestNo;
@property (weak, nonatomic) IBOutlet UILabel *lblQuestionTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblA;
@property (weak, nonatomic) IBOutlet UILabel *lblB;
@property (weak, nonatomic) IBOutlet UILabel *lblC;
@property (weak, nonatomic) IBOutlet UILabel *lblD;
@property (weak, nonatomic) IBOutlet UIView *viewA;
@property (weak, nonatomic) IBOutlet UIView *viewB;
@property (weak, nonatomic) IBOutlet UIView *viewC;
@property (weak, nonatomic) IBOutlet UIView *viewD;


- (void)loadData:(JoinPartnerQuestion*)data withBlockItemClicked:(void(^)())onItemClicked;

@end

NS_ASSUME_NONNULL_END
