//
//  ChartViewController.h
//  SeguesProduct
//
//  Created by Lawrence on 10/5/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatisticSettingViewController.h"

@interface ChartViewController : UIViewController

@property(nonatomic,strong)UIScrollView * scrollView;;

-(id)initWithSourceFrom:(SourceFrom)source;

@end
