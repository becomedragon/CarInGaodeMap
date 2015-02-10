//
//  MapHtmlViewController.h
//  SeguesProduct
//
//  Created by 123456 on 14-7-28.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "CustomAnnotationView.h"

@interface MapHtmlViewController : UIViewController<MAMapViewDelegate,AMapSearchDelegate,CustomAnnotationViewDelegate>
- (IBAction)searchAction:(id)sender;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
//@property(nonatomic,strong)NSString *mapHtml;
@end
