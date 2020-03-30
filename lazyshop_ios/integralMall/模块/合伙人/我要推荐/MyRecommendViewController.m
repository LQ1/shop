//
//  MyRecommendViewController.m
//  integralMall
//
//  Created by liu on 2018/10/13.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "MyRecommendViewController.h"
#import "UIColor+YYAdd.h"
#import "MyRecommendCell.h"
#import "DataViewModel.h"
#import "ImageLoadingUtils.h"
#import "QRCodeView.h"

@interface MyRecommendViewController ()

@end

@implementation MyRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarView.titleLabel.text = @"我的推荐";
    
    [self initControl];
}

- (void)viewDidAppear:(BOOL)animated{
    [_viewScrollArea startAnimationNotice];
}

- (void)initControl{
    [Utility setExtraCellLineHidden:self.tabView];
    self.imgAvatar.layer.cornerRadius = self.imgAvatar.frame.size.width*0.5f;
    self.imgAvatar.layer.masksToBounds = YES;
    
    [self.tabView registerNib:[UINib nibWithNibName:NSStringFromClass([MyRecommendCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MyRecommendCell class])];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F4F5F6"];
    [self initData];
}

- (void)initData{
    
    _viewScrollArea = [[ViewPartnerScrollArea alloc] initWithParentView:self.viewPartner];
    
    UITapGestureRecognizer *gestureL2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_level_onClicked:)];
    self.lblL2.userInteractionEnabled = YES;
    [self.lblL2 addGestureRecognizer:gestureL2];
    
    UITapGestureRecognizer *gestureL3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_level_onClicked:)];
    self.lblL3.userInteractionEnabled = YES;
    [self.lblL3 addGestureRecognizer:gestureL3];
    
    UITapGestureRecognizer *gesture_rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_rec_onClicked:)];
    self.imgRecommend.userInteractionEnabled = YES;
    [self.imgRecommend addGestureRecognizer:gesture_rec];
    
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_query) withObject:nil];
}

//战队等级切换
- (void)gesture_level_onClicked:(UITapGestureRecognizer*)sender{
    int nL = (int)sender.view.tag;
    self.lblL2.textColor = self.lblL3.textColor = [UIColor blackColor];
    
    if (nL == 2) {
        //2级
        self.lblL2.textColor = [UIColor colorWithHexString:@"#E4393C"];
        _arrayDatas = _myRecInfo.team_first;
    }else{
        self.lblL3.textColor = [UIColor colorWithHexString:@"#E4393C"];
        _arrayDatas = _myRecInfo.team_second;
    }
    [self.tabView reloadData];
}

- (void)getData{
    
}

//推荐
- (void)gesture_rec_onClicked:(id)sender{
    [self.view DLLoadingInSelf];
    [self performSelectorInBackground:@selector(thread_recomment) withObject:nil];
}


#pragma mark uitableview delegate
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 56;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayDatas.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    RecommendInfoModel *model = [_arrayDatas objectAtIndex:indexPath.row];
    MyRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyRecommendCell class])];
    [cell loadData:model];
    
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//主l线程更新
- (void)updateInMain{
    [ImageLoadingUtils loadImage:self.imgAvatar withURL:_myRecInfo.partner_avatar];
    [ImageLoadingUtils loadImage:self.imgTeamLogo withURL:_myRecInfo.team_sign_thumb];
    self.lblNickName.text = _myRecInfo.realname;
    self.lblCorpLevel.text = _myRecInfo.team_title;
    self.lblCorpCount.text = [NSString stringWithFormat:@"战队人数:%d人",_myRecInfo.team_num];
    
    self.lblL2.textColor = [UIColor colorWithHexString:@"#E4393C"];
    _arrayDatas = _myRecInfo.team_first;
    [self.tabView reloadData];
}

//查询
- (void)thread_query{
    _myRecInfo = [[DataViewModel getInstance] myRecommend];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        if (_myRecInfo) {
            [self performSelectorOnMainThread:@selector(updateInMain) withObject:nil waitUntilDone:NO];
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
}

//一键推荐
- (void)thread_recomment{
    NSString *szQRCodeUrl = [[DataViewModel getInstance] partnerQRCode:1 withGoodsId:@""];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view DLLoadingHideInSelf];
        
        if (![Utility isStringEmptyOrNull:szQRCodeUrl]) {
            NSArray *arrayViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([QRCodeView class]) owner:nil options:nil];
            QRCodeView *viewQRCode = [arrayViews objectAtIndex:0];
            [viewQRCode setFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
            [viewQRCode initEvent];
            [viewQRCode loadImage:szQRCodeUrl];
            
            CABasicAnimation *aniScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            aniScale.duration = 0.5f;
            aniScale.fromValue = [NSNumber numberWithFloat:0.1f];
            aniScale.toValue = [NSNumber numberWithFloat:1.0f];
            [viewQRCode.layer addAnimation:aniScale forKey:@"ANI_SCALE"];
            
            [self.view addSubview:viewQRCode];
            
        }else{
            [DLLoading DLToolTipInWindow:[DataViewModel getInstance].ERROR_MSG];
        }
    });
    
}

@end
