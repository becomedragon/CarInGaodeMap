//
//  CustomAnnotationView.h
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@protocol CustomAnnotationViewDelegate <NSObject>

-(void)dataButtonEvent;   //数据
-(void)remoteButtonEvent; //远程
-(void)traceButtonEvent;  //跟踪
-(void)replayButtonEvent; //回放

@end

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIImage *portrait;

@property (nonatomic, strong) UIView *calloutView;

@property (nonatomic,copy) NSArray * carInfo;

@property(nonatomic,weak) id<CustomAnnotationViewDelegate> delegate;


-(void)setCarInfoArr:(NSString *)carInfoStr;

@end
