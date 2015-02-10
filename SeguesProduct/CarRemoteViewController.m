//
//  CarRemoteViewController.m
//  SeguesProduct
//
//  Created by Lawrence on 10/4/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import "CarRemoteViewController.h"
#import "MBProgressHUD.h"

@interface CarRemoteViewController ()

@end

@implementation CarRemoteViewController

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
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"远程设置";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma button method
- (IBAction)remoteDefend:(id)sender {
    
    MBProgressHUD * hud = [[MBProgressHUD alloc] init];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"设防成功";
    [hud hide:YES afterDelay:1];
    
}

- (IBAction)cancelDefend:(id)sender {
    
    MBProgressHUD * hud = [[MBProgressHUD alloc] init];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"取消设防";
    [hud hide:YES afterDelay:1];
    
}
- (IBAction)remoteOffPower:(id)sender {
    
    MBProgressHUD * hud = [[MBProgressHUD alloc] init];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"断油电成功";
    [hud hide:YES afterDelay:1];
    
}
- (IBAction)recoverPower:(id)sender {
    
    MBProgressHUD * hud = [[MBProgressHUD alloc] init];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"恢复油电";
    [hud hide:YES afterDelay:1];
    
}

- (IBAction)remoteTakePhoto:(id)sender {
    
    MBProgressHUD * hud = [[MBProgressHUD alloc] init];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"拍照成功";
    [hud hide:YES afterDelay:1];
    
}


@end
