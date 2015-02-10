//
//  ChartViewController.m
//  SeguesProduct
//
//  Created by Lawrence on 10/5/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import "ChartViewController.h"

@interface ChartViewController (){
    
    float lastScale;
    SourceFrom _source;
    
}

@property (strong, nonatomic) IBOutlet UIView *speedInfoView;
@property (strong, nonatomic) IBOutlet UIView *errorInfoView;


@property (weak, nonatomic) IBOutlet UILabel *topSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *avreSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;


@end

@implementation ChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(id)initWithSourceFrom:(SourceFrom)source{
    
    if (self = [super init]) {
        
        _source = source;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    //[self.view addSubview:_scrollView];
    
    /*
    UIPinchGestureRecognizer * pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchChart:)];
    [self.view addGestureRecognizer:pinch];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
    [self.view addGestureRecognizer:pan];
    
    lastScale=1.0;
    */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    for (UIView * v in self.view.subviews) {
        
        if (![v isMemberOfClass:[UIScrollView class]]) {
            
            [_scrollView addSubview:v];
            
        }
        
    }
    [self.view addSubview:_scrollView];
    
    
    UIPinchGestureRecognizer * pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchChart:)];
    [_scrollView addGestureRecognizer:pinch];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
    [_scrollView addGestureRecognizer:pan];
    
   
    lastScale=1.0;
    
    if (_source == SourceFromCarSpeed || _source == SourceFromCarWarning) {
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"详情" style:UIBarButtonItemStyleDone target:self action:@selector(viewDetail)];
        
    }

}

-(void)viewDetail{
    
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"图标"]) {
        
        [self.navigationItem.rightBarButtonItem setTitle:@"详情"];
        
        if (_source == SourceFromCarWarning) {
            
            [self.errorInfoView removeFromSuperview];
        }
        
        if (_source == SourceFromCarSpeed) {
            
            
            [self.speedInfoView removeFromSuperview];
        }

        
    }
    else{
        
        [self.navigationItem.rightBarButtonItem setTitle:@"图标"];
        if (_source == SourceFromCarWarning) {
            
            self.errorLabel.text = @"无故障";
            [self.view addSubview:self.errorInfoView];
        }
        
        if (_source == SourceFromCarSpeed) {
            
            self.topSpeedLabel.text = @"180km\\h";
            self.avreSpeedLabel.text = @"75km\\h";
            [self.view addSubview:self.speedInfoView];
        }

    }
    
    
}


-(void)pinchChart:(UIPinchGestureRecognizer *)sender{
    
    if([sender state] == UIGestureRecognizerStateEnded) {
        lastScale = 1.0;
        return;
    }
    
    CGFloat scale = 1.0 - (lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    CGAffineTransform currentTransform = _scrollView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    //[self.photoCar setTransform:newTransform];
    [_scrollView setTransform:newTransform];
    lastScale = [sender scale];
    
}


- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer

{
    
    UIView *piece = [gestureRecognizer view];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
        
    }
    
}

@end
