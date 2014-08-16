//
//  GCViewport.h
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 28.03.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKLIBGGCLocation.h"
@interface RKLIBGGCViewport : NSObject
@property (nonatomic, strong) RKLIBGGCLocation *southwest;
@property (nonatomic, strong) RKLIBGGCLocation *northeast;
@end
