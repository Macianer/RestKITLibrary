//
//  RKLIBGGCMapper.m
//  RestKITLibraryFramework
//
//  Created by Ronny Meissner on 26/08/14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import "RKLIBGGCMapper.h"
#import <RestKit/RestKit.h>
#import "RKLIBDef.h"
#import "RKLIBGGC.h"

@implementation RKLIBGGCMapper

+(instancetype) sharedMapper
{
    static RKLIBGGCMapper *sharedMapper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    sharedMapper = [[RKLIBGGCMapper alloc] init];
    
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

-(void) _initObjectManager
{
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:[AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kGGCAPIUrl] ]];
    
    [objectManager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];
    
    
    RKResponseDescriptor *res = [RKResponseDescriptor responseDescriptorWithMapping:[RKLIBGGCMappingHelper responseMapping] method:RKRequestMethodGET pathPattern:kJson keyPath:nil statusCodes: [NSIndexSet indexSetWithIndex:RKStatusCodeClassSuccessful ]];
    [objectManager addResponseDescriptor:res];
    _objectManager = objectManager;
    
}
@end
