//
//  RKLIBGGCResponse.m
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 28.03.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import "RKLIBGGCResponse.h"

@implementation RKLIBGGCResponse

- (NSString *)description {
	return [NSString stringWithFormat:@"[status: %@; result: %@]", self.status, [self.results description]];
}

@end
