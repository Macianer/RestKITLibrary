//
//  RKLIBRMMappingHelper.m
//  RestKit_Redmine_API_Example
//
//  Created by Ronny Meissner on 13.02.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import "RKLIBRMMappingHelper.h"


@implementation RKLIBRMMappingHelper

+ (RKObjectMapping *)projectMapping {
	RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBRMProject class]];

	[mapping addAttributeMappingsFromArray:@[@"name", @"identifier", @"homepage"]];
	[mapping addAttributeMappingsFromDictionary:@{ @"id" : @"projectId",
	                                               @"description" : @"descriptionString",
	                                               @"created_on" : @"createdOn",
	                                               @"update_on" : @"updateOn",
	                                               @"is_public" : @"isPublic", }];
	return mapping;
}

+ (RKObjectMapping *)issuesMapping {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBRMProject class]];
    [mapping addAttributeMappingsFromArray:@[@"offset", @"limit"]];
    [mapping addAttributeMappingsFromDictionary:@{ @"total_count" : @"totalCount"}];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"issues" toKeyPath:@"issues" withMapping:[[self class] issueMapping]]];
    return mapping;
}

+ (RKObjectMapping *)issueMapping {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBRMIssue class]];
    [mapping addAttributeMappingsFromDictionary:@{ @"id" : @"issueId",
                                                   @"subject" : @"subject",
                                                   @"description" : @"descriptionString",
                                                   @"start_date" : @"startDate",@"created_on" : @"createdOn",
                                                    @"update_on" : @"updateOn",
                                                    @"done_ratio" : @"doneRatio",}];
//    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"project" toKeyPath:@"project" withMapping:[[self class] projectMapping]]];
    return mapping;
}
@end
