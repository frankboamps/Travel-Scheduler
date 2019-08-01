//
//  Schedule.h
//  Travel Scheduler
//
//  Created by gilemos on 7/19/19.
//  Copyright © 2019 aliu18. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"
#import "TravelSchedulerHelper.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ScheduleDelegate;

@interface Schedule : NSObject

@property (strong, nonatomic) NSMutableArray *arrayOfAllPlaces;
@property (strong, nonatomic) NSMutableDictionary *availabilityDictionary;
@property (strong, nonatomic) Place *home;
@property (strong, nonatomic) Place *hub;
@property (nonatomic) int numberOfDays;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (strong, nonatomic) Place *currClosestPlace;
@property (strong, nonatomic) NSNumber *currClosestTravelDistance;
@property (strong, nonatomic) NSMutableDictionary *finalScheduleDictionary;
@property (nonatomic) BOOL indefiniteTime;
@property (strong, nonatomic) NSNumber *currDistance;
@property (strong, nonatomic) NSMutableDictionary *lockedDatePlaces;
@property (nonatomic) TimeBlock currTimeBlock;
@property (strong, nonatomic) NSDate *currDate;
@property (weak, nonatomic) id<ScheduleDelegate> delegate;

- (NSDictionary *)generateSchedule;
- (instancetype)initWithArrayOfPlaces:(NSArray *)completeArrayOfPlaces withStartDate:(NSDate *)startDate withEndDate:(NSDate *)endDate withHome:home;

@end

@protocol ScheduleDelegate

- (void)handleErrorAlert:(Place *)place forDate:(NSDate *)date forTime:(TimeBlock)time;

@end

NS_ASSUME_NONNULL_END
