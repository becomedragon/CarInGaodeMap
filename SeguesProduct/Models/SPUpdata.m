//
//  SPUpdata.m
//  SeguesProduct
//
//  Created by Lawrence on 10/30/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import "SPUpdata.h"
#import "AsyncSocket.h"

@interface SPUpdata(){
    
    AsyncSocket * asyncSocket;
    
}

@end

@implementation SPUpdata


-(void)checkVersion{
    
    asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [asyncSocket setRunLoopModes:[NSArray arrayWithObjects:NSRunLoopCommonModes, nil]];
    NSError *err = nil;
    
    
    if([asyncSocket connectToHost:@"222.44.43.177" onPort:9048 error:&err])
        
    {
        
        NSLog(@"connect sucess");
       
        
    }
    else{
        
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器链接失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
        
    }
    

}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    
   // NSString * logonMsg = [NSString stringWithFormat:@"0,%@,%@\r\n",_username,_password];
    //NSString * logonMsg = @"0,yanshi,yanshi123\r\n";
    
    NSString * upDateMsg = @"\r\n";
    NSData * sendData = [upDateMsg dataUsingEncoding:NSUTF8StringEncoding];
    [asyncSocket writeData:sendData withTimeout:-1 tag:1];
    [asyncSocket readDataWithTimeout:-1 tag:1];
    //[asyncSocket disconnect];
    
}


-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    NSString * resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self.delegate getUpdateResultFromServer:resultStr];
    [asyncSocket disconnect];
    
}


@end
