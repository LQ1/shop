//
//  ProductSearchMacro.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/18.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#ifndef ProductSearchMacro_h
#define ProductSearchMacro_h

typedef NS_ENUM(NSInteger,ProductSearchFrom)
{
    ProductSearchFrom_HomePage = 0,
    ProductSearchFrom_ProductList,
    ProductSearchFrom_None
};

typedef void (^searchTitleBackBlock)(NSString *searchTitle);

#endif /* ProductSearchMacro_h */
