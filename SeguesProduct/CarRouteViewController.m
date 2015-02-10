//
//  CarRouteViewController.m
//  SeguesProduct
//
//  Created by Lawrence on 10/31/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import "CarRouteViewController.h"

@interface CarRouteViewController (){
    
    NSString * _longtitude;
    NSString * _latitude;
    
}

@property (nonatomic, strong) NSMutableArray *overlays;
@end

@implementation CarRouteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithLocation:(NSString *)longitude latitude:(NSString *)latitude{
    
    if (self = [super init]) {
        
        _latitude = [NSString stringWithFormat:@"%f",latitude.doubleValue/60];
        _longtitude = [NSString stringWithFormat:@"%f",longitude.doubleValue/60];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
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
    
    self.navigationItem.title = @"车辆回放";
    
    //[self initOverlays];
    [self searchNaviDrive];
    
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.mapView addOverlays:self.overlays];
}

-(void)initOverlays{
    _overlays = [[NSMutableArray alloc] init];
    
    CLLocationCoordinate2D polylineCoords[4];
    //31.282813 , longitude is 121.160157
    
    /*
    polylineCoords[0].latitude = _latitude.doubleValue;
    polylineCoords[0].longitude = _longtitude.doubleValue;
    
    polylineCoords[1].latitude = _latitude.doubleValue + 1;
    polylineCoords[1].longitude = _longtitude.doubleValue + 1;
    
    
    polylineCoords[2].latitude = _latitude.doubleValue + 2;
    polylineCoords[2].longitude = _longtitude.doubleValue + 2;
    
    polylineCoords[3].latitude = _latitude.doubleValue + 3;
    polylineCoords[3].longitude = _longtitude.doubleValue + 3;
    */
    
    NSLog(@"latitude is %f , longitude is %f",_latitude.doubleValue,_longtitude.doubleValue);
    
    
    polylineCoords[0].latitude = 31.282813;
    polylineCoords[0].longitude = 121.160157;
    
     polylineCoords[1].latitude = 31.302813;
     polylineCoords[1].longitude = 121.170157;
     
     polylineCoords[2].latitude = 31.312813;
     polylineCoords[2].longitude = 121.160157;
     
     polylineCoords[3].latitude = 31.262813;
     polylineCoords[3].longitude = 121.260157;
    
    
    
    /*
    polylineCoords[0].latitude = 39.855539;
    polylineCoords[0].longitude = 116.419037;
      
    polylineCoords[1].latitude = 39.758172;
    polylineCoords[1].longitude = 116.520285;
    
    polylineCoords[2].latitude = 39.795479;
    polylineCoords[2].longitude = 116.520859;
    
    polylineCoords[3].latitude = 39.788467;
    polylineCoords[3].longitude = 116.426786;
    
    */
    
    
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:polylineCoords count:4];
    [self.overlays insertObject:polyline atIndex:0];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark overLay
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        circleRenderer.lineWidth   = 4.f;
        circleRenderer.strokeColor = [UIColor blueColor];
        circleRenderer.fillColor   = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        
        return circleRenderer;
    }
    else if ([overlay isKindOfClass:[MAPolygon class]])
    {
        MAPolygonRenderer *polygonRenderer = [[MAPolygonRenderer alloc] initWithPolygon:overlay];
        polygonRenderer.lineWidth   = 4.f;
        polygonRenderer.strokeColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
        polygonRenderer.fillColor   = [UIColor redColor];
        
        return polygonRenderer;
    }
    else if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth   = 4.f;
        polylineRenderer.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
        
        return polylineRenderer;
    }
    
    return nil;
}


#pragma mark - 
#pragma mark navigation
- (void)searchNaviDrive
{
    AMapNavigationSearchRequest *naviRequest= [[AMapNavigationSearchRequest alloc] init];
    naviRequest.searchType = AMapSearchType_NaviDrive;
    naviRequest.requireExtension = YES;
    naviRequest.origin = [AMapGeoPoint locationWithLatitude:39.994949 longitude:116.447265];
    naviRequest.destination = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    [self.search AMapNavigationSearch: naviRequest];
}


- (void)onNavigationSearchDone:(AMapNavigationSearchRequest *)request response:(AMapNavigationSearchResponse *)response
{
    NSString *result = [NSString stringWithFormat:@"Navi: %@", response.route.description];
    NSArray * pathArr =  response.route.paths;
    for (AMapPath * path in pathArr) {
        

    }
    NSLog(@"path is %@", pathArr);
}


    
@end
