//
//  RKLIBGPMappingHelper.m
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 13.02.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import "RKLIBGPMappingHelper.h"
#import "RKLIBGPResponse.h"


@implementation RKLIBGPMappingHelper

+ (RKObjectMapping *)termMapping {
	RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGPTerm class]];

	[mapping addAttributeMappingsFromArray:@[@"value", @"offset"]];
	return mapping;
}

+ (RKObjectMapping *)matchedSubstringMapping {
	RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGPMatchedSubstring class]];
	[mapping addAttributeMappingsFromArray:@[@"length", @"offset"]];
	return mapping;
}

+ (RKObjectMapping *)predictionMapping {
	RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGPPrediction class]];
	[mapping addAttributeMappingsFromDictionary:@{ @"description" : @"predictionDescription",
	                                               @"id" : @"predictionId",
	                                               @"place_id" : @"placeId",
	                                               @"id" : @"predictionId",
	                                               @"types" : @"types", }];

	[mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"terms" toKeyPath:@"terms" withMapping:[[self class] termMapping]]];
	[mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"matched_substrings" toKeyPath:@"matchedSubstrings" withMapping:[[self class] matchedSubstringMapping]]];
	return mapping;
}

+ (RKObjectMapping *)responseMapping {
	RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGPResponse class]];

	[mapping addAttributeMappingsFromDictionary:@{ @"status" : @"status" }];
	[mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"predictions" toKeyPath:@"predictions" withMapping:[[self class] predictionMapping]]];

	return mapping;
}

@end
