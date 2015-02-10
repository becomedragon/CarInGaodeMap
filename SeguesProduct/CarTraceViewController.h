//
//  CarTraceViewController.h
//  SeguesProduct
//
//  Created by Lawrence on 10/4/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "SPCarInfo.h"

@interface CarTraceViewController : UIViewController<MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;

-(id)initWithLocation:(NSString *)longitude latitude:(NSString *)latitude;
-(id)initWithCarInfo:(SPCarInfo *)carInfo;

@end
