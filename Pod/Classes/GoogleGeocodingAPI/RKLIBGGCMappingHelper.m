//
//  RKLIBGGCMappingHelper.m
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 13.02.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import "RKLIBGGCMappingHelper.h"


@implementation RKLIBGGCMappingHelper


/*!
 *  @brief Define a mapping for json responses of type 'geometry' and RKLIBGGCGeometry objects.
 *
 *  @return A 'RKMappingObject' for RKLIBGGCGeometry objects.
 */
+ (RKObjectMapping *)geometryMapping {
	RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGGCGeometry class]];
	[mapping addAttributeMappingsFromDictionary:@{ @"location_type" : @"locationType" }];
	[mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:[RKLIBGGCMappingHelper locationMapping]]];
	[mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"viewport" toKeyPath:@"viewport" withMapping:[RKLIBGGCMappingHelper viewportMapping]]];
	[mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"bounds" toKeyPath:@"bounds" withMapping:[RKLIBGGCMappingHelper viewportMapping]]];
	return mapping;
}

/*!
 *  @brief Define a mapping for json responses of type 'viewport' and RKLIBGGCViewport objects.
 *
 *  @return A 'RKMappingObject' for RKLIBGGCViewport objects.
 */
+ (RKObjectMapping *)viewportMapping {
	RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGGCViewport class]];
	[mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"southwest" toKeyPath:@"southwest" withMapping:[RKLIBGGCMappingHelper locationMapping]]];
	[mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"northeast" toKeyPath:@"northeast" withMapping:[RKLIBGGCMappingHelper locationMapping]]];
	return mapping;
}

/*!
 *  @brief Define a mapping for json responses of type 'location' and RKLIBGGCLocation objects.
 *
 *  @return A 'RKMappingObject' for RKLIBGGCLocation objects.
 */
+ (RKObjectMapping *)locationMapping {
	RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGGCLocation class]];
	[mapping addAttributeMappingsFromArray:@[@"lat", @"lng"]];
	return mapping;
}

/*!
 *  @brief Define a mapping for json responses of type 'address_component' and RKLIBGGCAddressComponent objects.
 *
 *  @return A 'RKMappingObject' for RKLIBGGCAddressComponent objects.
 */
+ (RKObjectMapping *)adressComponentMapping {
	RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGGCAddressComponent class]];
	[mapping addAttributeMappingsFromDictionary:@{ @"long_name" : @"longName",
	                                               @"short_name" : @"shortName" }];
	[mapping addAttributeMappingsFromDictionary:@{ @"types" : @"types" }];
	return mapping;
}

/*
 *  @brief Define a mapping for json responses of type 'result' and RKLIBGGCResult objects.
 *
 *  @return A 'RKMappingObject' for RKLIBGGCResult objects.
 */
+ (RKObjectMapping *)resultMapping {
	RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGGCResult class]];
	[mapping addAttributeMappingsFromDictionary:@{ @"formatted_address" : @"formattedAddress" }];
	[mapping addAttributeMappingsFromDictionary:@{ @"types" : @"types" }];
	[mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"geometry" toKeyPath:@"geometry" withMapping:[RKLIBGGCMappingHelper geometryMapping]]];
	[mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"address_components" toKeyPath:@"addressComponents" withMapping:[RKLIBGGCMappingHelper adressComponentMapping]]];
	return mapping;
}

/*!
 *  @brief Define a mapping for json responses of type 'response' and RKLIBGGCResponse objects.
 *
 *  @return A 'RKMappingObject' for RKLIBGGCResponse objects.
 */
+ (RKObjectMapping *)responseMapping {
	RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGGCResponse class]];

	[mapping addAttributeMappingsFromDictionary:@{ @"status" : @"status" }];
	[mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"results" toKeyPath:@"results" withMapping:[RKLIBGGCMappingHelper resultMapping]]];

	return mapping;
}

@end
