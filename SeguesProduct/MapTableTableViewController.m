//
//  MapTableTableViewController.m
//  SeguesProduct
//
//  Created by 123456 on 14-7-29.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import "MapTableTableViewController.h"
#import "MapHtmlViewController.h"
#import "SPCarInfo.h"
#import "CarInfoViewController.h"
#import "CarTraceViewController.h"



@interface MapTableTableViewController (){
    NSMutableArray *textArray;
    NSMutableArray *detailArray;
    NSMutableArray * carInfoArr;
  
    BOOL _showErrorCar;
    
}

@end

@implementation MapTableTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _showErrorCar = NO;
    }
    return self;
}


-(id)initWithShowErrorCarList{
    
    if (self = [super init]) {
        
        _showErrorCar = YES;
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *myBackBarButtonItem=[[UIBarButtonItem alloc] init];
    myBackBarButtonItem.title=@"返回";
    self.navigationItem.backBarButtonItem = myBackBarButtonItem;
    
    textArray = [[NSMutableArray alloc] init];
    detailArray = [[NSMutableArray alloc] init];
    carInfoArr = [[NSMutableArray alloc] init];
    
    /*
    textArray = [[NSMutableArray alloc] initWithObjects:@"申沃SWB6107SHEV1-1#", @"申沃SWB6107SHEV1-3#",
                 @"申沃SWB6107SHEV1-8#", @"申沃SWB6107SHEV1-7#", @"申沃SWB6107SHEV1-5#", @"申沃SWB6107SHEV1-4#", @"申沃SWB6107SHEV1-2#",
                 @"申沃SWB6107SHEV1-6#" , nil];
     */
    
        // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)viewWillAppear:(BOOL)animated{
    
   
    textArray = [[self getCarName] mutableCopy];
    detailArray = [[self getCarStatus] mutableCopy];
    [self.tableView reloadData];
    
    //[_spCar getCarsListWithUserName:[[NSUserDefaults standardUserDefaults] objectForKey:@"name"] andCategoryNum:@"1"];
    
   
    
    
}

#pragma mark - 
#pragma mark getCarInfo
-(NSArray *)getCarName{
    
    NSArray * carArr = [SPCarInfo getFile];
    NSMutableArray * carsArr = [NSMutableArray array];
    for (SPCarInfo * car in carArr) {
        
        if (_showErrorCar) {
           
            if (car.carStatus.intValue != 0 && car.carStatus.intValue != 1) {
                
                [carsArr addObject:car.carName];
                [carInfoArr addObject:car];  // for cell select
            }
        }
        else{
            
            [carsArr addObject:car.carName];
            [carInfoArr addObject:car];  // for cell select
        }
        
        
    }
    
    return [carsArr copy];
}

-(NSArray *)getCarStatus{
    
    
    NSArray * carArr = [SPCarInfo getFile];
    NSMutableArray * carsArr = [NSMutableArray array];
    for (SPCarInfo * car in carArr) {
        
        if (_showErrorCar) {
            
            if (car.carStatus.intValue != 0 && car.carStatus.intValue != 1) {
                
                [carsArr addObject:@"故障"];
            }
        }
        else{
           
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
        
    }
    
    return [carsArr copy];
    
}

#pragma mark -
#pragma mark delegateMethod
-(void)getCatrInfo:(NSString *)result{
    
    NSLog(@"result is %@",result);
    
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
    
    // Return the number of rows in the section.
    return textArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"MapTabCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
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
    
    
    /*
    CarInfoViewController * carVC = [[CarInfoViewController alloc] initWithCarInfo:[carInfoArr objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:carVC animated:YES];
    */
    
    SPCarInfo * _carInfo =  [carInfoArr objectAtIndex:indexPath.row];
    CarTraceViewController * carTrace = [[CarTraceViewController alloc] initWithCarInfo:_carInfo];
    [self.navigationController pushViewController:carTrace animated:YES];
    
    
    
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

@end
