//
//  ZSPageScrollView.h
//  zhaoShang_app_iphone
//
//  Created by ZhaoShang on 13-4-8.
//  Copyright (c) 2013年 ZhaoShang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZSPageScrollView : UIView<UIScrollViewDelegate>

@property (retain,nonatomic)UIScrollView *scrollView;
@property (retain,nonatomic)UIPageControl *pageControl;
@property (retain,nonatomic)NSMutableArray *imageArr;

- (id)initWithFrame:(CGRect)frame imageArray:(NSMutableArray *)imageArray;

@end
