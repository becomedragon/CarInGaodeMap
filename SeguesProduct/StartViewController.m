//
//  StartViewController.m
//  SeguesProduct
//
//  Created by 徐蒙特 on 14-9-8.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import "StartViewController.h"
#import "MBProgressHUD.h"
#import "SPCarInfo.h"


@interface StartViewController ()<UIAlertViewDelegate>
{
    NSURLConnection *connection;
    NSMutableData *receiveData;
    MBProgressHUD * _hud;
    SPUser * _spUser;
    SPCar * _spCar;
}
@end

@implementation StartViewController

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
    // Do any additional setup after loading the view.
    _spUser = [[SPUser alloc] init];
    _spUser.delegate = self;
    _hud = [[MBProgressHUD alloc] init];
    
    _spCar = [[SPCar alloc] init];
    _spCar.delegate = self;
    
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"update"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"update"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{    //保留用户名密码
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"name"]) {
        
        self.userName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"password"]) {
        
        self.passWord.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
    NSNumber * update = [[NSUserDefaults standardUserDefaults] objectForKey:@"update"];
    if (update.boolValue) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"版本更新"
                                                         message:@"当前版本：1.4.1，发现新版本：1.4.3，是否更新"
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确定",nil];
        [alert show];

    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark alterView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        NSString *str = @"https://itunes.apple.com/us/app/golf-gps-scorecard-swing-by/id332116103?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)userNameAction:(id)sender {
    [self.passWord becomeFirstResponder];
}

- (IBAction)passWordAction:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)rememberAction:(id)sender {
}

- (IBAction)loginAction:(id)sender {
    /*
    if ([self.userName.text isEqualToString:@""]||[self.passWord.text isEqualToString:@""]) {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名密码不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else
    {
        if ([self.userName.text isEqualToString:@"sunwin"]&&[self.passWord.text isEqualToString:@"sunwin"]) {
            UITabBarController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
            [self presentViewController:mainViewController animated:YES completion:nil];
        }else
        {
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名密码错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }
    */
    
    
    if (!self.userName.text.length||!self.passWord.text) {
        
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else{
        
        
        [_spUser logonWithName:self.userName.text AndPassword:self.passWord.text];
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.mode = MBProgressHUDModeIndeterminate;
        _hud.labelText = @"正在登陆";
        [_hud show:YES];
}
    

}

#pragma mark - 
#pragma mark delegate Method
-(void)getLogonResultFromServer:(NSString *)result{
    [_hud hide:YES];
    

    if ([result isEqual:@"[passerror]\r\n"] || [result isEqual:@"passerror\r\n"]) {
        
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([result isEqual:@"[error]\r\n"] || [result isEqual:@"error\r\n"]){
        
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"无此用户！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else{
        
        
        UITabBarController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
        [self presentViewController:mainViewController animated:YES completion:nil];
        NSRange rang;
        rang.length = 1;
        rang.location = 1;
        NSString * auth = [result substringWithRange:rang];
        
        //记录登录信息
        [[NSUserDefaults standardUserDefaults] setObject:auth forKey:@"auth"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.userName.text forKey:@"name"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [[NSUserDefaults standardUserDefaults] setObject:self.passWord.text forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self sendCarInfo];
    }

    NSLog(@"result is %@ auth is %@",result,[[NSUserDefaults standardUserDefaults] objectForKey:@"auth"]);
    
}


-(void)sendCarInfo{
    
    [_spCar getCarsLocationWithUserName:[[NSUserDefaults standardUserDefaults] objectForKey:@"name"] andAuth:[[NSUserDefaults standardUserDefaults] objectForKey:@"auth"]];
    
    
}

-(void)getCatrInfo:(NSString *)result{
    
    NSLog(@"result is %@",result);
    NSRange rang;
    rang.location = 1;
    rang.length = result.length-1;
    NSMutableString * carInfoStr = [[result substringWithRange:rang] mutableCopy];
    NSArray * carInfoArr = [carInfoStr componentsSeparatedByString:(@",")];
    
    [SPCarInfo cacheFile:carInfoArr];
    
    
}

#pragma mark - 
#pragma mark useless
//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSLog(@"connection:%@",[res allHeaderFields]);
    receiveData = [NSMutableData data];
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receiveData appendData:data];
}
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection
 didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",[error localizedDescription]);
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查网络连接！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
@end
