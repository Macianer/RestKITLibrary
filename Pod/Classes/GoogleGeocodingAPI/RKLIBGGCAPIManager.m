//
//  RKLIBGGCMapper.m
//  RestKITLibraryFramework
//
//  Created by Ronny Meissner on 26/08/14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import "RKLIBGGCAPIManager.h"
#import "RKLIBDeviceHelper.h"

@implementation RKLIBGGCAPIManager

+ (instancetype)sharedManager {
	static RKLIBGGCAPIManager *sharedMapper = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    sharedMapper = [[RKLIBGGCAPIManager alloc] init];
	});
	return sharedMapper;
}

/*!
 *   @return A RKObjectManager for Google Geocoding API.
 */
- (RKObjectManager *)objectManager {
	if (!_objectManager) {
		[self _initObjectManager];
	}
	return _objectManager;
}

/*!
 *  @brief Configure a RKObjectManager for Google Geocoding requests.
 */
- (void)_initObjectManager {
	RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:[AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kGGCAPIUrl]]];

	[objectManager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];


	RKResponseDescriptor *res = [RKResponseDescriptor responseDescriptorWithMapping:[RKLIBGGCMappingHelper responseMapping] method:RKRequestMethodGET pathPattern:kJson keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:RKStatusCodeClassSuccessful]];
	[objectManager addResponseDescriptor:res];
	_objectManager = objectManager;
}

/*!
 *  @brief Cancel all pending Google Geocoding requests.
 */
- (void)cancelPendingRequests {
	// cancel all pending requests
	[self.objectManager cancelAllObjectRequestOperationsWithMethod:RKRequestMethodGET matchingPathPattern:kJson];
}

/*!
 *  @brief
 *  @note  address or components is required parameter.
 *  @param address    An Address for geocoding.
 *  @param components A component filter
 *  @param bounds     The bounding box d . "This parameter will only influence, not fully restrict, results from the geocoder" (see https://developers.google.com/maps/documentation/geocoding/).
 *  @param key        //
 *  @param language   //
 *  @param region     
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
- (void)getByStringAddress:(NSString *)address
        components:(NSString *)components
            bounds:(NSString *)bounds
               key:(NSString *)key
          language:(NSString *)language
            region:(NSString *)region
           success:(void (^)(RKObjectRequestOperation *operation, RKLIBGGCResponse *response))success
           failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure {
	
    NSAssert(address || components,  @"Required parameters are not set");

	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

	if (address)
		[dict addEntriesFromDictionary:@{ kAddress : address }];
	if (components)
		[dict addEntriesFromDictionary:@{ kComponents : components }];
	if (bounds)
		[dict addEntriesFromDictionary:@{ kBounds : bounds }];
	if (key)
		[dict addEntriesFromDictionary:@{ kKey : key }];
	if (language)
		[dict addEntriesFromDictionary:@{ kLanguage : language }];
	if (region)
		[dict addEntriesFromDictionary:@{ kRegion : region }];



	[dict addEntriesFromDictionary:@{ kSensor : [RKLIBDeviceHelper sharedHelperInstance].hasGPSSensor ? kTrue : kFalse }];

	[[self objectManager] getObjectsAtPath:kJson
	                            parameters:dict success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
	    if ([mappingResult.firstObject isKindOfClass:[RKLIBGGCResponse class]]) {
	        RKLIBGGCResponse *response = mappingResult.firstObject;
	        success(operation, response);
		}
	} failure: ^(RKObjectRequestOperation *operation, NSError *error) {
	    failure(operation, error);
	}];
}

@end
