//
//  IssueCommentView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/9/25.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "IssueCommentView.h"

#import "ZYPhotoBrowser.h"
#import "LYMainColorButton.h"
#import "IssueCommentViewModel.h"

#define ImgBtnWidth  100.0f
#define ImgBtnNumber  3
#define HodelLabelTip @"对此商品还满意吗？聊聊你的想法吧，但不要少于5个字，也不要超过200字哦"

@interface IssueCommentView()<UITextViewDelegate,HZPhotoBrowserDelegate>

@property (nonatomic,strong) IssueCommentViewModel *viewModel;

/**
 *  hodel
 */
@property (nonatomic, strong) UILabel * hodelLabel;
/**
 *  图片区域
 */
@property (nonatomic, strong) UIView * imgBg;

@property (nonatomic,strong)UIImage  *bigImage;

@end

@implementation IssueCommentView

- (instancetype)initWithViewModel:(IssueCommentViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.imgs = [NSMutableArray array];
        // 初始化View
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    // 背景
    self.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    
    // header
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor whiteColor];
    [self addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(50);
    }];
    [header addBottomLine];
    
    UIImageView *imageView = [header addImageViewWithImageName:nil
                                                  cornerRadius:0];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(35);
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(header);
    }];
    [imageView ly_showMidImg:self.viewModel.goods_thumb];
    
    UILabel *titleLabel = [header addLabelWithFontSize:SMALL_FONT_SIZE
                                         textAlignment:0
                                             textColor:@"#333333"
                                          adjustsWidth:NO
                                          cornerRadius:0
                                                  text:self.viewModel.goods_title];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.right).offset(10);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(imageView);
    }];
    
    // 输入区域
    UIView *inputContentView = [UIView new];
    inputContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:inputContentView];
    [inputContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(header.bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(80);
    }];
    // textView
    UITextView * contentTV = [[UITextView alloc]init];
    contentTV.backgroundColor = [UIColor whiteColor];
    contentTV.font = [UIFont systemFontOfSize:MIDDLE_FONT_SIZE];
    contentTV.delegate = self;
    contentTV.textColor = [CommUtls colorWithHexString:@"#333333"];
    [inputContentView addSubview:contentTV];
    self.contentTV = contentTV;
    [contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7.5);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(65);
    }];
    // hodelLabel
    UILabel * hodelLabel = [[UILabel alloc]init];
    hodelLabel.backgroundColor = [UIColor clearColor];
    hodelLabel.textColor = [CommUtls colorWithHexString:@"#999999"];
    hodelLabel.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
    hodelLabel.text = HodelLabelTip;
    hodelLabel.numberOfLines = 0;
    [inputContentView addSubview:hodelLabel];
    self.hodelLabel = hodelLabel;
    [hodelLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentTV.top).offset(8);
        make.left.equalTo(contentTV.left).offset(5);
        make.right.equalTo(contentTV.right).offset(-10);
    }];
    
    // 图片区域
    UIView *imgBg = [UIView new];
    imgBg.backgroundColor = [UIColor whiteColor];
    [self addSubview:imgBg];
    self.imgBg = imgBg;
    [imgBg makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentTV.bottom);
        make.left.right.equalTo(0);
        make.height.equalTo(125);
    }];
    // 设置图片
    [self setImgZone];
    // 底部按钮
    LYMainColorButton *submitBtn = [[LYMainColorButton alloc] initWithTitle:@"提交评价"
                                                             buttonFontSize:18
                                                               cornerRadius:3];
    [self addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.right.mas_equalTo(-20);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(45);
    }];
    @weakify(self);
    submitBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self submit];
        return [RACSignal empty];
    }];
}
// 提交评价
- (void)submit
{
    // 收起键盘
    [self clickBtnPackUpKeyboard];
    // 内容检测
    NSString *contentStr = [self.contentTV.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.viewModel.submitContent = contentStr;
    
    if (contentStr.length == 0) {
        [DLLoading DLToolTipInWindow:@"请输入内容"];
        return;
    }
    
    // 上传图片
    if (self.imgs.count)
    {
        self.viewModel.imgs = self.imgs;
    }
    // 提交评价
    [self.viewModel submit];
}
// 是否输入了内容
- (BOOL)hasContentInput
{
    NSString *contentStr = [self.contentTV.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (contentStr.length) {
        return YES;
    }
    return NO;
}

#pragma mark - 设置图片
- (void)setImgZone
{
    // 移除旧视图
    for (UIView *subView in self.imgBg.subviews)
    {
        [subView removeFromSuperview];
    }
    @weakify(self);
    NSInteger count = 0;
    UIView *lastView = nil;
    // 添加
    CGFloat gap = (KScreenWidth - ImgBtnNumber*ImgBtnWidth)/(ImgBtnNumber+1);
    
    for (UIImage *img in self.imgs) {
        UIImageView *iv = [UIImageView new];
        iv.image = img;
        [self.imgBg addSubview:iv];
        
        [iv makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.centerY.equalTo(self.imgBg);
            if (lastView) {
                make.left.equalTo(lastView.mas_right).offset(gap);
            }else{
                make.left.equalTo(self.imgBg).offset(gap);
            }
            make.size.equalTo(CGSizeMake(ImgBtnWidth, ImgBtnWidth));
        }];
        iv.userInteractionEnabled = YES;
        
        UIButton * imgDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imgDeleteBtn.backgroundColor = [UIColor clearColor];
        [imgDeleteBtn setImage:[UIImage imageNamed:@"删除照片"] forState:UIControlStateNormal];
        [self.imgBg addSubview:imgDeleteBtn];
        [imgDeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(iv.top);
            make.centerX.mas_equalTo(iv.right);
            make.width.height.mas_equalTo(30);
        }];
        @weakify(img);
        imgDeleteBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self,img);
            [self.imgs removeObject:img];
            [self setImgZone];
            return [RACSignal empty];
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        [tap.rac_gestureSignal subscribeNext:^(id x) {
            // 收起键盘
            [self clickBtnPackUpKeyboard];
            //点击预览图片
            self.bigImage =img;
            ZYPhotoBrowser *browser = [[ZYPhotoBrowser alloc] init];
            browser.sourceImagesContainerView = self;
            browser.imageCount =1;
            browser.currentImageIndex = 0;
            browser.delegate = self;
            [browser show];
        }];
        [iv addGestureRecognizer:tap];
        
        lastView = iv;
        count++;
    }
    
    if (count < 3) {
        
        UITapGestureRecognizer *chooseTap = [[UITapGestureRecognizer alloc]init];
        [chooseTap.rac_gestureSignal subscribeNext:^(id x) {
            @strongify(self);
            // 收起键盘
            [self clickBtnPackUpKeyboard];
            if (self.selectImg) {
                self.selectImg();
            }
        }];
        
        UIImageView *iv = [UIImageView new];
        iv.image = [UIImage imageNamed:@"上传图片"];
        iv.userInteractionEnabled = YES;
        [self.imgBg addSubview:iv];
        [iv makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.centerY.equalTo(self.imgBg);
            if (lastView) {
                make.left.equalTo(lastView.mas_right).offset(gap);
            }else{
                make.left.equalTo(self.imgBg).offset(gap);
            }
            make.size.equalTo(CGSizeMake(ImgBtnWidth, ImgBtnWidth));
        }];
        
        [iv addGestureRecognizer:chooseTap];
        lastView = iv;
    }
}

#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(ZYPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return self.bigImage;
}

- (NSURL *)photoBrowser:(ZYPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    return nil;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.hasText) {
        self.hodelLabel.text = @"";
    }
    else {
        self.hodelLabel.text = HodelLabelTip;
    }
    // 该判断用于联想输入
    if (textView.text.length > 200 && textView.markedTextRange == nil){
        textView.text = [textView.text substringToIndex:200];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length >= 200){
        if ([text isEqualToString:@""]) {
            return YES;
        }
        return NO;
    }
    else{
        NSString *tmpStr = textView.text;
        tmpStr = [tmpStr stringByReplacingCharactersInRange:range withString:text];
        if (tmpStr.length) {
            self.hodelLabel.text = @"";
        }
        else{
            if (range.length == 1) {
                self.hodelLabel.text = HodelLabelTip;
            }
        }
        return YES;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.contentTV.text = textView.text;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

#pragma mark -收起键盘
- (void)clickBtnPackUpKeyboard
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)closeVC
{
    // 收起键盘
    [self clickBtnPackUpKeyboard];
}

@end
