//
//  RKLIBDeviceHelper.m
//  Pods
//
//  Created by Ronny Meissner on 20/09/14.
//
//

#import "RKLIBDeviceHelper.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation RKLIBDeviceHelper

+ (instancetype)sharedHelperInstance {
	static RKLIBDeviceHelper *sharedHelperInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedHelperInstance = [[RKLIBDeviceHelper alloc] init];
		sharedHelperInstance.hasGPSSensor = [self hasCarrierName];
		sharedHelperInstance.hasRetinaDisplay = [UIScreen mainScreen].scale > 1;
		sharedHelperInstance.systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
	});
	return sharedHelperInstance;
}

+ (BOOL)hasCarrierName {
	CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
	if (netInfo) {
		CTCarrier *carrier = [netInfo subscriberCellularProvider];
		if ([[carrier carrierName] length] <= 0) {
			return NO;
		}
		return YES;
	}
	return NO;
}

+ (NSString *)currentlanguageCode {
	return [NSLocale canonicalLanguageIdentifierFromString:[NSLocale preferredLanguages].firstObject];
}

+ (NSString *)separatedStringFromArray:(NSArray *)strings WithSeparationString:(NSString *)sep {
	NSMutableString *mString = [[NSMutableString alloc] init];
	for (NSString *string in strings) {
		[mString appendString:string];
		[mString appendString:sep];
	}
	return [mString substringWithRange:NSMakeRange(mString.length - sep.length, sep.length)];
}

+ (UIImage *)snapshotFromView:(UIView *)view {
	// set context
	UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);

	//  iOS7 and above
	if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
		// faster
		[view drawViewHierarchyInRect:view.frame afterScreenUpdates:NO];
	} else { // iOS 6 and slow
		[view.layer renderInContext:UIGraphicsGetCurrentContext()];
	}

	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

	UIGraphicsEndImageContext();

	return image;
}

- (NSString *)platform {
	int mib[2];
	size_t len;
	char *machine;

	mib[0] = CTL_HW;
	mib[1] = HW_MACHINE;
	sysctl(mib, 2, NULL, &len, NULL, 0);
	machine = malloc(len);
	sysctl(mib, 2, machine, &len, NULL, 0);

	NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
	free(machine);
	return platform;
}

@end
