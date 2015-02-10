//
//  CarDataViewController.m
//  SeguesProduct
//
//  Created by Lawrence on 10/3/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import "CarDataViewController.h"

@interface CarDataViewController (){
    
    NSMutableArray * batteryArr;
    NSMutableArray * motorArr;
    NSMutableArray * warningArr;
    
    NSMutableArray * batteryDetailArr;
    NSMutableArray * motorDetailArr;
    
    NSString * _carNameStr;
}

@property (weak, nonatomic) IBOutlet UIScrollView *carDataScrollView;
@property (strong, nonatomic) IBOutlet UIView *carSpeed;
@property (strong, nonatomic) IBOutlet UIView *carBattery;
@property (strong, nonatomic) IBOutlet UIView *carMotor;
@property (strong, nonatomic) IBOutlet UIView *carWarning;
@property (strong, nonatomic) IBOutlet UIView *carOther;

@property (weak, nonatomic) IBOutlet UIButton *speedBtn;
@property (weak, nonatomic) IBOutlet UIButton *batteryBtn;
@property (weak, nonatomic) IBOutlet UIButton *motorBtn;
@property (weak, nonatomic) IBOutlet UIButton *carWarningBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;

@property (weak, nonatomic) IBOutlet UITableView *batteryTableView;

@property (weak, nonatomic) IBOutlet UITableView *motorTableView;
@property (weak, nonatomic) IBOutlet UITableView *warningTableView;

@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

@property (weak, nonatomic) IBOutlet UILabel *carName;
@end


@implementation CarDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCarName:(NSString *)carName{
    
    if ((self = [super init])) {
        
        _carNameStr = carName;
    }
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.carName.text = _carNameStr;
    // Do any additional setup after loading the view from its nib.
    _carDataScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 5, 471);
    [_carSpeed setFrame:CGRectMake(0, 0, 320, 471)];
    [_carBattery setFrame:CGRectMake(320, 0, 320, 471)];
    [_carMotor setFrame:CGRectMake(320*2, 0, 320, 471)];
    [_carWarning setFrame:CGRectMake(320*3, 0, 320, 471)];
    [_carOther setFrame:CGRectMake(320*4, 0, 320, 471)];
    
    
    [_carDataScrollView addSubview:_carSpeed];
    [_carDataScrollView addSubview:_carBattery];
    [_carDataScrollView addSubview:_carMotor];
    [_carDataScrollView addSubview:_carWarning];
    [_carDataScrollView addSubview:_carOther];
    
    _carDataScrollView.pagingEnabled = YES;
    _carDataScrollView.delegate = self;
    [_speedBtn setBackgroundColor:[UIColor grayColor]];
    
    
    
    batteryArr = [[NSMutableArray alloc] initWithObjects:@"总线电压",@"电机控制电压",@"电机控制电流",@"储能系统温度",@"SOC",@"储能电流",@"发电机电流",@"电池模块编号",@"电池模块电压",@"电池模块温度",@"电池模块电压",@"超级电容电流",@"DC/AC输出电流",@"DC/AC散热温度",@"电池模块报警信息",@"DC/AC输入电压状态", nil];
    
    
    motorArr = [[NSMutableArray alloc] initWithObjects:@"总线电压",@"电机控制电压",@"电机控制电流",@"电机转速",@"电机温度",@"SOC",@"档位",@"车辆状态",@"整车控制器LIFE",@"加速踏板",@"发送机目标油门",@"发动机实际油门",@"储能系统电流",@"发电机电流",@"发电机控制器温度",@"整车控制模式指令",@"发动机目标转速",@"发动机目标转矩输出比",@"发送机转速",@"油门状态",@"油门位置",@"发送机负荷率",@"远程油门位置",@"发动机冷却水温",@"发动机燃油温度",@"发动机油温",@"中冷器温度",@"发动机油耗率",@"总燃油消耗量", nil];
    
    
    warningArr = [[NSMutableArray alloc] initWithObjects:@"总线电压",@"电机控制电压",@"电机控制电流",@"储能系统温度",@"SOC",@"储能电流",@"发电机电流",@"电池模块编号",@"电池模块电压",@"电池模块温度",@"电池模块电压",@"超级电容电流",@"DC/AC输出电流",@"DC/AC散热温度",@"电池模块报警信息",@"DC/AC输入电压状态", nil];
    
    batteryDetailArr = [[NSMutableArray alloc] initWithObjects:@"25",@"30",@"56",@"70",@"36",@"89",@"23",@"1234",@"50",@"23",@"50",@"40",@"3",@"3",@"3",@"正常",@"3", nil];
    motorDetailArr = [[NSMutableArray alloc] initWithObjects:@"25",@"30",@"56",@"70",@"36",@"89",@"23",@"1234",@"50",@"23",@"50",@"40",@"3",@"3",@"3",@"正常",@"3",@"正常",@"12",@"45",@"67",@"54",@"合格",@"67",@"98",@"正常",@"89",@"87",@"45",@"合格",@"3",@"3",nil];
    
    
    /*
    batteryArr = @{@"总线电压",@"电机控制电压",@"电机控制电流",@"储能系统温度",@"SOC",@"储能电流",@"发电机电流",@"电池模块编号",@"电池模块电压",@"电池模块温度",@"电池模块电压",@"超级电容电流",@"DC/AC输出电流",@"DC/AC散热温度",@"电池模块报警信息",@"DC/AC输入电压状态"};
     */
    
    //tableView
    _batteryTableView.delegate = self;
    _batteryTableView.dataSource = self;
    
    _motorTableView.delegate = self;
    _motorTableView.dataSource = self;
    
    _warningTableView.delegate = self;
    _warningTableView.dataSource = self;
    
    
    self.navigationItem.title = @"参数信息";
    NSString * speedStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"GPSSpeed"];
    _speedLabel.text = speedStr;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark button method
- (IBAction)carSpeed:(id)sender {
    
    [_carDataScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self resetButtonBg];
    [_speedBtn setBackgroundColor:[UIColor grayColor]];
    
    
}
- (IBAction)carBattery:(id)sender {
    
    [_carDataScrollView setContentOffset:CGPointMake(320, 0) animated:YES];
    [self resetButtonBg];
    [_batteryBtn setBackgroundColor:[UIColor grayColor]];
    
    
}
- (IBAction)carMotor:(id)sender {
    
    [_carDataScrollView setContentOffset:CGPointMake(320*2, 0) animated:YES];
    [self resetButtonBg];
    [_motorBtn setBackgroundColor:[UIColor grayColor]];
    
}
- (IBAction)carWarning:(id)sender {
    
    [_carDataScrollView setContentOffset:CGPointMake(320*3, 0) animated:YES];
    [self resetButtonBg];
    [_carWarningBtn setBackgroundColor:[UIColor grayColor]];
    
}
- (IBAction)carOther:(id)sender {

    [_carDataScrollView setContentOffset:CGPointMake(320*4, 0) animated:YES];
    [self resetButtonBg];
    [_otherBtn setBackgroundColor:[UIColor grayColor]];
}


-(void)resetButtonBg{
    
    [_speedBtn setBackgroundColor:[UIColor clearColor]];
    [_batteryBtn setBackgroundColor:[UIColor clearColor]];
    [_motorBtn setBackgroundColor:[UIColor clearColor]];
    [_carWarningBtn setBackgroundColor:[UIColor clearColor]];
    [_otherBtn setBackgroundColor:[UIColor clearColor]];
    
}


#pragma mark - 
#pragma mark scroll view delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == _carDataScrollView) {
        
    
    int off = scrollView.contentOffset.x/320;
    
    switch (off) {
        case 0:
            [self resetButtonBg];
            [_speedBtn setBackgroundColor:[UIColor grayColor]];
            break;
        case 1:
            [self resetButtonBg];
            [_batteryBtn setBackgroundColor:[UIColor grayColor]];
            break;
        case 2:
            [self resetButtonBg];
            [_motorBtn setBackgroundColor:[UIColor grayColor]];
            break;
        case 3:
            [self resetButtonBg];
            [_carWarningBtn setBackgroundColor:[UIColor grayColor]];
            break;
        case 4:
            [self resetButtonBg];
            [_otherBtn setBackgroundColor:[UIColor grayColor]];
            break;
        default:
            break;
    }

    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}


#pragma mark - 
#pragma mark tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == _batteryTableView) {
        return [batteryArr count];
    }
    else if(tableView == _motorTableView){
        
        return [motorArr count];
    }
    else{
        
        return [warningArr count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"carCell"];
    if (tableView == _batteryTableView) {
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"carCell"];
        }
        cell.textLabel.text = [batteryArr objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [batteryDetailArr objectAtIndex:indexPath.row];
        cell.image = [UIImage imageNamed:@"d1.png"];
        
        
    }
    else if(tableView == _motorTableView){
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"carCell"];
        }
        cell.textLabel.text = [motorArr objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [motorDetailArr objectAtIndex:indexPath.row];
        cell.image = [UIImage imageNamed:@"d1.png"];
    }
    else{
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"carCell"];
        }
        
        cell.textLabel.text = [warningArr objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [batteryDetailArr objectAtIndex:indexPath.row];
        cell.image = [UIImage imageNamed:@"d1.png"];
    }
    
    return cell;
    
}


@end
