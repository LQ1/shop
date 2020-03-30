//
//  ProductSearchNavView.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/20.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "ProductSearchNavView.h"

#import "ProductSearchViewController.h"

@interface ProductSearchNavView()

@property (nonatomic,assign ) BOOL inputEnabled;
@property (nonatomic,copy   ) NSString *tipTitle;

@property (nonatomic,strong) UILabel *searchTipLabel;
@property (nonatomic,strong) UITextField *searchTextfield;

@property (nonatomic,assign ) ProductSearchFrom searchFrom;
@property (nonatomic,copy   ) searchTitleBackBlock searchBackBlock;

@end

@implementation ProductSearchNavView

- (instancetype)initWithInputEnabled:(BOOL)inputEnabled
                            tipTitle:(NSString *)tipTitle
                   ProductSearchFrom:(ProductSearchFrom)from
                searchTitleBackBlock:(searchTitleBackBlock)block
{
    self = [super init];
    if (self) {
        self.searchBackBlock = block;
        self.searchFrom = from;
        self.inputEnabled = inputEnabled;
        self.tipTitle = tipTitle;
        [self addViews];
    }
    return self;
}

#pragma mark -主界面
- (void)addViews
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    UIImageView *searchTipView = [self addImageViewWithImageName:@"搜索框按钮"
                                                          cornerRadius:0];
    [searchTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(21);
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(11);
    }];
    
    if (!self.inputEnabled) {
        UILabel *searchTipLabel = [self addLabelWithFontSize:SMALL_FONT_SIZE
                                               textAlignment:0
                                                   textColor:@"#ABABAB"
                                                adjustsWidth:NO
                                                cornerRadius:0
                                                        text:self.tipTitle];
        [searchTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(searchTipView.right).offset(8);
            make.centerY.mas_equalTo(searchTipView);
        }];
        self.searchTipLabel = searchTipLabel;
        
        UIButton *clickBtn = [UIButton new];
        [self addSubview:clickBtn];
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        @weakify(self);
        clickBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [PublicEventManager gotoProductSearchViewControllerWithNavigationController:nil productSearchFrom:self.searchFrom searchTitleBackBlock:^(NSString *searchTitle) {
                @strongify(self);
                self.searchTipLabel.text = searchTitle;
                if (self.searchBackBlock) {
                    self.searchBackBlock(searchTitle);
                }
            }];
            return [RACSignal empty];
        }];
    }else{
        self.searchTextfield = [UITextField new];
        self.searchTextfield.placeholder = self.tipTitle;
        self.searchTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.searchTextfield.font = [UIFont systemFontOfSize:SMALL_FONT_SIZE];
        [self addSubview:self.searchTextfield];
        [self.searchTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(searchTipView.right).offset(8);
            make.centerY.mas_equalTo(searchTipView);
            make.right.mas_equalTo(-15);
        }];
    }
}

@end
