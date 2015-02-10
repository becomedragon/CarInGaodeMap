//
//  CarDataViewController.h
//  SeguesProduct
//
//  Created by Lawrence on 10/3/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarDataViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>


-(id)initWithCarName:(NSString *)carName;

@end
