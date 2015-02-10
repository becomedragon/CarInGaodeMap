//
//  SPUser.m
//  SeguesProduct
//
//  Created by Lawrence on 14-9-27.
//  Copyright (c) 2014年 dzs.com. All rights reserved.
//

#import "SPUser.h"
#import "AsyncSocket.h"


@interface SPUser(){
    
    AsyncSocket * asyncSocket;
    NSString * _username;
    NSString * _password;
    
}
@end
@implementation SPUser

-(void)logonWithName:(NSString *)userName AndPassword:(NSString *)password{
    
    
    asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [asyncSocket setRunLoopModes:[NSArray arrayWithObjects:NSRunLoopCommonModes, nil]];
    NSError *err = nil;
    
    
    if([asyncSocket connectToHost:@"222.44.43.177" onPort:9048 error:&err])
        
    {
        
        NSLog(@"connect sucess");
        _username = userName;
        _password = password;
        
    }
    else{
        
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务器链接失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
        
    }
    
    NSLog(@"username is %@, password is %@",userName,password);
    
}


-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    
    NSString * logonMsg = [NSString stringWithFormat:@"0,%@,%@\r\n",_username,_password];
    //NSString * logonMsg = @"0,yanshi,yanshi123\r\n";

    NSData * sendData = [logonMsg dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"send data is %@",logonMsg);
    [asyncSocket writeData:sendData withTimeout:-1 tag:1];
    [asyncSocket readDataWithTimeout:-1 tag:1];
    //[asyncSocket disconnect];

}


-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    NSString * resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self.delegate getLogonResultFromServer:resultStr];
    [asyncSocket disconnect];

}


@end
