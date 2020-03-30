//
//  CategoryViewMacro.h
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/8.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#ifndef CategoryViewMacro_h
#define CategoryViewMacro_h

/*  左边栏 */
// 宽度
#define CategoryLeftBarWidth (KScreenWidth*80/375)
// 每行高度
#define CategoryLeftBarItemHeight 50.0f

/*  右边内容 */
// 内容细项图宽度
#define CategoryRightItemImageWidth 63.5f
// 内容细项图高度
#define CategoryRightItemImageHeight 63.5f
// 内容细项标题高度
#define CategoryRightItemTitleHeight 15.0f
// 内容细项标题和图间距
#define CategoryRightItemTitleTopGap 10.0f

// 内容细项总宽度
#define CategoryRightItemWidth CategoryRightItemImageWidth
// 内容细项总高度
#define CategoryRightItemHeight (CategoryRightItemImageHeight+CategoryRightItemTitleHeight+CategoryRightItemTitleTopGap)

// collectionView白色块左边距
#define CategoryRightWhiteLeftGap 10.0f
// collectionView白色块右边距
#define CategoryRightWhiteRightGap 15.0f

// 每行内容细项最大数
#define CategoryRightRowItemMaxCount 3

// 内容细项水平间距
#define CategoryRightItemHoriGap ((KScreenWidth-CategoryLeftBarWidth-CategoryRightWhiteLeftGap-CategoryRightWhiteRightGap-CategoryRightItemWidth*CategoryRightRowItemMaxCount)/(CategoryRightRowItemMaxCount+1))
// 内容细项垂直间距
#define CategoryRightItemVerGap 15.0f
// 内容细项整体上下间距
#define CategoryRightSectionTopGap 15.0f

// 内容项标题高度
#define CategoryRightSectionHeaderHeight 28.0f





#endif /* CategoryViewMacro_h */
