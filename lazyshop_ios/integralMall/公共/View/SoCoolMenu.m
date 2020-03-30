//
//  SoCoolMenu.m
//  MobileClassPhone
//
//  Created by zln on 16/5/10.
//  Copyright © 2016年 CDEL. All rights reserved.
//

#import "SoCoolMenu.h"
#import "MenuBgImgView.h"
#import "SCItemView.h"
#import "UIView+Separator.h"

@interface SoCoolMenu ()

@property (nonatomic, assign) BOOL isOpen;

@end

@implementation SoCoolMenu

{
    NSMutableArray * _menuItems;
    
    CGFloat _firstOffsetY;
    CGFloat _itemHeight;
    CGFloat _itemWidth;
    CGFloat _itemNum;                   // item的个数
    CGPoint _showPoint;                 // 弹出的位置
    
    UIColor *_backGroundColor;          // 纯色背景的背景颜色
    UIView  *_rootView;
    UIView  *_separateView;
    MenuBgImgView * _menuBGImageView;   // 带尖角的菜单背景
    
    cornerType _cornerType;             // 尖角指向的类型
    
    BOOL _isAnimating;
}

- (void)dealloc
{
    CLog(@"dealloc === %@",self.class);
}

- (instancetype)initWithBgColor:(UIColor *)bgColor {
    return [self initWithBgColor:bgColor andCornerType:cornerType_right];
}

- (instancetype)initWithBgColor:(UIColor *)bgColor andCornerType:(cornerType)type {
    if (self = [super init]) {
        _firstOffsetY       = (type == cornerType_no ? 0: 8);
        _cornerType         = type;
        _isAnimating        = NO;
        _isOpen             = NO;                       // 默认是没有打开的状态
        _autoSetSwipeReturn = YES;
        _menuItems          = [NSMutableArray array];
        self.needHighLightFirstItem = NO;               // 默认第一个item不高亮
        if (bgColor) {
            _backGroundColor = bgColor;
        } else {
            _backGroundColor = [UIColor whiteColor];    // 缺省背景色是白色
        }
    }
    return self;
}

- (void)loadItems {
    
    _itemNum    = 0;
    _itemWidth  = [UIScreen mainScreen].bounds.size.width;
    _itemHeight = 44.f;
    _showPoint  = CGPointMake(0, 0);
    [_menuItems removeAllObjects];
    
    if (_menuBGImageView) {
        // 先删除_menuBGImageView上所有的子视图
        for (UIView *obj in _menuBGImageView.subviews) {
            [obj removeFromSuperview];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(numberOfItemsInSoCoolMenu:)]) {
        _itemNum    = [self.delegate numberOfItemsInSoCoolMenu:self];
        if ([self.delegate respondsToSelector:@selector(widthOfItemsInSoCoolMenu:)]) {
            _itemWidth  = [self.delegate widthOfItemsInSoCoolMenu:self];
        }
        if ([self.delegate respondsToSelector:@selector(heightOfItemsInSoCoolMenu:)]) {
            _itemHeight  = [self.delegate heightOfItemsInSoCoolMenu:self];
        }
        if ([self.delegate respondsToSelector:@selector(pointOfShowPositionInSoCoolMenu:)]) {
            _showPoint  = [self.delegate pointOfShowPositionInSoCoolMenu:self];
        }
        
        [self createView];
    } else {
        return;
    }
}

- (void)createView {
    if (!_menuBGImageView) {
        MenuBgImgView *menuBgView = [[MenuBgImgView alloc] initWithBgColor:_backGroundColor AndFrame:CGRectMake(_showPoint.x, _showPoint.y, _itemWidth, 0) andCornerType:_cornerType cornerRadius:self.cacelRoundCorner?0:4];
        _menuBGImageView = menuBgView;
    }
    
    UIView *rootView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    rootView.backgroundColor = [UIColor clearColor];
    
    // 背景触摸层
    UIView *separateView = [UIView new];
    separateView.backgroundColor = [UIColor blackColor];
    separateView.userInteractionEnabled = YES;
    [separateView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTap:)]];
    
    [rootView addSubview:separateView];
    [rootView addSubview:_menuBGImageView];
    
    @weakify(self,rootView);
    [separateView makeConstraints:^(MASConstraintMaker *make) {
        @strongify(rootView);
        make.left.top.right.bottom.equalTo(rootView);
    }];
    
    UIView *frontView = nil;
    
    for (NSInteger i = 0; i < _itemNum; i ++) {
        SCItemView *itemView = [SCItemView new];
        if ([self.delegate respondsToSelector:@selector(soCoolMenu:SCItemViewForRow:)]) {
            itemView = [self.delegate soCoolMenu:self SCItemViewForRow:i];
        } else {
            itemView = [[SCItemView alloc] init];
        }
        if (i != _itemNum - 1 && !self.cacelPartingLine) {
            [itemView addBottomLine];
        }
        [[itemView.touchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(soCoolMenu:didSelectRow:)]) {
                [self.delegate soCoolMenu:self didSelectRow:i];
            }
            self.seletedIndex = i;
            [self closeMenu];
        }];
        [_menuItems addObject:itemView];
        [_menuBGImageView addSubview:itemView];
        if (i == 0) {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.left.right.equalTo(self->_menuBGImageView);
                make.top.equalTo(self->_menuBGImageView.top).offset(self->_firstOffsetY);
                make.height.equalTo(self->_itemHeight);
                make.width.equalTo(self->_itemWidth);
            }];
        }
        else {
            @weakify(self,frontView);
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self, frontView);
                make.left.right.equalTo(self->_menuBGImageView);
                make.top.equalTo(frontView.bottom);
                make.height.equalTo(self->_itemHeight);
                make.width.equalTo(self->_itemWidth);
            }];
        }
        
        frontView = itemView;
    }
    _rootView = rootView;
    _separateView = separateView;
    if (self.needHighLightFirstItem) {
        self.seletedIndex = 0;
    }
}

#pragma mark --- 私有方法
- (void)clickItem:(SCItemView *)item {
    for (SCItemView *obj in _menuItems) {
        if (item == obj) {
            obj.isSelected = YES;
        } else {
            obj.isSelected = NO;
        }
    }
}

#pragma mark --- 属性访问器
- (void)setSeletedIndex:(NSInteger)seletedIndex {
    _seletedIndex = seletedIndex;
    NSUInteger count = _menuItems.count;
    if (seletedIndex > count - 1) {
        _seletedIndex = 0;
    } else {
        SCItemView *item = _menuItems[_seletedIndex];
        item.isSelected = YES;
        for (SCItemView *obj in _menuItems) {
            if (obj != item) {
                obj.isSelected = NO;
            }
        }
    }
}

#pragma mark --- 弹出下拉菜单方法
- (void)showMenuInView:(UIView *)parentView
{
    if (_isAnimating) {
        return;
    }
    
    if ([_rootView superview]) {
        [_rootView removeFromSuperview];
    }
    [parentView addSubview:_rootView];
    _separateView.alpha = 0;
    _isAnimating = YES;
    @weakify(self);
    [UIView animateWithDuration:0.3
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:4.0
                        options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         @strongify(self);
                         self->_separateView.alpha = 0.35;
                         CGFloat marginY = (_cornerType == cornerType_bottom) ? CGRectGetHeight(parentView.frame) - self->_itemHeight * self->_itemNum + self->_firstOffsetY : _showPoint.y;
                         self->_menuBGImageView.frame = CGRectMake(_showPoint.x, marginY, self->_itemWidth, self->_itemHeight * self->_itemNum + self->_firstOffsetY);
                     } completion:^(BOOL finished) {
                         @strongify(self);
                         self->_isAnimating = NO;
                     }];
    
    
    self.isOpen = YES;
    self.swipeReturnEnabled = NO;
}

#pragma mark --- 收起下拉菜单方法
- (void)bgTap:(UITapGestureRecognizer *)tap {
    [self closeMenu];
}

- (void)closeMenu {
    if (_isAnimating) {
        return;
    }
    
    _isAnimating = YES;
    
    @weakify(self);
    [UIView animateWithDuration:.2 animations:^{
        @strongify(self);
        self->_menuBGImageView.frame = CGRectMake(self->_showPoint.x, self->_showPoint.y, self->_itemWidth, 0);
    } completion:^(BOOL s){
        @strongify(self);
        self->_separateView.alpha = 0.0;
        self.swipeReturnEnabled = YES;
        [self->_rootView removeFromSuperview];
        self->_isAnimating = NO;
        self.isOpen = NO;
    }];
}

#pragma mark --- 设置回到控制器之后的滑动返回手势
//设置手势
- (void)setSwipeReturnEnabled:(BOOL)enable
{
    if (!_autoSetSwipeReturn) {
        return;
    }
    
    if (IsIOS7) {
        //设置当前页面IOS7下的手势操作
        UINavigationController *currentVC = [self findViewController:_rootView];
        
        if (currentVC) {
            if ([currentVC respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                currentVC.interactivePopGestureRecognizer.enabled = enable;
            }
        }
    }
}

//获取持有当前UIView的UINavigationController
- (UINavigationController *)findViewController:(UIView *)sourceView
{
    UINavigationController *targetVC = nil;
    
    id target = sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UINavigationController class]]) {
            targetVC = target;
            break;
        }
    }
    
    return targetVC;
}

@end
