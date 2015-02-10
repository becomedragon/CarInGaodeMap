//
//  SetttingDataViewController.h
//  SeguesProduct
//
//  Created by Lawrence on 11/4/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>


@interface SetttingDataViewController : UIViewController

-(id)initWithCarName:(NSString *)carName andStartPoint:(CLLocationCoordinate2D)startPoi andEndPoint:(CLLocationCoordinate2D)endPoi;

@end
