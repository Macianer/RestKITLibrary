//
//  RKLIBGGCMapper.h
//  RestKITLibraryFramework
//
//  Created by Ronny Meissner on 26/08/14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKLIBGGC.h"
#import <RestKit/RestKit.h>
#import "RKLIBDef.h"

@class RKObjectManager;

@interface RKLIBGGCAPIManager : NSObject

@property (nonatomic, strong) RKObjectManager *objectManager;
+ (instancetype)sharedManager;

- (void)getByStringAddress:(NSString *)address
                components:(NSString *)components
                    bounds:(NSString *)bounds
                       key:(NSString *)key
                  language:(NSString *)language
                    region:(NSString *)region
                   success:(void (^)(RKObjectRequestOperation *operation, RKLIBGGCResponse *response))success
                   failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;
@end
