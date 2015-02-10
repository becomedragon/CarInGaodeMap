//
//  CustomAnnotationView.m
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"

#define kWidth  20.f
#define kHeight 30.f

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  50.f
#define kPortraitHeight 50.f

#define kCalloutWidth   220.0
#define kCalloutHeight  160.0

#define kLabelHeight 20
#define kLabelWidth 200

#define kButtonHeight 30
#define kButtonWidth 40

#define kLabelFont 13

@interface CustomAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation CustomAnnotationView

@synthesize calloutView;
@synthesize portraitImageView   = _portraitImageView;
@synthesize nameLabel           = _nameLabel;

#pragma mark - Handle Action

- (void)btnAction
{
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    
    NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
}

#pragma mark - Override

- (NSString *)name
{
    return self.nameLabel.text;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            /* Construct custom callout. */
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
            /*
            NSString * carInfo = self.name;
            NSArray * carInfoArr = [carInfo componentsSeparatedByString:@";"];
            */
            
        
            //labels
            UILabel * carNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kLabelWidth, kLabelHeight)];
            carNameLabel.text = [self.carInfo objectAtIndex:0];
            carNameLabel.textColor = [UIColor blackColor];
            [carNameLabel setFont:[UIFont systemFontOfSize:kLabelFont]];
            
            
            UILabel * carStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kLabelHeight + 10, kLabelWidth, kLabelHeight)];
            carStatusLabel.text = [self.carInfo objectAtIndex:1];
            carStatusLabel.textColor = [UIColor blackColor];
            [carStatusLabel setFont:[UIFont systemFontOfSize:kLabelFont]];
            
            
            UILabel * carSpeedLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kLabelHeight*2 +10, kLabelWidth, kLabelHeight)];
            carSpeedLabel.text = [self.carInfo objectAtIndex:2];
            carSpeedLabel.textColor = [UIColor blackColor];
            [carSpeedLabel setFont:[UIFont systemFontOfSize:kLabelFont]];
            
            
            UILabel * carOriantationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kLabelHeight*3 + 10, kLabelWidth, kLabelHeight)];
            carOriantationLabel.text = [self.carInfo objectAtIndex:3];
            carOriantationLabel.textColor = [UIColor blackColor];
            [carOriantationLabel setFont:[UIFont systemFontOfSize:kLabelFont]];
            
            
            UILabel * carLatLongLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kLabelHeight*4 + 10, kLabelWidth, kLabelHeight)];
            carLatLongLabel.text = [self.carInfo objectAtIndex:4];
            carLatLongLabel.textColor = [UIColor blackColor];
            [carLatLongLabel setFont:[UIFont systemFontOfSize:kLabelFont]];
            
            
            
            //buttons
            UIButton * dataButton = [[UIButton alloc] initWithFrame:CGRectMake(10, kLabelHeight*5 + 10, kButtonWidth, kButtonHeight)];
            [dataButton setBackgroundImage:[UIImage imageNamed:@"detail_pick_btn"] forState:UIControlStateNormal];
            [dataButton setTitle:@"数据" forState:UIControlStateNormal];
            [dataButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [dataButton.titleLabel setFont:[UIFont systemFontOfSize:kLabelFont]];
            [dataButton addTarget:self action:@selector(showData) forControlEvents:UIControlEventTouchUpInside];
            
            
            UIButton * traceButton = [[UIButton alloc] initWithFrame:CGRectMake(kButtonWidth+20, kLabelHeight*5+10,kButtonWidth , kButtonHeight)];
            [traceButton setBackgroundImage:[UIImage imageNamed:@"detail_pick_btn"] forState:UIControlStateNormal];

            [traceButton setTitle:@"跟踪" forState:UIControlStateNormal];
            [traceButton.titleLabel setFont:[UIFont systemFontOfSize:kLabelFont]];
            [traceButton addTarget:self action:@selector(showTrace) forControlEvents:UIControlEventTouchUpInside];
            
            
            UIButton * replayButton = [[UIButton alloc] initWithFrame:CGRectMake(kButtonWidth*2+30, kLabelHeight*5+10, kButtonWidth, kButtonHeight)];
            [replayButton setBackgroundImage:[UIImage imageNamed:@"detail_pick_btn"] forState:UIControlStateNormal];
            [replayButton setTitle:@"回放" forState:UIControlStateNormal];
            [replayButton.titleLabel setFont:[UIFont systemFontOfSize:kLabelFont]];
            [replayButton addTarget:self action:@selector(showReplay) forControlEvents:UIControlEventTouchUpInside];
            
            
            UIButton * remoteButton = [[UIButton alloc] initWithFrame:CGRectMake(kButtonWidth*3+40, kLabelHeight*5+10, kButtonWidth, kButtonHeight)];
            [remoteButton setBackgroundImage:[UIImage imageNamed:@"detail_pick_btn"] forState:UIControlStateNormal];
            [remoteButton setTitle:@"远程" forState:UIControlStateNormal];
            [remoteButton.titleLabel setFont:[UIFont systemFontOfSize:kLabelFont]];
            [remoteButton addTarget:self action:@selector(showRemote) forControlEvents:UIControlEventTouchUpInside];
            
            [self.calloutView addSubview:carNameLabel];
            [self.calloutView addSubview:carStatusLabel];
            [self.calloutView addSubview:carSpeedLabel];
            [self.calloutView addSubview:carOriantationLabel];
            [self.calloutView addSubview:carLatLongLabel];
            
            
            [self.calloutView addSubview:dataButton];
            [self.calloutView addSubview:traceButton];
            [self.calloutView addSubview:replayButton];
            [self.calloutView addSubview:remoteButton];
            
        }
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        
        self.backgroundColor = [UIColor clearColor];
        
        /* Create portrait image view and add to view hierarchy. */
        self.portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
        
        self.carInfo = [[NSArray alloc] init];
        [self addSubview:self.portraitImageView];
        
}
    
    return self;
}

-(void)setCarInfoArr:(NSString *)carInfoStr{
    
    self.carInfo = [carInfoStr componentsSeparatedByString:@";"];
}

-(void)showData{
    
    [self.delegate dataButtonEvent];
}

-(void)showRemote{
    
    [self.delegate remoteButtonEvent];
}

-(void)showReplay{
    
    [self.delegate replayButtonEvent];
}

-(void)showTrace{
    
    [self.delegate traceButtonEvent];
}

@end
