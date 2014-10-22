//
//  RKLIBRMIssue.h
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 28.03.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RKLIBRMProject, RKLIBRMTracker, RKLIBRMStatus, RKLIBRMAuthor, RKLIBRMCategory, RKLIBRMPriority;

@interface RKLIBRMIssue : NSObject
@property (nonatomic, strong) NSNumber *issueId;
@property (nonatomic, strong) NSNumber *parentId;
@property (nonatomic, strong) RKLIBRMProject *project;
@property (nonatomic, strong) RKLIBRMTracker *tracker;
@property (nonatomic, strong) RKLIBRMStatus *status;
@property (nonatomic, strong) RKLIBRMAuthor *author;
@property (nonatomic, strong) RKLIBRMAuthor *assignedTo;
@property (nonatomic, strong) RKLIBRMCategory *category;
@property (nonatomic, strong) RKLIBRMPriority *priority;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *descriptionString;
@property (nonatomic, strong) NSNumber *doneRatio;
@property (nonatomic, strong) NSNumber *estimatedHours;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *createdOn;
@property (nonatomic, strong) NSDate *updateOn;
@end
