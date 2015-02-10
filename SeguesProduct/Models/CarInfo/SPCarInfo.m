//
//  SPCarInfo.m
//  SeguesProduct
//
//  Created by Lawrence on 14-9-29.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import "SPCarInfo.h"
#import "CacheFile.h"

@implementation SPCarInfo


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    
    if (self) {
    
        self.carVin = [aDecoder decodeObjectForKey:@"carVin"];
        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
        self.carName = [aDecoder decodeObjectForKey:@"carName"];
        self.carStatus = [aDecoder decodeObjectForKey:@"carStatus"];
        self.motorcade = [aDecoder decodeObjectForKey:@"motorcade"];
        self.GPSSpeed = [aDecoder decodeObjectForKey:@"GPSSpeed"];
        self.orintation = [aDecoder decodeObjectForKey:@"orintation"];
    }
    
    return self;
    /*
     @property(nonatomic,copy)NSString * carVin;
     @property(nonatomic,copy)NSString * longitude;
     @property(nonatomic,copy)NSString * latitude;
     @property(nonatomic,copy)NSString * carName;
     @property(nonatomic,copy)NSString * carStatus;
     @property(nonatomic,copy)NSString * motorcade;
     @property(nonatomic,copy)NSString * GPSSpeed;
     */
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.carVin forKey:@"carVin"];
    [aCoder encodeObject:self.longitude forKey:@"longitude"];
    [aCoder encodeObject:self.latitude forKey:@"latitude"];
    [aCoder encodeObject:self.carName forKey:@"carName"];
    [aCoder encodeObject:self.carStatus forKey:@"carStatus"];
    [aCoder encodeObject:self.motorcade forKey:@"motorcade"];
    [aCoder encodeObject:self.GPSSpeed forKey:@"GPSSpeed"];
    [aCoder encodeObject:self.orintation forKey:@"orintation"];
    
}


+(void)cacheFile:(NSArray *)arr
{
    NSMutableArray * carArr = [NSMutableArray array];
    for (NSString * carStr in arr) {
        
        SPCarInfo * carInfo = [SPCarInfo new];
        NSArray * a = [carStr componentsSeparatedByString:(@";")];
     
        carInfo.carVin = a[0];
        carInfo.longitude = a[1];
        carInfo.latitude = a[2];
        carInfo.carName = a[3];
        carInfo.carStatus = a[4];
        carInfo.motorcade = a[6];
        carInfo.GPSSpeed = a[7];
        carInfo.orintation = a[8];
        
        NSLog(@"longgitude is %f lagitude is %f",carInfo.longitude.doubleValue,carInfo.latitude.doubleValue);
        [carArr addObject:carInfo];
    }
    
    
    if ([CacheFile cache_file_exists:kCarInfoCacheFile]) {
        [CacheFile cache_file_delete:kCarInfoCacheFile];
       
        NSData * cacheData = [NSKeyedArchiver archivedDataWithRootObject:carArr];
        [CacheFile cache_file_set_nsdata:kCarInfoCacheFile contents:cacheData];
        
    }
    else{
        
        NSData * cacheData = [NSKeyedArchiver archivedDataWithRootObject:carArr];
        [CacheFile cache_file_set_nsdata:kCarInfoCacheFile contents:cacheData];
    }
    
}

+(NSArray *)getFile
{
    
    NSData * cacheData = [CacheFile cache_file_get_nsdata:kCarInfoCacheFile];
    NSArray * cacheArr = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
    return [cacheArr copy];
    
}

@end
