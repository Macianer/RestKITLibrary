//
//  RKLIBGPResponse.h
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 28.03.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKLIBGPResponse : NSObject
@property (nonatomic ,strong ) NSString *status;
@property (nonatomic ,strong ) NSArray *predictions;
@end
