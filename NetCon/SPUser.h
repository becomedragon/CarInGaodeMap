//
//  SPUser.h
//  SeguesProduct
//
//  Created by Lawrence on 14-9-27.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPUserDelegate <NSObject>

-(void)getLogonResultFromServer:(NSString *)result;

@end

@interface SPUser : NSObject
@property(nonatomic,weak) id<SPUserDelegate> delegate;



-(void)logonWithName:(NSString *)userName AndPassword:(NSString *)password;
@end
