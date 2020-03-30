//
//  ScoreSignInCalendarViewModel.m
//  integralMall
//
//  Created by Eggache_Yang on 2018/6/2.
//  Copyright © 2018年 Eggache_Yang. All rights reserved.
//

#import "ScoreSignInCalendarViewModel.h"

#import "DateListTools.h"

#import "ScoreSingInDateItemModel.h"

@interface ScoreSignInCalendarViewModel ()

@property (nonatomic, assign) NSInteger currentYear;
@property (nonatomic, assign) NSInteger currentMonth;
@property (nonatomic, assign) NSInteger currentDay;
@property (nonatomic, assign) BOOL todaySigned;

@end

@implementation ScoreSignInCalendarViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getDateInformation];
        [self getBaseDateItems];
    }
    return self;
}

-(void)getDateInformation
{
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:dt];
    // 设置当前年月日
    self.currentYear = comp.year;
    self.currentMonth = comp.month;
    self.currentDay = comp.day;
}

-(void)getBaseDateItems
{
    NSMutableArray *resultArray = [NSMutableArray array];
    // 日期头
    NSArray *weekHeaderTitles = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i = 0; i < weekHeaderTitles.count; i++) {
        ScoreSingInDateItemModel *model = [ScoreSingInDateItemModel new];
        model.titleColorString = APP_MainColor;
        model.title = [weekHeaderTitles objectAtIndex:i];
        if (i == weekHeaderTitles.count - 1) {
            model.hideRightLine = YES;
        }
        [resultArray addObject:model];
    }
    // 日期数目
    NSInteger dateItemsCount = 7*6;
    // 当月有多少天
    NSInteger currentMonthDays = [DateListTools getDaysInMonth:self.currentYear
                                                         month:self.currentMonth];
    // 上月有多少天
    NSInteger lastMonthDays;
    if (self.currentMonth == 1) {
        lastMonthDays = 31;
    }else{
        lastMonthDays = [DateListTools getDaysInMonth:self.currentYear
                                                month:self.currentMonth-1];
    }
    
    NSInteger weekDay = [DateListTools GetTheWeekOfDayByYera:self.currentYear
                                                  andByMonth:self.currentMonth];
    NSInteger numberOfLastMonth = weekDay;
    NSInteger numberOfNextMonth = dateItemsCount - weekDay - currentMonthDays;
    // 日历最后一行容错
    if (numberOfNextMonth >= 7) {
        dateItemsCount = dateItemsCount - 7;
        numberOfNextMonth = numberOfNextMonth - 7;
    }
    // 组装初步的数据源
    for (int index = 0; index < dateItemsCount; index++)
    {
        NSInteger monthTag = index+1;
        ScoreSingInDateItemModel *model = [ScoreSingInDateItemModel new];
        // 是否显示右线
        if (monthTag % 7 == 0) {
            model.hideRightLine = YES;
        }
        if (monthTag < numberOfLastMonth+1) {
            // 上月
            model.title = [NSString stringWithFormat:@"%ld",lastMonthDays-numberOfLastMonth+monthTag];
            model.titleColorString = @"#e6e6e6";
            if (self.currentMonth == 1) {
                model.sign_in_time = [NSString stringWithFormat:@"%ld-12-%02ld",self.currentYear-1,[model.title integerValue]];
            }else{
                model.sign_in_time = [NSString stringWithFormat:@"%ld-%02ld-%02ld",self.currentYear-1,self.currentMonth-1,[model.title integerValue]];
            }
        }else if (numberOfLastMonth < monthTag && monthTag< dateItemsCount-numberOfNextMonth+1){
            // 本月
            model.title = [NSString stringWithFormat:@"%ld",index-numberOfLastMonth+1];
            if (model.title.integerValue == self.currentDay) {
                model.titleColorString = APP_MainColor;
            }else{
                model.titleColorString = @"#808080";
            }
            model.sign_in_time = [NSString stringWithFormat:@"%ld-%02ld-%02ld",self.currentYear,self.currentMonth,[model.title integerValue]];
        }else {
            // 下月
            model.title = [NSString stringWithFormat:@"%ld",monthTag-currentMonthDays-numberOfLastMonth] ;
            model.titleColorString = @"#e6e6e6";
            if (self.currentMonth == 12) {
                model.sign_in_time = [NSString stringWithFormat:@"%ld-01-%02ld",self.currentYear+1,[model.title integerValue]];
            }else{
                model.sign_in_time = [NSString stringWithFormat:@"%ld-%02ld-%02ld",self.currentYear,self.currentMonth+1,[model.title integerValue]];
            }
        }
        [resultArray addObject:model];
    }
    
    self.dataArray = [NSArray arrayWithArray:resultArray];
}

#pragma mark -映射是否签到
- (void)reloadSignedMsgWithModels:(NSArray *)signedModels
{
    @weakify(self);
    [self.dataArray enumerateObjectsUsingBlock:^(ScoreSingInDateItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL is = [signedModels linq_any:^BOOL(ScoreSingInDateItemModel *signedObj) {
            return [signedObj.sign_in_time isEqualToString:obj.sign_in_time];
        }];
        if (is) {
            obj.hasSignIn = YES;
            if ([obj.sign_in_time isEqualToString:[CommUtls encodeTime:[NSDate date]
                                                                format:@"yyyy-MM-dd"]]) {
                @strongify(self);
                self.todaySigned = YES;
            }
        }
    }];
}

@end
