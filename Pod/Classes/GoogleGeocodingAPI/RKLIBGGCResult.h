//
//  GCResult.h
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 28.03.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKLIBGGCGeometry.h"

@interface RKLIBGGCResult : NSObject
@property (nonatomic, strong) NSArray *adressComponents;
@property (nonatomic, strong) NSString *formattedAddress;
@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) RKLIBGGCGeometry *geometry;
@end
