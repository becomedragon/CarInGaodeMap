//
//  StaticsSecondTableViewController.m
//  SeguesProduct
//
//  Created by 123456 on 14-7-29.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import "StaticsSecondTableViewController.h"
#import "StatisticsDetailViewController.h"
#import "SPCarInfo.h"


@interface StaticsSecondTableViewController (){
    NSMutableArray * textArray;
    NSMutableArray * detailArray;
    NSMutableArray * carInfoArr;
    SourceFrom _source;
}

@end

@implementation StaticsSecondTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initFromSource:(SourceFrom)from{
    
    if (self = [super init]) {
        
        _source = from;
    }
    
    return self;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *myBackBarButtonItem=[[UIBarButtonItem alloc] init];
    myBackBarButtonItem.title=@"返回";
    self.navigationItem.backBarButtonItem = myBackBarButtonItem;
    /*
    textArray = [[NSArray alloc] initWithObjects:@"申沃SWB6107SHEV1-1#", @"申沃SWB6107SHEV1-3#",
                 @"申沃SWB6107SHEV1-8#", @"申沃SWB6107SHEV1-7#", @"申沃SWB6107SHEV1-5#", @"申沃SWB6107SHEV1-4#", @"申沃SWB6107SHEV1-2#",
                 @"申沃SWB6107SHEV1-6#" , nil];
    detailArray= [[NSArray alloc] initWithObjects:@"离线", @"离线",
                  @"在线", @"离线",@"离线", @"在线",@"离线", @"在线",nil];
     */
    
    textArray = [NSMutableArray array];
    detailArray = [NSMutableArray array];
    carInfoArr = [NSMutableArray array];
    
    textArray = [[self getCarName] mutableCopy];
    detailArray = [[self getCarStatus] mutableCopy];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    switch (_source) {
        case 8:
            self.navigationItem.title = @"车辆统计";
            break;
        case 9:
            self.navigationItem.title = @"里程统计";
            break;
        case 10:
            self.navigationItem.title = @"故障统计";
            break;
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark getCarInfo
-(NSArray *)getCarName{
    
    NSArray * carArr = [SPCarInfo getFile];
    NSMutableArray * carsArr = [NSMutableArray array];
    for (SPCarInfo * car in carArr) {
        
        [carsArr addObject:car.carName];
        [carInfoArr addObject:car];  // for cell select
        
        
    }
    
    return [carsArr copy];
}

-(NSArray *)getCarStatus{
    
    
    NSArray * carArr = [SPCarInfo getFile];
    NSMutableArray * carsArr = [NSMutableArray array];
    for (SPCarInfo * car in carArr) {
        
        switch (car.carStatus.intValue) {
            case 0:
                [carsArr addObject:@"离线"];
                break;
            case 1:
                [carsArr addObject:@"在线"];
                break;
            default:
                [carsArr addObject:@"故障"];
                break;
        }
        
    }
    
    return [carsArr copy];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return textArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"StaticsSecondCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:TableSampleIdentifier];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [textArray objectAtIndex:row];
    cell.detailTextLabel.text = [detailArray objectAtIndex:row];
    UIImage * image;
    if ([cell.detailTextLabel.text isEqualToString:@"在线"]) {
        
        image = [UIImage imageNamed:@"green.png"];
    }
    else if([cell.detailTextLabel.text isEqualToString:@"离线"]){
        
        image = [UIImage imageNamed:@"red.png"];
    }
    else{
        
        image = [UIImage imageNamed:@"yellow.png"];
    }
    cell.imageView.image = image;
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SPCarInfo * ci = [carInfoArr objectAtIndex:indexPath.row];
    NSString * carVin = ci.carVin;
    /*
    StatisticsDetailViewController * statisticVC = [[StatisticsDetailViewController alloc] initWithSource:_source andCarVin:carVin];
     */
    StatisticSettingViewController  * sSetting = [[StatisticSettingViewController alloc] initWithSourceFrom:_source andCarVin:carVin];
    [self.navigationController pushViewController:sSetting animated:YES];
    
}


@end
