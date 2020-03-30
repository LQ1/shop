//
//  ShippingAddressItemBaseCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/31.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ShippingAddressItemBaseCell.h"

@implementation ShippingAddressItemBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.shippingUserNameLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:@"#333333"
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
        self.shippingPhoneNumberLabel = [self addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                     textAlignment:NSTextAlignmentRight
                                                         textColor:@"#333333"
                                                      adjustsWidth:NO
                                                      cornerRadius:0
                                                              text:nil];
        self.shippingAddressLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                                 textAlignment:0
                                                     textColor:@"#333333"
                                                  adjustsWidth:NO
                                                  cornerRadius:0
                                                          text:nil];
        self.shippingAddressLabel.numberOfLines = 2;
    }
    return self;
}

@end
