//
//  GoodsDetailCommentItemCell.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/8/19.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "CommentRowItemCell.h"

#import "CommentRowItemViewModel.h"
#import "CommentRowImageCell.h"

#import "ZYPhotoBrowser.h"

static NSString *cellReuseID = @"CommentRowImageCell";

@interface CommentRowItemCell()<UICollectionViewDelegate,UICollectionViewDataSource,HZPhotoBrowserDelegate>

@property (nonatomic,strong)CommentRowItemViewModel *viewModel;

@property (nonatomic,strong)UIImageView *headerImageView;
@property (nonatomic,strong)UILabel *userNameLabel;
@property (nonatomic,strong)UILabel *commentDateLabel;
@property (nonatomic,strong)UILabel *detailLabel;
@property (nonatomic,strong)UICollectionView *commentImagesView;

@end

@implementation CommentRowItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
    }
    return self;
}

- (void)addViews
{
    // 头像
    self.headerImageView = [self.contentView addImageViewWithImageName:nil
                                              cornerRadius:14];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(28);
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(7.5);
    }];
    
    // 用户名
    self.userNameLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                  textAlignment:0
                                                      textColor:@"#000000"
                                                   adjustsWidth:NO
                                                   cornerRadius:0
                                                           text:nil];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.right).offset(12.5);
        make.centerY.mas_equalTo(self.headerImageView);
    }];
    
    // 评价时间
    self.commentDateLabel = [self.contentView addLabelWithFontSize:SMALL_FONT_SIZE
                                                     textAlignment:0
                                                         textColor:@"#999999"
                                                      adjustsWidth:NO
                                                      cornerRadius:0
                                                              text:nil];
    [self.commentDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.userNameLabel);
    }];
    
    // 评论内容
    self.detailLabel = [self.contentView addLabelWithFontSize:MIDDLE_FONT_SIZE
                                                textAlignment:0
                                                    textColor:@"#000000"
                                                 adjustsWidth:NO
                                                 cornerRadius:0
                                                         text:nil];
    self.detailLabel.numberOfLines = 0;
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.headerImageView.bottom).offset(10);
    }];
    // 评论图片
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = CommentImageItemGap;
    layout.minimumLineSpacing = CommentImageItemGap;
    layout.itemSize = CGSizeMake(CommentImageItemWidth, CommentImageItemWidth);
    layout.sectionInset = UIEdgeInsetsMake(CommentImageTopGap, CommentImageLeftGap, CommentImageTopGap, CommentImageLeftGap);
    
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.commentImagesView = collectionView;
    [self.contentView addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.detailLabel.bottom);
    }];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.layer.cornerRadius = 5;
    collectionView.layer.masksToBounds = YES;
    collectionView.scrollEnabled = NO;
    
    [collectionView registerClass:[CommentRowImageCell class] forCellWithReuseIdentifier:cellReuseID];
    // 底线
    [self.contentView addBottomLine];
}

- (void)bindViewModel:(CommentRowItemViewModel *)vm
{
    self.viewModel = vm;
    [self.headerImageView ly_customDefaultImg:@"用户"
                                          url:vm.headerImgUrl];
    self.userNameLabel.text = vm.userName;
    self.commentDateLabel.text = vm.created_at;
    self.detailLabel.text = vm.commentDetail;
    [self.commentImagesView reloadData];
}

#pragma mark -collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommentRowImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseID forIndexPath:indexPath];
    [cell reloadWithImageUrl:[self.viewModel imageUrlAtIndexPath:indexPath]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYPhotoBrowser *browser = [[ZYPhotoBrowser alloc] init];
    browser.imageCount = [self.viewModel numberOfItemsInSection:0];
    browser.currentImageIndex = (int)indexPath.row;
    browser.delegate = self;
    [browser show];
}

#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(ZYPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return nil;
}

- (NSURL *)photoBrowser:(ZYPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    return [NSURL URLWithString:[self.viewModel imageUrlAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]]];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
