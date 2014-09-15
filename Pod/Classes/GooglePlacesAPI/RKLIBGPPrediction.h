//
//  RKLIBGPPrediction.h
//  RestKit_Geocoding_API_Example
//
//  Created by Ronny Meissner on 28.03.14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RKLIBGPPrediction : NSObject
@property (nonatomic, strong) NSString *predictionDescription;
@property (nonatomic, strong) NSString *predictionId;
@property (nonatomic, strong) NSString *placeId;
@property (nonatomic, strong) NSString *reference;
@property (nonatomic, strong) NSArray *terms;
@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) NSArray *matchedSubstrings;
@end
