//
//  RKLIBIssues.h
//  Pods
//
//  Created by Ronny Meissner on 07/10/14.
//
//

#import <Foundation/Foundation.h>

@interface RKLIBRMIssues : NSObject
@property (nonatomic, strong) NSArray *issues;
@property (nonatomic, strong) NSNumber *totalCount;
@property (nonatomic, strong) NSNumber *offset;
@property (nonatomic, strong) NSNumber *limit;
@end
