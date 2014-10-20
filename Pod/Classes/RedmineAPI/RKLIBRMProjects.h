//
//  RKLIBRMProjects.h
//  Pods
//
//  Created by Ronny Meissner on 18/10/14.
//
//

#import <Foundation/Foundation.h>
#import "RKLIBRMProject.h"
@interface RKLIBRMProjects : NSObject
@property (strong, nonatomic) NSArray *projects;
@property (strong, nonatomic) NSNumber *limit;
@property (strong, nonatomic) NSNumber *offset;
@property (strong, nonatomic) NSNumber *totalCount;

@end
