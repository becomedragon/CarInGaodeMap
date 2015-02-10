//
//  CarTraceViewController.m
//  SeguesProduct
//
//  Created by Lawrence on 10/4/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import "CarTraceViewController.h"
#import "POIAnnotation.h"
#import "CustomAnnotationView.h"
#import "CarDataViewController.h"
#import "CarRemoteViewController.h"
#import "CarInfoViewController.h"
#import "AnimatedAnnotation.h"
#import "NavigationViewController.h"

#define kCalloutViewMargin          -8

@interface CarTraceViewController ()<CustomAnnotationViewDelegate>{
    
    NSString * _longtitude;
    NSString * _latitude;
    BOOL _fromTableView;
    SPCarInfo * _carPoi;
    
    NSMutableDictionary * _poiDic;
    NSMutableArray * _poiArr;
    SPCar * _spCarCon;
}

@end

@implementation CarTraceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithLocation:(NSString *)longitude latitude:(NSString *)latitude
{
    if(self = [super init]){
        
        _longtitude = longitude;
        _latitude = latitude;
        _fromTableView = NO;
    }
    
    return self;
}

-(id)initWithCarInfo:(id)carInfo{
    
    if (self = [super init]) {
        
        _carPoi = [[SPCarInfo alloc] init];
        _carPoi = carInfo;
        
    }
    return self;
}

-(id)initFromTableViewWithLocation:(NSString *)longitude latitude:(NSString *)latitude{
    
    if(self = [super init]){
        
        _longtitude = longitude;
        _latitude = latitude;
        _fromTableView = YES;
    }
    
    return self;

}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self configMapViewInfo];
    
    SPCarInfo * car = _carPoi;
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
        
    
    [self.mapView addAnnotations:_poiArr];
    [self.mapView showAnnotations:_poiArr animated:NO];
}


-(void)configMapViewInfo{
    
    // Do any additional setup after loading the view from its nib.
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
    
    _poiDic = [[NSMutableDictionary alloc] init];
    _poiArr = [[NSMutableArray alloc] init];
    _spCarCon = [[SPCar alloc] init];
    
    if (_fromTableView) {
        
        self.navigationItem.title = @"定位";
    }
    else{
        
        self.navigationItem.title = @"汽车跟踪";
    }
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark mapView
/*
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    id<MAAnnotation> annotation = view.annotation;
    
    if ([annotation isKindOfClass:[POIAnnotation class]])
    {
        
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[POIAnnotation class]])
    {
        static NSString *poiIdentifier = @"poiIdentifier";
        MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:poiIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:poiIdentifier];
        }
        
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        poiAnnotationView.pinColor = MAPinAnnotationColorGreen;
        
        
        
        return poiAnnotationView;
    }
    
    return nil;
}
*/

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
    
    //NavigationViewController * navi = [[NavigationViewController alloc] init];
    
    CLLocationCoordinate2D startPoint = CLLocationCoordinate2DMake(_carPoi.longitude.doubleValue/60, _carPoi.latitude.doubleValue/60);
    
    // polylineCoords[0].latitude = 31.282813;
    //polylineCoords[0].longitude = 121.160157;
    CLLocationCoordinate2D endPoint   = CLLocationCoordinate2DMake(31.282813, 121.160157);
    
    NavigationViewController * navi = [[NavigationViewController alloc] initWithStartCoordinate:startPoint andDestinationCoordinate:endPoint];
    
    [self.navigationController pushViewController:navi animated:YES];
    /*
     CarRouteViewController * carRoute = [[CarRouteViewController alloc] initWithLocation:_carPoi.latitude latitude:_carPoi.longitude];
     [self.navigationController pushViewController:carRoute animated:YES];
     */
}

-(void)traceButtonEvent{
    
    CarTraceViewController * carTrace = [[CarTraceViewController alloc] initWithLocation:_carPoi.longitude latitude:_carPoi.latitude];
    [self.navigationController pushViewController:carTrace animated:YES];
}



@end
