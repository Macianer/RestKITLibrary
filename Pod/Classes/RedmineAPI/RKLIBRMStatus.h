//
//  RKLIBRMStatus.h
//  Pods
//
//  Created by Ronny Meissner on 07/10/14.
//
//

#import <Foundation/Foundation.h>

@interface RKLIBRMStatus : NSObject
@property (nonatomic, strong) NSNumber *statusId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *isDefault;
@property (nonatomic, strong) NSNumber *isClosed;
@end
