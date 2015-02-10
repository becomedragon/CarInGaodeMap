//
//  SPSetting.m
//  SeguesProduct
//
//  Created by Lawrence on 10/7/14.
//  Copyright (c) 2014 dzs.com. All rights reserved.
//

#import "SPSetting.h"
#import "AsyncSocket.h"

@interface SPSetting(){
    
    AsyncSocket * _asyncSocket;
    NSMutableData * _sendData;
    
}

@end
@implementation SPSetting

-(void)returnAdviceWithContent:(NSString *)content andContact:(NSString *)contact{
    
    
    _asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [_asyncSocket setRunLoopModes:[NSArray arrayWithObjects:NSRunLoopCommonModes, nil]];
    NSError *err = nil;
    
    
    if([_asyncSocket connectToHost:@"222.44.43.177" onPort:9048 error:&err])
        
    {
        
        NSLog(@"connect sucess");
        
        NSString * advice = [NSString stringWithFormat:@"6,%@,%@\r\n",content,contact];
        
        NSLog(@"advice send msg %@",advice);
        _sendData = [[advice dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        
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
    [self.delegate getSettingInfo:resultStr];
    
    
}

-(void)onSocketDidDisconnect:(AsyncSocket *)sock{
    
}

@end
