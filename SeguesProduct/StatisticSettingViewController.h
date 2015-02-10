//
//  StatisticSettingViewController.h
//  SeguesProduct
//
//  Created by Lawrence on 10/5/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChartDelegate.h"
#import "PNChart.h"

typedef NS_ENUM(int, SourceFrom){
    
    SourceFromCarSpeed = 8,
    SourceFromCarMiles,
    SourceFromCarWarning
};

@interface StatisticSettingViewController : UIViewController

@property (nonatomic) PNBarChart * barChart;

-(id)initWithSourceFrom:(SourceFrom)from andCarVin:(NSString *)carVin;
@end
