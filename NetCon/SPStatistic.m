//
//  SPStatistic.m
//  SeguesProduct
//
//  Created by Lawrence on 10/5/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import "SPStatistic.h"
#import "AsyncSocket.h"

@interface SPStatistic(){
    
    AsyncSocket * _asyncSocket;
    NSMutableData * _sendData;
    
}

@end
@implementation SPStatistic


-(void)getCarSpeedStatisticInfoWithCarVin:(NSString *)carVin andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime{
    
    _asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [_asyncSocket setRunLoopModes:[NSArray arrayWithObjects:NSRunLoopCommonModes, nil]];
    NSError *err = nil;
    
    
    if([_asyncSocket connectToHost:@"222.44.43.177" onPort:9048 error:&err])
        
    {
        
        NSLog(@"connect sucess");
        
        NSString * carList = [NSString stringWithFormat:@"8,%@,%@,%@\r\n",carVin,startTime,endTime];
        
        NSLog(@"car statistc send msg %@",carList);
        _sendData = [[carList dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        
    }
    else{
        
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器链接失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
        
    }

    
}


-(void)getCarMilesStatisticInfoWithCarVin:(NSString *)carVin andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime{
    
    
    _asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [_asyncSocket setRunLoopModes:[NSArray arrayWithObjects:NSRunLoopCommonModes, nil]];
    NSError *err = nil;
    
    
    if([_asyncSocket connectToHost:@"222.44.43.177" onPort:9048 error:&err])
        
    {
        
        NSLog(@"connect sucess");
        
        NSString * carList = [NSString stringWithFormat:@"9,%@,%@,%@\r\n",carVin,startTime,endTime];
        
        NSLog(@"car statistc send msg %@",carList);
        _sendData = [[carList dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        
    }
    else{
        
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器链接失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
        
    }

}

-(void)getCarWarningStatisticInfoWithCarVin:(NSString *)carVin andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime{
    
    
    _asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [_asyncSocket setRunLoopModes:[NSArray arrayWithObjects:NSRunLoopCommonModes, nil]];
    NSError *err = nil;
    
    
    if([_asyncSocket connectToHost:@"222.44.43.177" onPort:9048 error:&err])
        
    {
        
        NSLog(@"connect sucess");
        
        NSString * carList = [NSString stringWithFormat:@"10,%@,%@,%@\r\n",carVin,startTime,endTime];
        
        NSLog(@"car statistc send msg %@",carList);
        _sendData = [[carList dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        
    }
    else{
        
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器链接失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
        
    }

}

-(void)getCarStatisticInfoType:(int)type WithCarVin:(NSString *)carVin andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime{
    
    switch (type) {
        case 8:
            [self getCarSpeedStatisticInfoWithCarVin:carVin andStartTime:startTime andEndTime:endTime];
            break;
        case 9:
            [self getCarMilesStatisticInfoWithCarVin:carVin andStartTime:startTime andEndTime:endTime];
            break;
        case 10:
            [self getCarWarningStatisticInfoWithCarVin:carVin andStartTime:startTime andEndTime:endTime];
        default:
            [self getCarWarningStatisticInfoWithCarVin:carVin andStartTime:startTime andEndTime:endTime];
            break;
    }
    
}


#pragma mark -
#pragma mark net method
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    
    [_asyncSocket writeData:_sendData withTimeout:-1 tag:1];
    [_asyncSocket readDataWithTimeout:-1 tag:1];
    
    
}


-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    NSString * resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self.delegate getStatisticInfo:resultStr];
    
    
}

@end
