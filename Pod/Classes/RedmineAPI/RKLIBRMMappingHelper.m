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
+ (RKObjectMapping *)projectsMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBRMProjects class]];
    
    [mapping addAttributeMappingsFromArray:@[@"limit", @"offset"]];
    [mapping addAttributeMappingsFromDictionary:@{ @"total_count" : @"totalCount",
                                                   }];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"projects" toKeyPath:@"projects" withMapping:[[self class] projectMapping]]];
    return mapping;
}
+ (RKObjectMapping *)issuesMapping {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBRMIssues class]];
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
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"project" toKeyPath:@"project" withMapping:[[self class] projectMapping]]];
    
     [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"tracker" toKeyPath:@"tracker" withMapping:[[self class] trackerMapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"status" toKeyPath:@"status" withMapping:[[self class] statusMapping]]];
     [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"author" toKeyPath:@"author" withMapping:[[self class] authorMapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"assigned_to" toKeyPath:@"assignedTo" withMapping:[[self class] authorMapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"category" toKeyPath:@"category" withMapping:[[self class] categoryMapping]]];
    [mapping addAttributeMappingsFromDictionary:@{ @"parent.id" : @"parentId",
                                                 
                                                   }];
    return mapping;
}
+ (RKObjectMapping *)categoryMapping {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBRMCategory class]];
    
    [mapping addAttributeMappingsFromDictionary:@{ @"id" : @"categoryId",
                                                   @"name" : @"name",
                                                   }];
    
    return mapping;
}
+ (RKObjectMapping *)authorMapping {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBRMAuthor class]];
    
    [mapping addAttributeMappingsFromDictionary:@{ @"id" : @"authorId",
                                                   @"name" : @"name",
                                                   }];
    
    return mapping;
}
+ (RKObjectMapping *)statusMapping {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBRMStatus class]];
    
    [mapping addAttributeMappingsFromDictionary:@{ @"id" : @"statusId",
                                                   @"name" : @"name",
                                                   }];
    
    return mapping;
}
+ (RKObjectMapping *)trackerMapping {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RKLIBRMTracker class]];

    [mapping addAttributeMappingsFromDictionary:@{ @"id" : @"trackerId",
                                                   @"name" : @"name",
                                                   }];
   
    return mapping;
}
@end
