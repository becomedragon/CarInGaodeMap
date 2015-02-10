//
//  SPCar.h
//  SeguesProduct
//
//  Created by Lawrence on 14-9-27.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPCarDelegate <NSObject>

-(void)getCatrInfo:(NSString *)result;


@end

@interface SPCar : NSObject
@property(nonatomic,weak) id<SPCarDelegate> delegate;

-(void)getCarsLocationWithUserName:(NSString *)username andAuth:(NSString *)auth;

-(void)getCarsRoute:(NSString *)carVin startTime:(NSString *)startTime endTime:(NSString *)endTime; //回放

-(void)getCarsData:(NSString *)carVin; //参数信息


@end
