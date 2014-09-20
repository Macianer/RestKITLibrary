//
//  RKLIBGGCLocation.m
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 28.03.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import "RKLIBGGCLocation.h"

@implementation RKLIBGGCLocation

- (NSString *)description {
	return [NSString stringWithFormat:@"[latitude:%@ ;longitude: %@]", self.lat, self.lng];
}

@end
