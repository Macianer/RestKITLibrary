//
//  RKLIBGPMappingTests.m
//  RestKITLibrary
//
//  Created by Ronny Meissner on 14/09/14.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <RestKit/Testing.h>
#import <RestKITLibrary/RKLIBGPMappingHelper.h>

@interface RKLIBGPMappingTests : XCTestCase

@end

@implementation RKLIBGPMappingTests

- (void)setUp {
    
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
	NSBundle *testBundle = [NSBundle mainBundle];
	testBundle = [NSBundle bundleForClass:[self class]];

	[RKTestFixture setFixtureBundle:testBundle];
}

- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}

- (void)testMappingPathsFile1 {
    
	id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"gp_file1.json"];

	RKMappingTest *mappingTest = [RKMappingTest testForMapping:[RKLIBGPMappingHelper responseMapping] sourceObject:json destinationObject:nil];

	[mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"status" destinationKeyPath:@"status"]];

	XCTAssertTrue([mappingTest evaluate], @"The status has not been set up!");

	[mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"predictions" destinationKeyPath:@"predictions"]];

	XCTAssertTrue([mappingTest evaluate], @"The predictions has not been set up!");
}

- (void)testMappingValuesFile1 {
	
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"gp_file1.json"];

	RKMappingTest *mappingTest = [RKMappingTest testForMapping:[RKLIBGPMappingHelper responseMapping] sourceObject:json destinationObject:nil];

	[mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"status" destinationKeyPath:@"status" value:@"OK"]];

	XCTAssertTrue([mappingTest evaluate], @"The status has not been set up!");

	[mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"predictions" destinationKeyPath:@"predictions" evaluationBlock: ^BOOL (RKPropertyMappingTestExpectation *expectation, RKPropertyMapping *mapping, id mappedValue, NSError *__autoreleasing *error) {
	        if (![mappedValue isKindOfClass:[NSArray class]])
				return false;
	        NSArray * predictions = mappedValue;
	        if (predictions.count != 3)
				return false;



	        //
	        // start first prediction test
	        //

	        RKLIBGPPrediction * testPrediction = predictions[0];

	        if ([testPrediction.predictionDescription compare:@"Paris, France"] != NSOrderedSame)
				return false;

	        if ([testPrediction.predictionId compare:@"691b237b0322f28988f3ce03e321ff72a12167fd"] != NSOrderedSame)
				return false;

	        RKLIBGPMatchedSubstring * mss = testPrediction.matchedSubstrings[0];
	        if ([mss.length compare:@5] != NSOrderedSame || [mss.offset compare:@0])
				return false;

	        if ([testPrediction.placeId compare:@"ChIJD7fiBh9u5kcRYJSMaMOCCwQ"] != NSOrderedSame)
				return false;

	        if ([testPrediction.reference compare:@"CjQlAAAA_KB6EEceSTfkteSSF6U0pvumHCoLUboRcDlAH05N1pZJLmOQbYmboEi0SwXBSoI2EhAhj249tFDCVh4R-PXZkPK8GhTBmp_6_lWljaf1joVs1SH2ttB_tw"] != NSOrderedSame)
				return false;

	        RKLIBGPTerm * term = testPrediction.terms[0];
	        if ([term.offset compare:@0] != NSOrderedSame)
				return false;
	        if ([term.value compare:@"Paris"] != NSOrderedSame)
				return false;
	        term = testPrediction.terms[1];
	        if ([term.offset compare:@7] != NSOrderedSame)
				return false;
	        if ([term.value compare:@"France"] != NSOrderedSame)
				return false;
	        NSString * type = testPrediction.types[0];
	        if ([type compare:@"locality"] != NSOrderedSame)
				return false;
	        type = testPrediction.types[1];
	        if ([type compare:@"political"] != NSOrderedSame)
				return false;
	        type = testPrediction.types[2];
	        if ([type compare:@"geocode"] != NSOrderedSame)
				return false;

	        //
	        // start second prediction test
	        //

	        testPrediction = predictions[1];

	        if ([testPrediction.predictionDescription compare:@"Paris Avenue, Earlwood, New South Wales, Australia"] != NSOrderedSame)
				return false;

	        if ([testPrediction.predictionId compare:@"359a75f8beff14b1c94f3d42c2aabfac2afbabad"] != NSOrderedSame)
				return false;

	        mss = testPrediction.matchedSubstrings[0];
	        if ([mss.length compare:@5] != NSOrderedSame || [mss.offset compare:@0])
				return false;

	        if ([testPrediction.placeId compare:@"ChIJrU3KAHG6EmsR5Uwfrk7azrI"] != NSOrderedSame)
				return false;

	        if ([testPrediction.reference compare:@"CkQ2AAAARbzLE-tsSQPgwv8JKBaVtbjY48kInQo9tny0k07FOYb3Z_z_yDTFhQB_Ehpu-IKhvj8Msdb1rJlX7xMr9kfOVRIQVuL4tOtx9L7U8pC0Zx5bLBoUTFbw9R2lTn_EuBayhDvugt8T0Oo"] != NSOrderedSame)
				return false;

	        term = testPrediction.terms[0];
	        if ([term.offset compare:@0] != NSOrderedSame)
				return false;
	        if ([term.value compare:@"Paris Avenue"] != NSOrderedSame)
				return false;
	        term = testPrediction.terms[1];
	        if ([term.offset compare:@14] != NSOrderedSame)
				return false;
	        if ([term.value compare:@"Earlwood"] != NSOrderedSame)
				return false;
	        term = testPrediction.terms[2];
	        if ([term.offset compare:@24] != NSOrderedSame)
				return false;
	        if ([term.value compare:@"New South Wales"] != NSOrderedSame)
				return false;
	        term = testPrediction.terms[3];
	        if ([term.offset compare:@41] != NSOrderedSame)
				return false;
	        if ([term.value compare:@"Australia"] != NSOrderedSame)
				return false;

	        type = testPrediction.types[0];
	        if ([type compare:@"route"] != NSOrderedSame)
				return false;
	        type = testPrediction.types[1];
	        if ([type compare:@"geocode"] != NSOrderedSame)
				return false;

	        //
	        // start third prediction test
	        //

	        testPrediction = predictions[2];

	        if ([testPrediction.predictionDescription compare:@"Paris Street, Carlton, New South Wales, Australia"] != NSOrderedSame)
				return false;

	        if ([testPrediction.predictionId compare:@"bee539812eeda477dad282bcc8310758fb31d64d"] != NSOrderedSame)
				return false;

	        mss = testPrediction.matchedSubstrings[0];
	        if ([mss.length compare:@5] != NSOrderedSame || [mss.offset compare:@0])
				return false;

	        if ([testPrediction.placeId compare:@"ChIJCfeffMi5EmsRp7ykjcnb3VY"] != NSOrderedSame)
				return false;

	        if ([testPrediction.reference compare:@"CkQ1AAAAAERlxMXkaNPLDxUJFLm4xkzX_h8I49HvGPvmtZjlYSVWp9yUhQSwfsdveHV0yhzYki3nguTBTVX2NzmJDukq9RIQNcoFTuz642b4LIzmLgcr5RoUrZhuNqnFHegHsAjtoUUjmhy4_rA"] != NSOrderedSame)
				return false;

	        term = testPrediction.terms[0];
	        if ([term.offset compare:@0] != NSOrderedSame)
				return false;
	        if ([term.value compare:@"Paris Street"] != NSOrderedSame)
				return false;
	        term = testPrediction.terms[1];
	        if ([term.offset compare:@14] != NSOrderedSame)
				return false;
	        if ([term.value compare:@"Carlton"] != NSOrderedSame)
				return false;
	        term = testPrediction.terms[2];
	        if ([term.offset compare:@23] != NSOrderedSame)
				return false;
	        if ([term.value compare:@"New South Wales"] != NSOrderedSame)
				return false;
	        term = testPrediction.terms[3];
	        if ([term.offset compare:@40] != NSOrderedSame)
				return false;
	        if ([term.value compare:@"Australia"] != NSOrderedSame)
				return false;

	        type = testPrediction.types[0];
	        if ([type compare:@"route"] != NSOrderedSame)
				return false;
	        type = testPrediction.types[1];
	        if ([type compare:@"geocode"] != NSOrderedSame)
				return false;

	        return true;
		}]];

	XCTAssertTrue([mappingTest evaluate], @"The predictions has not been set up!");
}

- (void)testPerformanceExample {
	// This is an example of a performance test case.
	[self measureBlock: ^{
        id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"gp_file1.json"];
        
        RKMappingTest *mappingTest = [RKMappingTest testForMapping:[RKLIBGPMappingHelper responseMapping] sourceObject:json destinationObject:nil];
        
        [mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"predictions" destinationKeyPath:@"predictions" evaluationBlock:^BOOL(RKPropertyMappingTestExpectation *expectation, RKPropertyMapping *mapping, id mappedValue, NSError *__autoreleasing *error) {
            NSArray *predictions = mappedValue;
            if (predictions.count != 3) {
                return false;
            }
            return true;
        }]];
        XCTAssertTrue([mappingTest evaluate], @"The predictions count is not correct!");
	}];
}

@end
