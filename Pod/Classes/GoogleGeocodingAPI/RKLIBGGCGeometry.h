//
//  RKLIBGGCGeometry.h
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 28.03.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKLIBGGCLocation.h"
#import "RKLIBGGCViewport.h"

@interface RKLIBGGCGeometry : NSObject

@property (nonatomic, strong) RKLIBGGCLocation *location;
@property (nonatomic, strong) NSString *locationType;
@property (nonatomic, strong) RKLIBGGCViewport *viewport;
@property (nonatomic, strong) RKLIBGGCViewport *bounds;

@end
