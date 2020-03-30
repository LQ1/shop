//
//  LYCategoryChangeView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/14.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "LYCategoryChangeView.h"

#define LYCategoryChangeViewItemWidth 62.0f
#define LYCategoryChangeViewItemHeight 33.0f
#define LYCategoryChangeViewItemBaseTag 99999
#define LYCategoryChangeViewHeight 40.0f

@interface LYCategoryChangeView()

@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,copy  )LYCategoryChangeViewSelectBlock mySelectBlock;
@property (nonatomic,assign)NSInteger currentSelectIndex;
@property (nonatomic,strong)UIView *bottomBar;

@end

@implementation LYCategoryChangeView

#pragma mark -初始化
- (instancetype)initWithTitles:(NSArray *)titles
                   selectBlock:(LYCategoryChangeViewSelectBlock)block
{
    self = [super init];
    if (self) {
        self.titles = [NSArray arrayWithArray:titles];
        self.mySelectBlock = block;
        self.currentSelectIndex = -1;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 中间
    NSInteger totalCount = self.titles.count;
    NSInteger middleNumber = totalCount/2;
    BOOL isEvenNumber = totalCount%2==0?YES:NO;
    
    UIButton *middleBtn = [UIButton new];
    middleBtn.tag = [self getTagWithNumber:middleNumber];
    [self addSubview:middleBtn];
    [middleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LYCategoryChangeViewItemWidth);
        make.height.mas_equalTo(LYCategoryChangeViewItemHeight);
        make.centerY.mas_equalTo(self);
        if (isEvenNumber) {
            make.left.mas_equalTo(self.centerX);
        }else{
            make.centerX.mas_equalTo(self.centerX);
        }
    }];
    [self setButtonEventAndTitle:middleBtn];
    
    UIButton *lastBtn = middleBtn;
    
    // 左
    int leftStart = (int)(middleNumber-1>=0?middleNumber-1:0);
    for (int i=leftStart; i>=0; i--) {
        UIButton *leftBtn = [UIButton new];
        leftBtn.tag = [self getTagWithNumber:i];
        [self addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.centerY.mas_equalTo(lastBtn);
            make.right.mas_equalTo(lastBtn.left);
        }];
        [self setButtonEventAndTitle:leftBtn];
        lastBtn = leftBtn;
    }
    
    lastBtn = middleBtn;
    // 右
    int rightStart = (int)(middleNumber+1<totalCount?middleNumber+1:totalCount);
    for (int i = rightStart; i<=totalCount-1; i++) {
        UIButton *rightButton = [UIButton new];
        rightButton.tag = [self getTagWithNumber:i];
        [self addSubview:rightButton];
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.centerY.mas_equalTo(lastBtn);
            make.left.mas_equalTo(lastBtn.right);
        }];
        [self setButtonEventAndTitle:rightButton];
        lastBtn = rightButton;
    }
    
    // 选中标识
    UIView *bottomBarView = [UIView new];
    self.bottomBar = bottomBarView;
    bottomBarView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomBarView];
    // 默认选中第一个
    [self makeIndexSelected:0];
}
// 添加点击事件和标题
- (void)setButtonEventAndTitle:(UIButton *)button
{
    @weakify(self);
    button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self selectIndex:button];
        return [RACSignal empty];
    }];
    button.titleLabel.font = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:[self.titles objectAtIndex:[self getNumberWithTag:button.tag]] forState:UIControlStateNormal];
}

#pragma mark -添加到view
- (void)showViewIn:(UIView *)parentView
     centerYOffSet:(CGFloat)YOffSet
{
    [parentView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(LYCategoryChangeViewHeight);
        make.width.mas_equalTo(self.titles.count*LYCategoryChangeViewItemWidth);
        make.centerX.mas_equalTo(parentView);
        make.centerY.mas_equalTo(parentView.centerY).offset(YOffSet);
    }];
}

#pragma mark -使选中
- (void)makeIndexSelected:(NSInteger)index
{
    [self selectIndex:[self fetchButtonWithIndex:index]];
}
// 选中
- (void)selectIndex:(UIButton *)button
{
    NSInteger toIndex = [self getNumberWithTag:button.tag];
    if (self.currentSelectIndex!=toIndex) {
        self.currentSelectIndex = toIndex;
        [self.bottomBar mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(2);
            make.top.mas_equalTo(button.bottom);
            make.centerX.mas_equalTo(button);
        }];
        if (self.mySelectBlock) {
            self.mySelectBlock([self getNumberWithTag:button.tag]);
        }
    }
}
// 寻找button
- (UIButton *)fetchButtonWithIndex:(NSInteger)index
{
    UIButton *button = (UIButton *)[self.subviews linq_where:^BOOL(UIView *view) {
        return [self getNumberWithTag:view.tag]==index;
    }].linq_firstOrNil;
    return button;
}

#pragma mark -tag/Number转换
// tag
- (NSInteger)getTagWithNumber:(NSInteger)number
{
    return LYCategoryChangeViewItemBaseTag+number;
}
// number
- (NSInteger)getNumberWithTag:(NSInteger)tag
{
    return tag-LYCategoryChangeViewItemBaseTag;
}

@end
