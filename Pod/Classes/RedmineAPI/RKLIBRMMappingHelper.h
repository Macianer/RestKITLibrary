//
//  RKLIBGPMappingHelper.h
//  RestKit_Redmine_API_Example
//
//  Created by Ronny Meissner on 13.02.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "RKLIBRM.h"

@interface RKLIBRMMappingHelper : NSObject

+ (RKObjectMapping *)projectMapping;
+ (RKObjectMapping *)projectsMapping;
+ (RKObjectMapping *)issuesMapping;
+ (RKObjectMapping *)issueMapping;
@end
