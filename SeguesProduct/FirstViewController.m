//
//  FirstViewController.m
//  SeguesProduct
//
//  Created by 123456 on 14-7-28.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import "FirstViewController.h"
#import "ZSPageScrollView.h"
#import "SPCarInfo.h"

@interface FirstViewController (){
    NSArray *textArray;
    NSArray *detailArray;
}

@end

@implementation FirstViewController

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
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {self.edgesForExtendedLayout=UIRectEdgeNone;    }
    NSMutableArray *imageArray=[[NSMutableArray alloc]initWithObjects:@"intro1.jpg",@"intro2.jpg",@"intro3.jpg",@"intro4.jpg", nil];
    ZSPageScrollView *pageScroll = [[ZSPageScrollView alloc] initWithFrame:CGRectMake(3, 3, 308, 120) imageArray:imageArray];
    textArray = [[NSArray alloc] initWithObjects:@"用户名", @"登录时间",
                 @"车辆总数", @"车辆在线", @"车辆离线", @"车辆故障", @"联系方式",nil];
    
    //首页信息
    NSString * userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    NSMutableString * date = [[NSString stringWithFormat:@"%@",[NSDate date]] mutableCopy];
    NSRange rang;
    rang.length = 10;
    rang.location = 0;
    date = [[date substringWithRange:rang] mutableCopy];
    
    int carAmount =0,offlineCar = 0,problemCar = 0;
    NSArray * carInfoArr = [SPCarInfo getFile];
    carAmount = [carInfoArr count];
    for (SPCarInfo * car in carInfoArr) {
        
        switch (car.carStatus.intValue) {
            case 0:
                offlineCar += 1;
                break;
            case 1:
                break;
            default:
                problemCar += 1;
                break;
        }
    }
    
    
    NSLog(@"username %@  date %@",userName,date);
    detailArray = [[NSArray alloc] initWithObjects:userName,date, [NSString stringWithFormat:@"%d",carAmount],
                 [NSString stringWithFormat:@"%d",carAmount-offlineCar-problemCar], [NSString stringWithFormat:@"%d",offlineCar], [NSString stringWithFormat:@"%d",problemCar], @"021-51650052",nil];
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,132,320,screenHeight-246)style:(UITableViewStylePlain)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate=self;
    tableView.dataSource=self;
    if (iPhone5) {
        tableView.scrollEnabled=NO;
    }
    [self.view addSubview:pageScroll];
    [self.view addSubview:tableView];
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
    static NSString *TableSampleIdentifier = @"FirstViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    NSUInteger row = [indexPath row];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 44)];
    UILabel *middleLabel=[[UILabel alloc]initWithFrame:CGRectMake(130, 0, 20, 44)];
    UILabel *detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(150, 0, 170, 44)];
    titleLabel.text = [textArray objectAtIndex:row];
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    titleLabel.textAlignment=NSTextAlignmentRight;
    middleLabel.text = @":";
    middleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    middleLabel.textAlignment=NSTextAlignmentCenter;
    detailLabel.text = [detailArray objectAtIndex:row];
    detailLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    detailLabel.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:titleLabel];
    [cell.contentView addSubview:middleLabel];
    [cell.contentView addSubview:detailLabel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
