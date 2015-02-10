//
//  CarInfoViewController.h
//  SeguesProduct
//
//  Created by Lawrence on 10/2/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCarInfo.h"
#import "SPCar.h"


typedef NS_ENUM(int, SendType)
{
    SPSendFromReplay = 0,
    SPSendFromTrace,
    SPSendFromData,
    SPSendFromRemote
    
};

@interface CarInfoViewController : UIViewController<SPCarDelegate>


-(id)initWithCarInfo:(SPCarInfo *)carInfo;

@end
