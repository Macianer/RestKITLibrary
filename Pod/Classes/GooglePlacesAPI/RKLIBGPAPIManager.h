//
//  RKLIBGPMapper.h
//  RestKITLibraryFramework
//
//  Created by Ronny Meissner on 26/08/14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "RKLIBDef.h"
#import "RKLIBGP.h"
#import <CoreLocation/CoreLocation.h>
@class RKObjectManager;

/*!
 *  Configure a API Object for Google Geocoding requests.
 *
 *  @return A RKObjectManager for Google Geocoding API.
 */
@interface RKLIBGPAPIManager : NSObject
@property (nonatomic, strong) RKObjectManager *objectManager;
+ (instancetype)sharedMapper;
- (void)getInput:(NSString *)input
             key:(NSString *)key
          offset:(NSUInteger)offset
        location:(CLLocationCoordinate2D)location
          radius:(float)radius
        language:(NSString *)language
           types:(NSArray *)types
      components:(NSArray *)components
         success:(void (^)(RKObjectRequestOperation *operation, RKLIBGPResponse *response))success
         failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;
@end
