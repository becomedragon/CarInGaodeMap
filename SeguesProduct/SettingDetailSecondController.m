//
//  SettingDetailSecondController.m
//  SeguesProduct
//
//  Created by 徐蒙特 on 14-8-16.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import "SettingDetailSecondController.h"


@interface SettingDetailSecondController(){
    
    SPSetting * _setting;

    
}
@property (weak, nonatomic) IBOutlet UITextView *contentTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactText;


@end

@implementation SettingDetailSecondController

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
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {self.edgesForExtendedLayout=UIRectEdgeNone;    }
    // Do any additional setup after loading the view.
    [_contentTextField.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [_contentTextField.layer setBorderWidth:0.5];
    
    
    _setting = [[SPSetting alloc] init];
    _setting.delegate = self;
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    self.navigationItem.rightBarButtonItem = right;
    
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
- (IBAction)submit:(id)sender {
    
    [_setting returnAdviceWithContent:self.contentTextField.text andContact:self.contactText.text];

}



-(void)getSettingInfo:(NSString *)settingInfo{
    NSLog(@"settingInfo is %@",settingInfo);
    
    if ([settingInfo isEqualToString:@"[save]\r\n"]) {
        
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
    }
    else{
        
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
    }
    
}
@end
