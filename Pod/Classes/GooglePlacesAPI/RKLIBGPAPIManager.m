//
//  RKLIBGPMapper.m
//  RestKITLibraryFramework
//
//  Created by Ronny Meissner on 26/08/14.
//  Copyright (c) 2014 Ronny Meissner. All rights reserved.
//

#import "RKLIBGPAPIManager.h"
#import "RKLIBDeviceHelper.h"

@implementation RKLIBGPAPIManager
{
	NSString *_key;
}

+ (instancetype)sharedManager {
	static RKLIBGPAPIManager *sharedMapper = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    sharedMapper = [[RKLIBGPAPIManager alloc] init];
	});
	return sharedMapper;
}

- (RKObjectManager *)objectManager {
	if (!_objectManager) {
		[self _initObjectManager];
	}
	return _objectManager;
}

- (void)configureWithAPI:(NSString *)apiKey {
	_key = apiKey;
}

/*!
 *  Configure a RKObjectManager for Google Places Autocomplete requests.
 */
- (void)_initObjectManager {
	RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:[AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kGPAPIUrl]]];

	[objectManager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];


	RKResponseDescriptor *res = [RKResponseDescriptor responseDescriptorWithMapping:[RKLIBGPMappingHelper responseMapping] method:RKRequestMethodGET pathPattern:kJson keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:RKStatusCodeClassSuccessful]];
	[objectManager addResponseDescriptor:res];
	_objectManager = objectManager;
}

/*!
 *  @brief A method to access the Place Autocomplete service.
 *
 *  @param input      The text string on which to search. (required)
 *  @param key        A required API key for Maps API. ()
 *  @param offset     An offset value for ipnut string. If 0 no offset is set and the input term
 *  @param location   An location definition as point for special search place.
 *  @param radius     An radius value to declare the search distance for a location.
 *  @param language   The language for the results.
 *  @param types      An array of types to filter the results.
 *  @param components An array of components to filter the results.
 *  @param success    A block object to be executed when the request operation finishes successfully.
 *  @param failure    A block object to be executed when the request operation finishes unsuccessfully.
 */
- (void)getInput:(NSString *)input
             key:(NSString *)key
          offset:(NSUInteger)offset
        location:(CLLocationCoordinate2D)location
          radius:(float)radius
        language:(NSString *)language
           types:(NSArray *)types
      components:(NSArray *)components
         success:(void (^)(RKObjectRequestOperation *operation, RKLIBGPResponse *response))success
         failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure {
	NSString *offsetString = nil;
	NSString *locationString = nil;
	NSString *radiusString = nil;
	NSString *typesString = nil;
	NSString *componentsString = nil;

	if (offset > 0) {
		offsetString = [NSString stringWithFormat:@"%d", offset];
	}

	if (location.latitude != NSNotFound && location.longitude != NSNotFound) {
		locationString = [NSString stringWithFormat:@"%0.4f,%0.4f", location.latitude, location.longitude];
	}
	if (radius > 0.0 && !isnan(radius) && !isinf(radius)) {
		radiusString = [NSString stringWithFormat:@"%0.2f", radius];
	}

	if (types.count > 0) {
		typesString = [RKLIBDeviceHelper separatedStringFromArray:types WithSeparationString:@","];
	}
	if (components.count > 0) {
		componentsString = [RKLIBDeviceHelper separatedStringFromArray:components WithSeparationString:@","];
	}
	[self getByStringInput:input key:key offset:offsetString location:locationString radius:radiusString language:language types:typesString components:componentsString success:success failure:failure];
}

- (void)getByStringInput:(NSString *)input
                     key:(NSString *)key
                  offset:(NSString *)offset
                location:(NSString *)location
                  radius:(NSString *)radius
                language:(NSString *)language
                   types:(NSString *)types
              components:(NSString *)components
                 success:(void (^)(RKObjectRequestOperation *operation, RKLIBGPResponse *response))success
                 failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure {
	NSAssert(input, @"input string is required");
	NSAssert(key, @"API-Key is required");

	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

	if (input)
		[dict addEntriesFromDictionary:@{ kInput : input }];

	if (components)
		[dict addEntriesFromDictionary:@{ kComponents : components }];

	if (key)
		[dict addEntriesFromDictionary:@{ kKey : key }];

	if (offset)
		[dict addEntriesFromDictionary:@{ kOffset : offset }];

	if (location)
		[dict addEntriesFromDictionary:@{ kLocation : location }];

	if (radius)
		[dict addEntriesFromDictionary:@{ kRadius: radius }];

	if (language)
		[dict addEntriesFromDictionary:@{ kLanguage : language }];

	if (types)
		[dict addEntriesFromDictionary:@{ kTypes : types }];

	if (components)
		[dict addEntriesFromDictionary:@{ kComponents : components }];

	[self.objectManager getObjectsAtPath:kJson parameters:dict success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
	    if ([mappingResult.firstObject isKindOfClass:[RKLIBGPResponse class]]) {
	        RKLIBGPResponse *response = mappingResult.firstObject;
	        success(operation, response);
		}
	} failure: ^(RKObjectRequestOperation *operation, NSError *error) {
	    failure(operation, error);
	}];
}

@end
