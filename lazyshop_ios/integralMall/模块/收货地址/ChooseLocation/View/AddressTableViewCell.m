//
//  AddressTableViewCell.m
//  ChooseLocation
//
//  Created by Sekorm on 16/8/26.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "AddressProvinceModel.h"
#import "AddressCityModel.h"
#import "AddressDistrictModel.h"

@interface AddressTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectFlag;
@end
@implementation AddressTableViewCell

- (void)setItem:(BaseModel *)item{
    
    _item = item;
    if ([item isKindOfClass:[AddressProvinceModel class]]) {
        AddressProvinceModel *itemModel = (AddressProvinceModel *)item;
        _addressLabel.text = itemModel.province_name;
        _addressLabel.textColor = itemModel.isSelected ? [UIColor orangeColor] : [UIColor blackColor] ;
        _selectFlag.hidden = !itemModel.isSelected;
    }else if ([item isKindOfClass:[AddressCityModel class]]) {
        AddressCityModel *itemModel = (AddressCityModel *)item;
        _addressLabel.text = itemModel.city_name;
        _addressLabel.textColor = itemModel.isSelected ? [UIColor orangeColor] : [UIColor blackColor] ;
        _selectFlag.hidden = !itemModel.isSelected;
    }else if ([item isKindOfClass:[AddressDistrictModel class]]) {
        AddressDistrictModel *itemModel = (AddressDistrictModel *)item;
        _addressLabel.text = itemModel.district_name;
        _addressLabel.textColor = itemModel.isSelected ? [UIColor orangeColor] : [UIColor blackColor] ;
        _selectFlag.hidden = !itemModel.isSelected;
    }
}
@end
