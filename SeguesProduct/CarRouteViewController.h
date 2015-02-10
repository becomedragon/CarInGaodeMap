//
//  CarRouteViewController.h
//  SeguesProduct
//
//  Created by Lawrence on 10/31/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import "BaseMapViewController.h"

@interface CarRouteViewController : BaseMapViewController

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;

-(id)initWithLocation:(NSString *)longitude latitude:(NSString *)latitude;

@end
