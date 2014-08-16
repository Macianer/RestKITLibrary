//
//  RKLIBGGC.h
//  Pods
//
//  Created by Ronny Meissner on 14/08/14.
//
//

#import "RKLIBGGCMappingHelper.h"
#import "RKLIBGGCLocation.h"
#import "RKLIBGGCGeometry.h"
#import "RKLIBGGCAdressComponent.h"
#import "RKLIBGGCResponse.h"
#import "RKLIBGGCResult.h"
#import "RKLIBGGCViewport.h"

#ifndef Pods_RKLIBGGC_h
#define Pods_RKLIBGGC_h

//#define kAPI_URL @"http://maps.googleapis.com/maps/api/geocode/"
#define kAPI_PATTERN_JSON @"json"
#define kAPI_ADRESS @"address"
#define kAPI_SENSOR @"sensor"
#define kAPI_TRUE @"true"
static NSString * const kAPI_URL = @"http://maps.googleapis.com/maps/api/geocode/";
static NSString * const kLongTitleKey = @"long_title_key";
static NSString * const kURLKey = @"url_title_key";
#endif
