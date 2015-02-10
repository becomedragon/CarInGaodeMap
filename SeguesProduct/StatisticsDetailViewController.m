//
//  StatisticsDetailViewController.m
//  SeguesProduct
//
//  Created by 徐蒙特 on 14-7-30.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import "StatisticsDetailViewController.h"


@interface StatisticsDetailViewController (){
    NSArray *pickerArray;
    //SourceFrom  _source;
    NSString * _carVin;
    
}


@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerEnd;
@end

@implementation StatisticsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
-(id)initWithSource:(SourceFrom)from andCarVin:(NSString *)carVin{
    
    if (self = [super init]) {
        
        _source = from;
        _carVin = carVin;
    }
    
    return self;
    
}
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _picker.frame = CGRectMake(0, 480, 320, 50);
}

-(void)viewDidAppear:(BOOL)animated{
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



#pragma mark - 
#pragma mark button method
- (IBAction)selectDate:(id)sender {
    
    NSDate * selDate = [_datePicker date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString * dateStr = [formatter stringFromDate:selDate];
    
    NSString * endStr = [formatter stringFromDate:[_datePickerEnd date]];
    NSLog(@"start is %@ end is %@",dateStr,endStr);
    
    
}


@end
