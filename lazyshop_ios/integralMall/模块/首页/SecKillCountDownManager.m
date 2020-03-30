//
//  SecKillCountDownManager.m
//  integralMall
//
//  Created by Eggache_Yang on 2017/10/1.
//  Copyright © 2017年 Eggache_Yang. All rights reserved.
//

#import "SecKillCountDownManager.h"

#import "SecKillTimeModel.h"
#import "HomeService.h"

@interface SecKillCountDownManager()

@property (nonatomic,strong) HomeService *homeService;

@property (nonatomic,strong) SecKillTimeModel *timeModel;

@property (nonatomic,assign) BOOL isInKilling;
@property (nonatomic,copy) NSString *killTime;
@property (nonatomic,assign) NSInteger validSeconds;

@property (nonatomic,strong) RACDisposable *timerDispos;

@end

@implementation SecKillCountDownManager

#pragma mark -单例

static SecKillCountDownManager *ccInstance = nil;

+ (SecKillCountDownManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ccInstance             = [[super allocWithZone:NULL] init];
        ccInstance.homeService = [HomeService new];
        [[NSNotificationCenter defaultCenter] addObserver:ccInstance
                                                 selector:@selector(refetchNetTimes)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    });
    
    return ccInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [SecKillCountDownManager sharedInstance];
}

+ (id)copy
{
    return [SecKillCountDownManager sharedInstance];
}

#pragma mark -同步时间
- (void)synTimerWithModel:(SecKillTimeModel *)timeModel
{
    [self endCountDownTimer];
    self.timeModel = timeModel;
    [self checkIsInKilling:YES];
    [self startCountDownTimer];
}

#pragma mark -定时器
// 开始计时
- (void)startCountDownTimer
{
    @weakify(self);
    self.timerDispos = [[RACSignal interval:1. onScheduler:[RACScheduler currentScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        if (self.isInKilling) {
            self.validSeconds--;
            if (self.validSeconds<=0) {
                self.isInKilling = NO;
                self.killTime = nil;
            }
        }else{
            [self checkIsInKilling:NO];
        }
    }];
}
// 结束计时
- (void)endCountDownTimer
{
    [self.timerDispos dispose];
}

#pragma mark -校验是否有进行中的秒杀
- (void)checkIsInKilling:(BOOL)useNetCurrent
{
    // 校验是否有进行中秒杀
    NSDate *currentTimeDate = nil;
    if (useNetCurrent) {
        currentTimeDate = [CommUtls dencodeTime:self.timeModel.current_at];
    }else{
        currentTimeDate = [NSDate date];
    }
    __block BOOL isInKilling = NO;
    __block NSString *killTime = nil;
    __block NSInteger validSeconds = 0;
    __block NSDate *lastTimeDate = nil;
    [self.timeModel.time_slice enumerateObjectsUsingBlock:^(SecKillTimePointModel *pointModel, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *startTimeDate = [CommUtls dencodeTime:pointModel.sell_start_at];
        NSDate *endTimeDate = [CommUtls dencodeTime:pointModel.sell_end_at];
        if ([currentTimeDate timeIntervalSinceDate:startTimeDate]>=0&&[currentTimeDate timeIntervalSinceDate:endTimeDate]<0){
            // 进行中
            isInKilling = YES;
            killTime = [pointModel.time stringByReplacingOccurrencesOfString:@":00" withString:@""];
            validSeconds = [endTimeDate timeIntervalSinceDate:currentTimeDate];
            *stop = YES;
        }else if ([currentTimeDate timeIntervalSinceDate:lastTimeDate]>=0&&[currentTimeDate timeIntervalSinceDate:startTimeDate]<0){
            // 如果现在时间在上个point的结束时间和下个point的开始时间之间 则可设置killTime为下个point的开始时间 供首页显示
            killTime = [pointModel.time stringByReplacingOccurrencesOfString:@":00" withString:@""];
        }
        lastTimeDate = endTimeDate;
    }];
    self.isInKilling = isInKilling;
    self.killTime = killTime;
    self.validSeconds = validSeconds;
    // 如果过完一天 重新请求
    if ([[CommUtls encodeTime:[NSDate date] format:@"hh:mm:ss"] isEqualToString:@"00:00:00"]) {
        [self refetchNetTimes];
    }
}

#pragma mark -获取秒杀时间段
- (RACSignal *)fetchSecKillTimes
{
    @weakify(self);
    return [[self.homeService fetchSecKillTimes] doNext:^(SecKillTimeModel *model) {
        @strongify(self);
        [self synTimerWithModel:model];
    }];
}

#pragma mark -同步服务器时间点
- (void)refetchNetTimes
{
    [[self fetchSecKillTimes] subscribeNext:^(id x) {
        CLog(@"获取服务器秒杀时间点成功");
    }];
}

@end
