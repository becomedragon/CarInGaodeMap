//
//  SPCarsRouteReplay.m
//  SeguesProduct
//
//  Created by Lawrence on 9/30/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import "SPCarsRouteReplay.h"

@implementation SPCarsRouteReplay

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        self.longgitude = [aDecoder decodeObjectForKey:@"longgitude"];
        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    
    [aCoder encodeObject:self.longgitude forKey:@"longgitude"];
    [aCoder encodeObject:self.latitude forKey:@"latitude"];
    
}



@end
