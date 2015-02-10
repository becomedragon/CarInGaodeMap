//
//  NavigationViewController.h
//  SearchV3Demo
//
//  Created by songjian on 13-8-14.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "BaseMapViewController.h"

@interface NavigationViewController : BaseMapViewController


-(id)initWithStartCoordinate:(CLLocationCoordinate2D)startPoint andDestinationCoordinate:(CLLocationCoordinate2D)endPoint;

@end
