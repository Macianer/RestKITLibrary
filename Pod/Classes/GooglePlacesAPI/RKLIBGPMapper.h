//
//  RKLIBGPMapper.h
//  RestKITLibraryFramework
//
//  Created by Ronny Meissner on 26/08/14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectManager;

@interface RKLIBGPMapper : NSObject
@property (nonatomic, strong) RKObjectManager *objectManager;
+(instancetype) sharedMapper;
@end
