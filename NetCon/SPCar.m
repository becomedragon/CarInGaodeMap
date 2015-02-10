//
//  SPCar.m
//  SeguesProduct
//
//  Created by Lawrence on 14-9-27.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import "SPCar.h"
#import "AsyncSocket.h"

@interface SPCar(){
    
    AsyncSocket * _asyncSocket;
    NSMutableData * _sendData;
}

@end
@implementation SPCar



-(void)getCarsLocationWithUserName:(NSString *)username andAuth:(NSString *)auth{
    
    
    _asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [_asyncSocket setRunLoopModes:[NSArray arrayWithObjects:NSRunLoopCommonModes, nil]];
    NSError *err = nil;
    
    
    if([_asyncSocket connectToHost:@"222.44.43.177" onPort:9048 error:&err])
        
    {
        
        NSLog(@"connect sucess");
        
        NSString * carList = [NSString stringWithFormat:@"2,%@,%@\r\n",auth,username];
        _sendData = [[carList dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        
    }
    else{
        
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器链接失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
        
    }

}


-(void)getCarsRoute:(NSString *)carVin startTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    
    _asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [_asyncSocket setRunLoopModes:[NSArray arrayWithObjects:NSRunLoopCommonModes, nil]];
    NSError *err = nil;
    
    
    if([_asyncSocket connectToHost:@"222.44.43.177" onPort:9048 error:&err])
        
    {
        
        NSLog(@"connect sucess");
        
        NSString * carList = [NSString stringWithFormat:@"7,%@,%@,%@\r\n",carVin,startTime,endTime];
        
        NSLog(@"car route send msg %@",carList);
        _sendData = [[carList dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        
    }
    else{
        
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器链接失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
        
    }

    
}


-(void)getCarsData:(NSString *)carVin{
    
    _asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [_asyncSocket setRunLoopModes:[NSArray arrayWithObjects:NSRunLoopCommonModes, nil]];
    NSError *err = nil;
    
    
    if([_asyncSocket connectToHost:@"222.44.43.177" onPort:9048 error:&err])
        
    {
        
        NSLog(@"connect sucess");
        
        NSString * carData = [NSString stringWithFormat:@"4,%@\r\n",carVin];
        
        NSLog(@"car data %@",carData);
        _sendData = [[carData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        
    }
    else{
        
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器链接失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
        
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
    [self.delegate getCatrInfo:resultStr];
    
    
}




@end
