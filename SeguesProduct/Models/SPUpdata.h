//
//  SPUpdata.h
//  SeguesProduct
//
//  Created by Lawrence on 10/30/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPUpdataDelegate <NSObject>

-(void)getUpdateResultFromServer:(NSString *)updateMsg;


@end
@interface SPUpdata : NSObject

@property(nonatomic,weak) id<SPUpdataDelegate> delegate;

-(void)checkVersion;

@end
