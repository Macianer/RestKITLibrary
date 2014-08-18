//
//  MappingHelper.h
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 13.02.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

// https://developers.google.com/maps/documentation/geocoding/
#import <Foundation/Foundation.h>
#import "RKLIBGGCGeometry.h"
#import "RKLIBGGCLocation.h"
#import "RKLIBGGCResponse.h"
#import "RKLIBGGCResult.h"
#import "RKLIBGGCViewport.h"
#import "RKLIBGGCAdressComponent.h"
#import <RestKit/RestKit.h>

@interface RKLIBGGCMappingHelper : NSObject

+ (RKObjectMapping *) responseMapping;
+ (RKObjectMapping *) resultMapping;
+ (RKObjectMapping *) adressComponentMapping;
+ (RKObjectMapping *) locationMapping;
+ (RKObjectMapping *) viewportMapping;
+ (RKObjectMapping *) geometryMapping;
@end
