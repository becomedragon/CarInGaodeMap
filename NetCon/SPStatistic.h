//
//  SPStatistic.h
//  SeguesProduct
//
//  Created by Lawrence on 10/5/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPStatisticDelegate <NSObject>

-(void)getStatisticInfo:(NSString *)statisticInfo;

@end

@interface SPStatistic : NSObject

@property(nonatomic,weak) id<SPStatisticDelegate> delegate;

-(void)getCarSpeedStatisticInfoWithCarVin:(NSString *)carVin andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime;
-(void)getCarMilesStatisticInfoWithCarVin:(NSString *)carVin andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime;
-(void)getCarWarningStatisticInfoWithCarVin:(NSString *)carVin andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime;

-(void)getCarStatisticInfoType:(int)type WithCarVin:(NSString *)carVin andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime;

@end
