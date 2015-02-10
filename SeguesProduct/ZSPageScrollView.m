//
//  ZSPageScrollView.m
//  zhaoShang_app_iphone
//
//  Created by ZhaoShang on 13-4-8.
//  Copyright (c) 2013年 ZhaoShang. All rights reserved.
//

#import "ZSPageScrollView.h"

#define scorllWidth self.frame.size.width
#define scorllHeight self.frame.size.height

#define pageControlWidth 5
#define pageControlHeight 36


@interface ZSPageScrollView()
{
    NSTimer *timer;
}
@property (retain,nonatomic)UIImageView *imageView;

@end

@implementation ZSPageScrollView
@synthesize pageControl = _pageControl;
@synthesize scrollView = _scrollView;
@synthesize imageArr = _imageArr;
@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame imageArray:(NSMutableArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self){
        _imageArr = imageArray;
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.userInteractionEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake((scorllWidth)*imageArray.count,scorllHeight);
        _scrollView.bounces = NO;
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.height-25, pageControlWidth, pageControlHeight)];
        _pageControl.userInteractionEnabled = YES;
        timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
        for(int i = 0 ; i < imageArray.count; i++)
        {
            //添加图片
            _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((scorllWidth)*i, 0, scorllWidth, scorllHeight)];
            _imageView.tag = i;
            _imageView.userInteractionEnabled = YES;
            [_imageView setImage:[UIImage imageNamed:[_imageArr objectAtIndex:i]]];
            [_scrollView addSubview:_imageView];
            _scrollView.pagingEnabled = YES;
            _scrollView.showsVerticalScrollIndicator = YES;
            _pageControl.numberOfPages = imageArray.count;
            self.imageView.userInteractionEnabled = YES;
        }
        [self addSubview:_scrollView];
        [self addSubview:_pageControl];
    }
    return self;
}

- (void)changeImage
{
    if (_pageControl.currentPage > _imageArr.count-2){
        _pageControl.currentPage = 0;
        CGPoint os = CGPointMake(scorllWidth*_pageControl.currentPage, 0);
        [_scrollView setContentOffset:os animated:YES];
    }else{
        _pageControl.currentPage++;
        CGPoint os = CGPointMake(scorllWidth*_pageControl.currentPage, 0);
        [_scrollView setContentOffset:os animated:YES];
    }
}

#pragma mark-
#pragma UIScorllViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = ceil(_scrollView.contentOffset.x/_scrollView.bounds.size.width);
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}


@end
