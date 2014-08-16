//
//  MappingHelper.m
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 13.02.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import "RKLIBGGCMappingHelper.h"


@implementation RKLIBGGCMappingHelper

+ (RKObjectMapping *) geometryMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGGCGeometry class]];
      [mapping addAttributeMappingsFromDictionary:@{@"location_type" : @"locationType"}];
     [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:[RKLIBGGCMappingHelper locationMapping] ]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"viewport" toKeyPath:@"viewport" withMapping:[RKLIBGGCMappingHelper viewportMapping] ]];
    return mapping;
}

+ (RKObjectMapping *) viewportMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGGCViewport class]];
     [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"southwest" toKeyPath:@"southwest" withMapping:[RKLIBGGCMappingHelper locationMapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"northeast" toKeyPath:@"northeast" withMapping:[RKLIBGGCMappingHelper locationMapping]]];
    return mapping;
}
+ (RKObjectMapping *) locationMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGGCLocation class]];
    [mapping addAttributeMappingsFromArray:@[@"lat",@"lng"]];
    return mapping;
}

+ (RKObjectMapping *) adressComponentMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGGCAdressComponent class]];
      [mapping addAttributeMappingsFromDictionary:@{@"long_name" : @"longName",
                                                    @"short_name" : @"shortName"}];
    [mapping addAttributeMappingsFromDictionary:@{@"types" : @"types"}];
     return mapping;
}
+ (RKObjectMapping *) resultMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGGCResult class]];
    [mapping addAttributeMappingsFromDictionary:@{@"formatted_address" : @"formattedAddress"}];
    [mapping addAttributeMappingsFromDictionary:@{@"types" : @"types"}];
     [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"geometry" toKeyPath:@"geometry" withMapping:[RKLIBGGCMappingHelper geometryMapping] ]];
     [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"address_components" toKeyPath:@"adressComponents" withMapping:[RKLIBGGCMappingHelper adressComponentMapping] ]];
    return mapping;
}

+ (RKObjectMapping *) responseMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBGGCResponse class]];
    
    [mapping addAttributeMappingsFromDictionary:@{@"status" : @"status"}];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"results" toKeyPath:@"result" withMapping:[RKLIBGGCMappingHelper resultMapping] ]];
    
    return mapping;
}
@end
