//
//  StatisticSettingViewController.m
//  SeguesProduct
//
//  Created by Lawrence on 10/5/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import "StatisticSettingViewController.h"
#import "SPStatistic.h"
#import "ChartViewController.h"

@interface StatisticSettingViewController ()<SPStatisticDelegate,PNChartDelegate>{
    
    SourceFrom _source;
    NSString * _carVin;
    SPStatistic * spStatistic;
    
    
}

@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@end

@implementation StatisticSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithSourceFrom:(SourceFrom)from andCarVin:(NSString *)carVin{
    
    if (self = [super init]) {
        
        _source = from;
        _carVin = carVin;
        
    }
    
    return self;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    spStatistic = [[SPStatistic alloc] init];
    spStatistic.delegate = self;
    
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
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(selectDate:)];
    
    self.navigationController.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.rightBarButtonItem = rightItem;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectDate:(id)sender {
    
   
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * startStr = [formatter stringFromDate:[_startDatePicker date]];
    NSString * endStr = [formatter stringFromDate:[_endDatePicker date]];
    
    spStatistic = [[SPStatistic alloc] init];
    [spStatistic getCarStatisticInfoType:_source WithCarVin:_carVin andStartTime:startStr andEndTime:endStr];
    
    [self viewChartTable:_source];
}

-(void)getStatisticInfo:(NSString *)statisticInfo{
    
    NSLog(@"statistic info is %@",statisticInfo);
}

-(void)viewChartTable:(SourceFrom)type{
    
    ChartViewController * viewController = [[ChartViewController alloc] initWithSourceFrom:type];
    
    
    if (type == SourceFromCarSpeed) {
        
        
        //Add LineChart
        UILabel * lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 30)];
        lineChartLabel.text = @"车辆统计";
        lineChartLabel.textColor = PNFreshGreen;
        lineChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
        lineChartLabel.textAlignment = NSTextAlignmentCenter;
        
        PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 200.0)];
        lineChart.yLabelFormat = @"%1.1f";
        lineChart.backgroundColor = [UIColor clearColor];
        [lineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24"]];
        lineChart.showCoordinateAxis = YES;
        lineChart.yValueMax = 180;
        lineChart.yValueMin = 0;
        // Line Chart Nr.1
        NSMutableArray *data01Array = [NSMutableArray array];
        for (int i = 0 ; i < 24 ; i++) {
            
            float n = arc4random()%180;
            NSNumber * num = [NSNumber numberWithFloat:n];
            [data01Array addObject:num];
            
            
        }
    
        //NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2, @127.2, @176.2];
        PNLineChartData *data01 = [PNLineChartData new];
        data01.color = PNFreshGreen;
        data01.itemCount = lineChart.xLabels.count;
        data01.inflexionPointStyle = PNLineChartPointStyleCycle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        /*
        // Line Chart Nr.2
        NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2, @167.2, @276.2];
        PNLineChartData *data02 = [PNLineChartData new];
        data02.color = PNTwitterColor;
        data02.itemCount = lineChart.xLabels.count;
        data02.inflexionPointStyle = PNLineChartPointStyleSquare;
        data02.getData = ^(NSUInteger index) {
            CGFloat yValue = [data02Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        */
        
        //lineChart.chartData = @[data01, data02];
        lineChart.chartData = @[data01];
        [lineChart strokeChart];
        
        lineChart.delegate = self;
        
        /*
        [viewController.view addSubview:lineChartLabel];
        [viewController.view addSubview:lineChart];
        */
        
        [viewController.view addSubview:lineChartLabel];
        [viewController.view addSubview:lineChart];
        
        viewController.navigationItem.title = @"车辆统计";
        
    }else if (type == SourceFromCarMiles)
    {
        
        //Add BarChart
        
        UILabel * barChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 30)];
        barChartLabel.text = @"里程统计";
        barChartLabel.textColor = PNFreshGreen;
        barChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
        barChartLabel.textAlignment = NSTextAlignmentCenter;
        
        self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 200.0)];
        self.barChart.backgroundColor = [UIColor clearColor];
        self.barChart.yLabelFormatter = ^(CGFloat yValue){
            CGFloat yValueParsed = yValue;
            NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
            return labelText;
        };
        self.barChart.labelMarginTop = 5.0;
        [self.barChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24"]];
        
        NSMutableArray *data01Array = [NSMutableArray array];
        for (int i = 0 ; i < 24 ; i++) {
            
            float n = arc4random()%180;
            NSNumber * num = [NSNumber numberWithFloat:n];
            [data01Array addObject:num];
            
        }
        
        [self.barChart setYValues:data01Array];
        [self.barChart setStrokeColors:@[PNGreen,PNGreen,PNRed,PNGreen,PNGreen,PNYellow,PNGreen]];
        // Adding gradient
        self.barChart.barColorGradientStart = [UIColor blueColor];
        
        [self.barChart strokeChart];
        
        
        
        self.barChart.delegate = self;
        
        [viewController.view addSubview:barChartLabel];
        [viewController.view addSubview:self.barChart];
        viewController.navigationItem.title = @"里程统计";
    }
    else if (type == SourceFromCarWarning)
    {
        
        //Add PieChart
        UILabel * pieChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 30)];
        pieChartLabel.text = @"车辆故障比例";
        pieChartLabel.textColor = PNFreshGreen;
        pieChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
        pieChartLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        int gu = arc4random()%50;
        int he = 100 - gu;
        NSArray *items = @[[PNPieChartDataItem dataItemWithValue:gu color:PNRed description:@"故障"],
                           [PNPieChartDataItem dataItemWithValue:he color:PNDeepGreen description:@"合格"],
                           ];
        
        
        
        PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 200, 240.0, 240.0) items:items];
        pieChart.descriptionTextColor = [UIColor whiteColor];
        pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
        pieChart.descriptionTextShadowColor = [UIColor clearColor];
        [pieChart strokeChart];
        
        
        [viewController.view addSubview:pieChartLabel];
        [viewController.view addSubview:pieChart];
       
        viewController.navigationItem.title = @"车辆故障";
    }

    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - 
#pragma mark PNChartDelegate
-(void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex andPointIndex:(NSInteger)pointIndex{
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}

-(void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}

- (void)userClickedOnBarCharIndex:(NSInteger)barIndex
{
    
    NSLog(@"Click on bar %@", @(barIndex));
    
    PNBar * bar = [self.barChart.bars objectAtIndex:barIndex];
    
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue= @1.0;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation.toValue= @1.1;
    
    animation.duration= 0.2;
    
    animation.repeatCount = 0;
    
    animation.autoreverses = YES;
    
    animation.removedOnCompletion = YES;
    
    animation.fillMode=kCAFillModeForwards;
    
    [bar.layer addAnimation:animation forKey:@"Float"];
}



@end
