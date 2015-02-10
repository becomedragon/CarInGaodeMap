//
//  SettingDetailViewController.m
//  SeguesProduct
//
//  Created by 123456 on 14-7-29.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import "SettingDetailViewController.h"

@interface SettingDetailViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *updateSwitch;

@end

@implementation SettingDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {self.edgesForExtendedLayout=UIRectEdgeNone;    }
    // Do any additional setup after loading the view.
    
    NSNumber * update = [[NSUserDefaults standardUserDefaults] objectForKey:@"update"];
    if (update.boolValue) {
        
        [self.updateSwitch setOn:YES];
    }
    else{
        
        [self.updateSwitch setOn:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)isNeedUpdate:(UISwitch *)sender {    //软件更新开关
    
    NSNumber * update = [[NSUserDefaults standardUserDefaults] objectForKey:@"update"];
    if (update.boolValue) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"update"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"update"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

- (IBAction)zhuanLu:(UISwitch *)sender {        //抓路纠错
}

@end
