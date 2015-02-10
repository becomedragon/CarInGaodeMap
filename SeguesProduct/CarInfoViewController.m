//
//  CarInfoViewController.m
//  SeguesProduct
//
//  Created by Lawrence on 10/2/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import "CarInfoViewController.h"
#import "CarDataViewController.h"
#import "CarRemoteViewController.h"
#import "CarTraceViewController.h"

@interface CarInfoViewController (){
    
    SPCarInfo * _carInfo;
    SPCar * spCarCon;
    SendType _sendType;
    
    
}

@property (weak, nonatomic) IBOutlet UILabel *carSpeed;
@property (weak, nonatomic) IBOutlet UILabel *carStatus;
@property (weak, nonatomic) IBOutlet UILabel *carLocation;
@property (weak, nonatomic) IBOutlet UIImageView *carImage;
@property (weak, nonatomic) IBOutlet UILabel *carName;
@property (weak, nonatomic) IBOutlet UIButton *carDataBtn;
@property (weak, nonatomic) IBOutlet UIButton *carRemoteBtn;
@property (weak, nonatomic) IBOutlet UIButton *carTraceBtn;



@end

@implementation CarInfoViewController


-(id)initWithCarInfo:(SPCarInfo *)carInfo{
    
    if (self = [super init]) {
        
        _carInfo = carInfo;
        
    }
    
    return self;
}
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
    
    spCarCon = [[SPCar alloc] init];
    spCarCon.delegate = self;
    
    
    _carName.text = _carInfo.carName;
    switch (_carInfo.carStatus.intValue) {
        case 0:
            [_carImage setImage:[UIImage imageNamed:@"red.png"]];
            _carStatus.text = @"离线";
            break;
        case 1:
            [_carImage setImage:[UIImage imageNamed:@"green.png"]];
            _carStatus.text = @"在线";
            break;
        default:
           [_carImage setImage:[UIImage imageNamed:@"yellow.png"]];
            _carStatus.text = @"故障";
            break;
    }
 
    _carLocation.text = [NSString stringWithFormat:@"经度%f,维度:%f",_carInfo.latitude.floatValue/60,_carInfo.longitude.floatValue/60];
    _carSpeed.text = [NSString stringWithFormat:@"%@km\\h",_carInfo.GPSSpeed];
    
    [[NSUserDefaults standardUserDefaults] setObject:_carInfo.GPSSpeed forKey:@"GPSSpeed"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    //self.carDataBtn setTitle:@"数据" forState:
    //[self.carDataBtn setTitle:@"数据" forState:UIControlStateApplication];
    self.carDataBtn.titleLabel.text = @"数据";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark button Message
- (IBAction)replayCarRoute:(id)sender {   //回放
    
    
    [spCarCon getCarsRoute:_carInfo.carVin startTime:@"2014-09-19" endTime:@"2014-09-21"];
    _sendType = SPSendFromReplay;
    
}

- (IBAction)traceCar:(id)sender {    //跟踪
    
    _sendType = SPSendFromTrace;
    CarTraceViewController * carTrace = [[CarTraceViewController alloc] initWithLocation:_carInfo.longitude latitude:_carInfo.latitude];
    [self.navigationController pushViewController:carTrace animated:YES];
}

- (IBAction)carData:(id)sender {     //数据
    
    _sendType = SPSendFromData;
    CarDataViewController * carDataVC = [[CarDataViewController alloc] initWithCarName:_carInfo.carName];
    [self.navigationController pushViewController:carDataVC animated:YES];
    [spCarCon getCarsData:_carInfo.carVin];
    
    
}

- (IBAction)remoteCar:(id)sender {   //远程
    
    
    _sendType = SPSendFromRemote;
    CarRemoteViewController * carRemote = [[CarRemoteViewController alloc] init];
    
    [self.navigationController pushViewController:carRemote animated:YES];
    
}

#pragma mark - 
#pragma mark getCarInfo
-(void)getCatrInfo:(NSString *)result{
    //CarDataViewController * carDataVC = [[CarDataViewController alloc] init];
    
    
    switch (_sendType) {
        case SPSendFromReplay:
            
            break;
        case SPSendFromRemote:
            
            break;
        case SPSendFromData:
            //[self.navigationController pushViewController:carDataVC animated:YES];
            break;
        case SPSendFromTrace:
            
            break;
        default:
            break;
    }
    
    NSLog(@"carInfo is %@",result);
}

@end
