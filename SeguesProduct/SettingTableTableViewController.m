//
//  SettingTableTableViewController.m
//  SeguesProduct
//
//  Created by 123456 on 14-7-29.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import "SettingTableTableViewController.h"
#import "SettingDetailViewController.h"
#import "SettingDetailSecondController.h"
#import "SettingDetailThirdController.h"
#import "SettingDetailForthController.h"


@interface SettingTableTableViewController ()<UIAlertViewDelegate>{
    NSArray *textArray;
    NSArray * cellImageArr;
    
    UIAlertView *alert;
}

@end

@implementation SettingTableTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *myBackBarButtonItem=[[UIBarButtonItem alloc] init];
    myBackBarButtonItem.title=@"返回";
    self.navigationItem.backBarButtonItem = myBackBarButtonItem;
    textArray = [[NSArray alloc] initWithObjects:@"软件设置", @"反馈意见",
                 @"关于软件", @"软件更新", @"帮助", nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return textArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"SettingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [textArray objectAtIndex:row];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *settingDetailViewController;
    
     NSNumber * update = [[NSUserDefaults standardUserDefaults] objectForKey:@"update"];
    
    switch (indexPath.row) {
        case 0:
            settingDetailViewController = (SettingDetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SettingDetailViewController"];
            
            break;
        case 1:
            settingDetailViewController = (SettingDetailSecondController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SettingDetailSecondController"];
            
            break;
        case 2:
            settingDetailViewController = (SettingDetailThirdController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SettingDetailThirdController"];
            
            break;
        case 3:
            if (update.boolValue) {
                alert = [[UIAlertView alloc] initWithTitle:@"版本更新"
                                                   message:@"当前版本：1.4.1，发现新版本：1.4.3，是否更新"
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles:@"确定",nil];
                [alert show];

                
            }
        break;
            
        case 4:
            settingDetailViewController = (SettingDetailForthController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SettingDetailForthController"];
            
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:settingDetailViewController animated:YES];
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
    
}


@end
