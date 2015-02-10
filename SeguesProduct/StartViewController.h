//
//  StartViewController.h
//  SeguesProduct
//
//  Created by 徐蒙特 on 14-9-8.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPUser.h"
#import "SPCar.h"

@interface StartViewController : UIViewController <SPUserDelegate,SPCarDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
- (IBAction)userNameAction:(id)sender;
- (IBAction)passWordAction:(id)sender;
- (IBAction)rememberAction:(id)sender;
- (IBAction)loginAction:(id)sender;

@end
