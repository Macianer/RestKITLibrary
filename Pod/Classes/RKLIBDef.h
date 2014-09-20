//
//  RKLIBDef.h
//  Pods
//
//  Created by Ronny Meissner on 14/08/14.
//
//

#ifndef Pods_RKLIBDef_h
#define Pods_RKLIBDef_h

static NSString *const kTypes = @"types";
static NSString *const kGeocode = @"geocode";
static NSString *const kInput = @"input";
static NSString *const kEstablishment = @"establishment";
static NSString *const kLanguage = @"language";

// no errors occurred
static NSString *const kStatusCodeOK = @"OK";
// successful but returned no results
static NSString *const kStatusCodeZeroResults = @"ZERO_RESULTS";
// you are over your quota.
static NSString *const kStatusCodeOverQueryLimit = @"OVER_QUERY_LIMIT";
// request was denied.
static NSString *const kStatusCodeRequestDenied = @"REQUEST_DENIED";
// a query parameter is missing
static NSString *const kStatusCodeInvalidRequest = @"INVALID_REQUEST";
// unknown server error. try again.
static NSString *const kStatusCodeUnknownError = @"UNKNOWN_ERROR";

static NSString *const kJson = @"json";
static NSString *const kXml = @"xml";

static NSString *const kAddress = @"address";
static NSString *const kComponents = @"components";
static NSString *const kSensor = @"sensor";
static NSString *const kBounds = @"bounds";
static NSString *const kKey = @"key";
static NSString *const kRegion = @"region";
static NSString *const kTrue = @"true";
static NSString *const kFalse = @"false";
static NSString *const kLongTitleKey = @"long_title_key";
static NSString *const kURLKey = @"url_title_key";
static NSString *const kActionKey = @"action_key";
static NSString *const kObjectManager = @"object_manager_key";
#endif
