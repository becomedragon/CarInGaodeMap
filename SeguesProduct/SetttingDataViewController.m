//
//  SetttingDataViewController.m
//  SeguesProduct
//
//  Created by Lawrence on 11/4/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import "SetttingDataViewController.h"
#import "NavigationViewController.h"

@interface SetttingDataViewController (){
    
    CLLocationCoordinate2D _startPoi;
    CLLocationCoordinate2D _endPoi;
    NSString * _carName;
    
}

@property (weak, nonatomic) IBOutlet UILabel *carNameLabel;
@end

@implementation SetttingDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCarName:(NSString *)carName andStartPoint:(CLLocationCoordinate2D)startPoi andEndPoint:(CLLocationCoordinate2D)endPoi{
    
    if (self = [super init]) {
        _carName = carName;
        _startPoi = startPoi;
        _endPoi = endPoi;
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.carNameLabel.text = [NSString stringWithFormat:@"名称:%@",_carName];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self
                                                                             action:@selector(indexToCarReplayView)];
    
}

-(void)indexToCarReplayView{
    
    NavigationViewController * navi = [[NavigationViewController alloc] initWithStartCoordinate:_startPoi andDestinationCoordinate:_endPoi];
    [self.navigationController pushViewController:navi animated:YES];

}
@end
