//
//  RKLIBGPMappingHelper.h
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 13.02.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "RKLIBGP.h"

@interface RKLIBGPMappingHelper : NSObject

+ (RKObjectMapping *) responseMapping;
+ (RKObjectMapping *) predictionMapping;
+ (RKObjectMapping *) matchedSubstringMapping;
+ (RKObjectMapping *) termMapping;
@end
