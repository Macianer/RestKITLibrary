//
//  RKLIBGGCGeometry.m
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 28.03.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import "RKLIBGGCGeometry.h"

@implementation RKLIBGGCGeometry

-(NSString *)description
{
    return [NSString stringWithFormat:@"[location: %@; [locationType: %@]; viewport %@]",[self.location description],self.locationType, [self.viewport description]  ];
}
@end
