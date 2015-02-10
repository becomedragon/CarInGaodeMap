//
//  MapHtmlViewController.m
//  SeguesProduct
//
//  Created by 123456 on 14-7-28.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import "MapHtmlViewController.h"
#import "POIAnnotation.h"
#import "PoiDetailViewController.h"
#import "SPCarInfo.h"
#import "AnimatedAnnotationViewController.h"
#import "AnimatedAnnotation.h"
#import "AnimatedAnnotationView.h"
#import "CarInfoViewController.h"
#import "CarDataViewController.h"
#import "CarTraceViewController.h"
#import "CarRemoteViewController.h"
#import "CarRouteViewController.h"
#import "NavigationViewController.h"
#import "SetttingDataViewController.h"
#import "MapTableTableViewController.h"

#define kCalloutViewMargin          -8

@interface MapHtmlViewController()<SPCarDelegate>{
    
    NSMutableArray * _annotations;
    NSMutableDictionary * _poiDic;
    SPCarInfo * _carPoi;
    SPCarInfo * _endPoi;
    SPCar * _spCarCon;
    AMapPOI * _searchApoi;
    NSMutableArray * _poiArr;
    
    
}

@property (nonatomic) AMapSearchType searchType;
@property (weak, nonatomic) IBOutlet UIButton *errorCarBtn;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *buttonOfSearchBar;


@end

@implementation MapHtmlViewController
@synthesize searchType = _searchType;

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
    UIBarButtonItem *myBackBarButtonItem=[[UIBarButtonItem alloc] init];
    myBackBarButtonItem.title=@"返回";
    self.navigationItem.backBarButtonItem = myBackBarButtonItem;
    // Do any additional setup after loading the view.
    CGRect innerSize=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [MAMapServices sharedServices].apiKey =@"c66ff0ae3edea6806b1edd2cf1f4d62a";
    self.search = [[AMapSearchAPI alloc] initWithSearchKey: @"c66ff0ae3edea6806b1edd2cf1f4d62a" Delegate:self];
    self.mapView=[[MAMapView alloc] initWithFrame:innerSize];
    self.mapView.delegate = self;
    self.mapView.showsScale= NO;
    self.mapView.showsCompass= NO;
    [self.mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:self.mapView];
    self.mapView.showsUserLocation = NO;    //YES 为打开定位，NO为关闭定位
    _annotations = [[NSMutableArray alloc] init];
    _poiDic = [[NSMutableDictionary alloc] init];
    _carPoi = [[SPCarInfo alloc] init];
    _endPoi = [[SPCarInfo alloc] init];
    _searchApoi = [[AMapPOI alloc] init];
    
    
    _spCarCon = [[SPCar alloc] init];
    _spCarCon.delegate = self;
    
    _poiArr = [[NSMutableArray alloc] init];  //poi array;
    
    [self.view bringSubviewToFront:self.searchBar];
    [self.view bringSubviewToFront:self.buttonOfSearchBar];
    
    [self.searchBar setHidden:YES];
    [self.buttonOfSearchBar setHidden:YES];
    
    [self.view bringSubviewToFront:self.errorCarBtn];
}
-(void)viewDidAppear:(BOOL)animated
{
    //判断并接收返回的参数
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self showCarsLocation];
    
    [NSTimer scheduledTimerWithTimeInterval:180 target:self selector:@selector(sendCarInfo) userInfo:nil repeats:YES];
    
}

#pragma mark -
#pragma mark show Cars Location
-(void)showCarsLocation{
    
    
    NSArray * carsInfoArr = [SPCarInfo getFile];
    
    
    for (SPCarInfo * car in carsInfoArr) {
        
        
        //animation POI
        CLLocationCoordinate2D location;
        location.longitude = car.latitude.doubleValue/60;
        location.latitude = car.longitude.doubleValue/60;
        //AnimatedAnnotation * annotation = [[AnimatedAnnotation alloc] initWithCoordinate:location];
       // MAAnnotationView * annotation = [[MAAnnotationView alloc] init];
        MAPointAnnotation * annotation = [[MAPointAnnotation alloc] init];
        annotation.coordinate = location;
        
        NSMutableArray *carImages = [NSMutableArray array];
        NSString * carStatus;
        
        if (car.carStatus.intValue == 0) {
            
            [carImages addObject:[UIImage imageNamed:@"write_p.png"]];
            carStatus = @"离线";
            //annotation.status = 0;
        }
        else if(car.carStatus.intValue == 1){
            
            [carImages addObject:[UIImage imageNamed:@"green_p.png"]];
            
            carStatus = @"在线";
            //annotation.status = 1;
        }
        else{
            
            [carImages addObject:[UIImage imageNamed:@"yellow_p.png"]];
            carStatus = @"故障";
            //annotation.status = 2;
        }
        
        
        annotation.title = [NSString stringWithFormat:@"%@;%@;%@",car.carName,car.carVin,carStatus];
        annotation.subtitle = [NSString stringWithFormat:@"%@;状态:%@;车速:%@km\\h;航向:%@;经纬度:%@",car.carName,carStatus,car.GPSSpeed,car.orintation,[NSString stringWithFormat:@"%f,%f",car.longitude.floatValue/60,car.latitude.floatValue/60]];
        
        
        //记录每辆汽车的信息,供四个按钮来用
        [_poiDic setValue:car forKey:annotation.title];
        
        [_poiArr addObject:annotation];
        
        
    }
    [self.mapView addAnnotations:_poiArr];
    [self.mapView showAnnotations:_poiArr animated:NO];
    
}


-(void)sendCarInfo{
    
    [_spCarCon getCarsLocationWithUserName:[[NSUserDefaults standardUserDefaults] objectForKey:@"name"] andAuth:[[NSUserDefaults standardUserDefaults] objectForKey:@"auth"]];
    
    
}

-(void)getCatrInfo:(NSString *)result{
    
    NSLog(@"result is %@",result);
    NSRange rang;
    rang.location = 1;
    rang.length = result.length-1;
    NSMutableString * carInfoStr = [[result substringWithRange:rang] mutableCopy];
    NSArray * carInfoArr = [carInfoStr componentsSeparatedByString:(@",")];
    [SPCarInfo cacheFile:carInfoArr];
    
    [self.mapView removeAnnotations:_poiArr];
    [self showCarsLocation];
    
}


#pragma mark - 
#pragma mark search method
- (IBAction)searchAction:(id)sender {
    
    /*
    AMapPlaceSearchRequest *request = [[AMapPlaceSearchRequest alloc] init];
    
    request.searchType          = AMapSearchType_PlaceKeyword;
    request.keywords            = @"东方明珠";
    request.city                = @[@"021"];
    request.requireExtension    = YES;
    
    [self.search AMapPlaceSearch:request];
     */
    
    if ([self.searchBar isHidden]) {
        
        [self.searchBar setHidden:NO];
        [self.buttonOfSearchBar setHidden:NO];
    }
    else{
        
        [self.searchBar setHidden:YES];
        [self.buttonOfSearchBar setHidden:YES];
        
        self.searchBar.text = @"";
    }
    
    [self.view endEditing:YES];
    
    
    /*
    AMapGeoPoint * point = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    
    AMapPOI * apoi = [[AMapPOI alloc] init];
    apoi.location = point;
    apoi.name = @"ForTest";
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    
    [arr addObject:[[POIAnnotation alloc] initWithPOI:apoi]];
    [self.mapView addAnnotations:arr];
    [self.mapView showAnnotations:arr animated:NO];
    */
    
    /*
    [POIAnnotation alloc] initWithPOI:(AMapPOI *)
    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    regeoRequest.searchType = AMapSearchType_ReGeocode;
    regeoRequest.location = potin;
    regeoRequest.radius = 10;
    regeoRequest.requireExtension = YES;
    [self.search AMapReGoecodeSearch: regeoRequest];
    */
    
}

- (IBAction)searchCar:(id)sender {
    
    
    if ([self.searchBar.text isEqualToString:@""]) {
        
        return;
    }
    else{
        
        for (POIAnnotation * anno in [self.mapView annotations]) {
            
            NSArray * titlArr = [anno.title componentsSeparatedByString:@";"];
            if ([[titlArr objectAtIndex:0] isEqualToString:self.searchBar.text]) {
                
                [self.mapView selectAnnotation:anno animated:YES];
                
            }
        }
    }
    
    [self.view endEditing:YES];
}


#pragma mark -
#pragma mark map method

-(void)mapView:(MAMapView*)mapView didUpdateUserLocation:(MAUserLocation*)userLocation
updatingLocation:(BOOL)updatingLocation
{
    
}
-(void)mapView:(MAMapView*)mapView didFailToLocateUserWithError:(NSError*)error
{
}


- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode]; NSLog(@"ReGeo: %@", result);
    
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    [response.regeocode.pois enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        [arr addObject:[[POIAnnotation alloc] initWithPOI:obj]];
        
    }];
    
    [self.mapView addAnnotations:arr];
    [self.mapView showAnnotations:arr animated:NO];
}


- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)respons
{
//    if (request.searchType != self.searchType)
//    {
//        return;
//    }
    
    if (respons.pois.count == 0)
    {
        return;
    }
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:respons.pois.count];
    
    [respons.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
        
    }];
    
    /* 将结果以annotation的形式加载到地图上. */
    [self.mapView addAnnotations:poiAnnotations];
    
    /* 如果只有一个结果，设置其为中心点. */
    if (poiAnnotations.count == 1)
    {
        self.mapView.centerCoordinate = [poiAnnotations[0] coordinate];
    }
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
    else
    {
        [self.mapView showAnnotations:poiAnnotations animated:NO];
    }
    
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    id<MAAnnotation> annotation = view.annotation;
    
    if ([annotation isKindOfClass:[POIAnnotation class]])
    {
        POIAnnotation *poiAnnotation = (POIAnnotation*)annotation;
        
        PoiDetailViewController *detail = [[PoiDetailViewController alloc] init];
        detail.poi = poiAnnotation.poi;
        
        /* 进入POI详情页面. */
        [self.navigationController pushViewController:detail animated:YES];
    }
}



//customer annotation
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        CustomAnnotationView *annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            // must set to NO, so we can show the custom callout view.
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            annotationView.calloutOffset = CGPointMake(0, -5);
        }
       
        NSArray * carStatusArr = [[annotation title] componentsSeparatedByString:@";"];
        if ([[carStatusArr objectAtIndex:2] isEqualToString:@"在线"]) {
            
            annotationView.portrait = [UIImage imageNamed:@"green_p.png"];
        }
        else if([[carStatusArr objectAtIndex:2] isEqualToString:@"故障"]){
            
            annotationView.portrait = [UIImage imageNamed:@"yellow_p.png"];
        }
        else{
            
            annotationView.portrait = [UIImage imageNamed:@"write_p.png"];
        }
        
        //annotationView.name = [annotation subtitle];
        [annotationView setCarInfoArr:[annotation subtitle]];
        //annotationView.delegate = self;
        
        NSLog(@"annotationView name is%@ titlte is %@",[annotation subtitle] ,[annotation title]);
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    /* Adjust the map center in order to show the callout view completely. */
    if ([view isKindOfClass:[CustomAnnotationView class]]) {
        CustomAnnotationView *cusView = (CustomAnnotationView *)view;
        CGRect frame = [cusView convertRect:cusView.calloutView.frame toView:self.mapView];
        
        frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin));
        
        if (!CGRectContainsRect(self.mapView.frame, frame))
        {
            /* Calculate the offset to make the callout view show up. */
            CGSize offset = [self offsetToContainRect:frame inRect:self.mapView.frame];
            
            CGPoint theCenter = self.mapView.center;
            theCenter = CGPointMake(theCenter.x - offset.width, theCenter.y - offset.height);
            
            CLLocationCoordinate2D coordinate = [self.mapView convertPoint:theCenter toCoordinateFromView:self.mapView];
            
            [self.mapView setCenterCoordinate:coordinate animated:YES];
        }
        
        
        AnimatedAnnotation * ann = view.annotation;
        _carPoi = [_poiDic objectForKey:ann.title];
       
        
        cusView.delegate = self;
    }
}

- (CGSize)offsetToContainRect:(CGRect)innerRect inRect:(CGRect)outerRect
{
    CGFloat nudgeRight = fmaxf(0, CGRectGetMinX(outerRect) - (CGRectGetMinX(innerRect)));
    CGFloat nudgeLeft = fminf(0, CGRectGetMaxX(outerRect) - (CGRectGetMaxX(innerRect)));
    CGFloat nudgeTop = fmaxf(0, CGRectGetMinY(outerRect) - (CGRectGetMinY(innerRect)));
    CGFloat nudgeBottom = fminf(0, CGRectGetMaxY(outerRect) - (CGRectGetMaxY(innerRect)));
    return CGSizeMake(nudgeLeft ?: nudgeRight, nudgeTop ?: nudgeBottom);
}



#pragma mark - 
#pragma mark take in carInfo
-(void)indexToCarInfo{
    
    CarInfoViewController * carInfo = [[CarInfoViewController alloc] initWithCarInfo:_carPoi];
    [self.navigationController pushViewController:carInfo animated:YES];
    
}

#pragma mark - 
#pragma mark showCarList

- (IBAction)showErrorCar:(id)sender {
    
    MapTableTableViewController * carList = [[MapTableTableViewController alloc] initWithShowErrorCarList];
    [self.navigationController pushViewController:carList animated:YES];
}

#pragma mark - 
#pragma mark cutomerAnnotationDelegate
-(void)dataButtonEvent{
 
    CarDataViewController * carDataVC = [[CarDataViewController alloc] initWithCarName:_carPoi.carName];
    [self.navigationController pushViewController:carDataVC animated:YES];
    [_spCarCon getCarsData:_carPoi.carVin];
}

-(void)remoteButtonEvent{
    
    CarRemoteViewController * carRemote = [[CarRemoteViewController alloc] init];
    [self.navigationController pushViewController:carRemote animated:YES];
}


-(void)replayButtonEvent{
    
   CLLocationCoordinate2D startPoint = CLLocationCoordinate2DMake(_carPoi.longitude.doubleValue/60, _carPoi.latitude.doubleValue/60);
    CLLocationCoordinate2D endPoint   = CLLocationCoordinate2DMake(31.282813, 121.160157);
    
    
    SetttingDataViewController * setData = [[SetttingDataViewController alloc] initWithCarName:_carPoi.carName andStartPoint:startPoint andEndPoint:endPoint];
    [self.navigationController pushViewController:setData animated:YES];
    
    }

-(void)traceButtonEvent{
    
    CarTraceViewController * carTrace = [[CarTraceViewController alloc] initWithLocation:_carPoi.longitude latitude:_carPoi.latitude];
    [self.navigationController pushViewController:carTrace animated:YES];
}

#pragma mark - 
#pragma mark SPCar delegate

@end
