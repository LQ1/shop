//
//  HomeCategoryMacro.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#ifndef HomeCategoryMacro_h
#define HomeCategoryMacro_h

// itemCell布局
#define HomeCategoryItemImageContentWidth 45.0f
#define HomeCategoryItemImageWidth 45.0f
#define HomeCategoryItemMidGap 10.0f
#define HomeCategoryItemTitleWidth 60.0f
#define HomeCategoryItemTitleHeight 13.0f
#define HomeCategoryItemCellWidth HomeCategoryItemTitleWidth
#define HomeCategoryItemCellHeight (HomeCategoryItemImageContentWidth+HomeCategoryItemMidGap+HomeCategoryItemTitleHeight)

// 数量控制
#define HomeCategoryCellMaxRowItemCount 5
#define HomeCategoryCellMaxTotalItemCount (HomeCategoryCellMaxRowItemCount*2)

// categoryCell布局
#define HomeCategoryLayoutTopGap 30.0f
#define HomeCategoryLayoutLineGap 20.0f
#define HomeCategoryLayoutLeftGap ((KScreenWidth-HomeCategoryItemCellWidth*HomeCategoryCellMaxRowItemCount)/(HomeCategoryCellMaxRowItemCount+1)-1.)
#define HomeCategoryLayoutBottomGap 5.0f


#endif /* HomeCategoryMacro_h */
