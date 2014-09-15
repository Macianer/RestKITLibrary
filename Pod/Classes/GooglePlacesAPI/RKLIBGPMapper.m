//
//  RKLIBGPMapper.m
//  RestKITLibraryFramework
//
//  Created by Ronny Meissner on 26/08/14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import "RKLIBGPMapper.h"
#import <RestKit/RestKit.h>
#import "RKLIBDef.h"
#import "RKLIBGP.h"
@implementation RKLIBGPMapper
{
    NSString *_key;
}

+(instancetype) sharedMapper
{
    static RKLIBGPMapper *sharedMapper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMapper = [[RKLIBGPMapper alloc] init];
        
    });
    return sharedMapper;
}

-(RKObjectManager *)objectManager
{
    if(!_objectManager)
    {
        [self _initObjectManager];
    }
    return _objectManager;
}
-(void) configureWithAPI: (NSString *) apiKey
{
    _key = apiKey;
}
-(void) _initObjectManager
{
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:[AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kGPAPIUrl] ]];
    
    [objectManager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];
    
    
    RKResponseDescriptor *res = [RKResponseDescriptor responseDescriptorWithMapping:[RKLIBGPMappingHelper responseMapping] method:RKRequestMethodGET pathPattern:kJson keyPath:nil statusCodes: [NSIndexSet indexSetWithIndex:RKStatusCodeClassSuccessful ]];
    [objectManager addResponseDescriptor:res];
    _objectManager = objectManager;
    
}
@end
