//
//  RKLIBGGCViewport.m
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 28.03.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import "RKLIBGGCViewport.h"

@implementation RKLIBGGCViewport

- (NSString *)description {
	return [NSString stringWithFormat:@"[southwest: %@, northwest: %@]", [self.southwest description], [self.northeast description]];
}

@end
