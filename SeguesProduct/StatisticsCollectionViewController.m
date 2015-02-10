//
//  StatisticsCollectionViewController.m
//  SeguesProduct
//
//  Created by 123456 on 14-7-28.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import "StatisticsCollectionViewController.h"
#import "StatisticSettingViewController.h"
#import "StaticsSecondTableViewController.h"

@interface StatisticsCollectionViewController (){
    NSArray *textArray;
    NSArray *imageArray;
    SourceFrom _source;
}

@end

@implementation StatisticsCollectionViewController

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
    UIBarButtonItem *myBackBarButtonItem=[[UIBarButtonItem alloc] init];
    myBackBarButtonItem.title=@"返回";
    self.navigationItem.backBarButtonItem = myBackBarButtonItem;
    // Do any additional setup after loading the view.
    textArray = [[NSArray alloc] initWithObjects:@"车速统计", @"里程统计",
                 @"故障统计", nil];
    imageArray = [[NSArray alloc] initWithObjects:@"carspeed.png",@"carmiles.png",@"carerror.png",nil];
    self.navigationItem.title = @"统计";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"StatisticsCollectionCell";
    NSUInteger row = [indexPath row];
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    UILabel *cellText = (UILabel *)[cell.contentView viewWithTag:301];
    cellText.text = [textArray objectAtIndex:row];
    cellText.textAlignment=NSTextAlignmentRight;
    UIImageView *cellImage = (UIImageView *)[cell.contentView viewWithTag:302];
    [cellImage setImage:[UIImage imageNamed:[imageArray objectAtIndex:row]]];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            _source = SourceFromCarSpeed;
            break;
        case 1:
            _source = SourceFromCarMiles;
            break;
        case 2:
            _source = SourceFromCarWarning;
            break;
        default:
            _source = SourceFromCarWarning;
            break;
    }
    
    StaticsSecondTableViewController * carList = [[StaticsSecondTableViewController alloc] initFromSource:_source];
    [self.navigationController pushViewController:carList animated:YES];
}
@end
