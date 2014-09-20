//
//  RKLIBGGCResponse.h
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 28.03.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKLIBGGCResult.h"
@interface RKLIBGGCResponse : NSObject
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSArray *results;
@end
