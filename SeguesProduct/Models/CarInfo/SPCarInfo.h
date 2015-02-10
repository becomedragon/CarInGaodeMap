//
//  SPCarInfo.h
//  SeguesProduct
//
//  Created by Lawrence on 14-9-29.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCarInfoCacheFile @"kCarInfoCacheFile"

@interface SPCarInfo : NSObject<NSCoding>

@property(nonatomic,copy)NSString * carVin;
@property(nonatomic,copy)NSString * longitude;
@property(nonatomic,copy)NSString * latitude;
@property(nonatomic,copy)NSString * carName;
@property(nonatomic,copy)NSString * carStatus;
@property(nonatomic,copy)NSString * motorcade;
@property(nonatomic,copy)NSString * GPSSpeed;
@property(nonatomic,copy)NSString * orintation;

/*
 车辆VIN；经度；纬度；车辆名称；车辆状态；车队名称；GPS车速 航向
 */

+(void)cacheFile:(NSArray *)arr;
+(NSArray *)getFile;

@end
