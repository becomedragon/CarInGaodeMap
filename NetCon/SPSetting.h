//
//  SPSetting.h
//  SeguesProduct
//
//  Created by Lawrence on 10/7/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPSettingDelegate <NSObject>

-(void)getSettingInfo:(NSString *)settingInfo;

@end

@interface SPSetting : NSObject

@property(nonatomic,weak) id<SPSettingDelegate> delegate;

-(void)returnAdviceWithContent:(NSString *)content andContact:(NSString *)contact;

@end
