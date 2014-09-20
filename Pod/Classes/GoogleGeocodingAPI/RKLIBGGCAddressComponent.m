//
//  RKLIBGGCAddressComponent.m
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 28.03.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import "RKLIBGGCAddressComponent.h"

@implementation RKLIBGGCAddressComponent

- (NSString *)description {
	NSMutableString *mString = [[NSMutableString alloc] init];
	for (NSString *string in self.types) {
		[mString appendString:string];
		if ([self.types indexOfObject:string] != self.types.count)
			[mString appendString:@";"];
	}

	return [NSString stringWithFormat:@"%@,%@,%@", self.longName, self.shortName, mString];
}

@end
