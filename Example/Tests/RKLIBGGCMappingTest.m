//
//  RKLIBGGCMappingTest.m
//  RestKITLibrary
//
//  Created by Ronny Meissner on 14/09/14.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <RestKit/Testing.h>
#import <RestKITLibrary/RKLIBGGC.h>
@interface RKLIBGGCMappingTest : XCTestCase

@end

@implementation RKLIBGGCMappingTest

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

- (void)testMappingPathsFile1
{
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"ggc_file1.json"];
    
    RKMappingTest *mappingTest = [RKMappingTest testForMapping:[RKLIBGGCMappingHelper responseMapping] sourceObject:json destinationObject:nil];
    
    [mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"status" destinationKeyPath:@"status"]];
    
    XCTAssertTrue([mappingTest evaluate], @"The status has not been set up!");
    
    [mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"results" destinationKeyPath:@"results"]];
    
    XCTAssertTrue([mappingTest evaluate], @"The results has not been set up!");
}

- (void)testMappingValuesFile1 {
    
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"ggc_file1.json"];
    
    RKMappingTest *mappingTest = [RKMappingTest testForMapping:[RKLIBGGCMappingHelper responseMapping] sourceObject:json destinationObject:nil];
    
    [mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"status" destinationKeyPath:@"status" value:@"OK"]];
    
    XCTAssertTrue([mappingTest evaluate], @"The status has not been set up!");

    [mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"results" destinationKeyPath:@"results" evaluationBlock:^BOOL(RKPropertyMappingTestExpectation *expectation, RKPropertyMapping *mapping, id mappedValue, NSError *__autoreleasing *error) {
        NSArray *result = mappedValue;
        if(result.count != 3)
            return false;
        
        RKLIBGGCResult *testResult = result[0];
        RKLIBGGCAddressComponent *addressComponent;
        RKLIBGGCGeometry *geometry;
        RKLIBGGCLocation *location;
        NSString *string = nil;
        
        //
        // test first result
        //
        
        // test first address component
        addressComponent = testResult.addressComponents[0];
        if([addressComponent.longName compare:@"Times Square"] != NSOrderedSame)
            return false;
        if([addressComponent.shortName compare:@"Times Square"] != NSOrderedSame)
            return false;
        string = addressComponent.types[0];
        if([string compare:@"point_of_interest"] != NSOrderedSame)
            return false;
        string = addressComponent.types[1];
        if([string compare:@"establishment"] != NSOrderedSame)
            return false;
        // test last address component
        addressComponent = testResult.addressComponents[7];
        if([addressComponent.longName compare:@"10036"] != NSOrderedSame)
            return false;
        if([addressComponent.shortName compare:@"10036"] != NSOrderedSame)
            return false;
        string = addressComponent.types[0];
        if([string compare:@"postal_code"] != NSOrderedSame)
            return false;
        
        if ([testResult.formattedAddress compare:@"Times Square, Manhattan, NY 10036, USA"] != NSOrderedSame)
            return false;
        
        geometry = testResult.geometry;
        location = geometry.location;
        if([location.lat compare:@40.758895] != NSOrderedSame || [location.lng compare:@-73.985131] != NSOrderedSame )
            return false;
        if([geometry.locationType compare:@"APPROXIMATE"] != NSOrderedSame)
            return false;
        
        location = geometry.viewport.northeast;
        if([location.lat compare:@40.7602439802915] != NSOrderedSame || [location.lng compare:@-73.9837820197085] != NSOrderedSame )
            return false;
        
        location = geometry.viewport.southwest;
        if([location.lat compare:@40.7575460197085] != NSOrderedSame || [location.lng compare:@-73.98647998029151] != NSOrderedSame )
            return false;
        string = testResult.types[0];
        if([string compare:@"point_of_interest"] != NSOrderedSame)
            return false;
        string = testResult.types[1];
        if([string compare:@"establishment"] != NSOrderedSame)
            return false;
        
        //
        // test second result
        //
        testResult = result[1];
        // test first address component
        addressComponent = testResult.addressComponents[0];
        if([addressComponent.longName compare:@"Times Square"] != NSOrderedSame)
            return false;
        if([addressComponent.shortName compare:@"Times Square"] != NSOrderedSame)
            return false;
        string = addressComponent.types[0];
        if([string compare:@"subway_station"] != NSOrderedSame)
            return false;
        string = addressComponent.types[1];
        if([string compare:@"transit_station"] != NSOrderedSame)
            return false;
        string = addressComponent.types[2];
        if([string compare:@"train_station"] != NSOrderedSame)
            return false;
        string = addressComponent.types[3];
        if([string compare:@"establishment"] != NSOrderedSame)
            return false;
        
        
        // test last address component
        addressComponent = testResult.addressComponents[4];
        if([addressComponent.longName compare:@"215123"] != NSOrderedSame)
            return false;
        if([addressComponent.shortName compare:@"215123"] != NSOrderedSame)
            return false;
        string = addressComponent.types[0];
        if([string compare:@"postal_code"] != NSOrderedSame)
            return false;
   
        
        if ([testResult.formattedAddress compare:@"Times Square, Wuzhong, Suzhou, China, 215123"] != NSOrderedSame)
            return false;
        
        geometry = testResult.geometry;
        location = geometry.location;
        if([location.lat compare:@31.322484] != NSOrderedSame || [location.lng compare:@120.713015] != NSOrderedSame )
            return false;
        if([geometry.locationType compare:@"APPROXIMATE"] != NSOrderedSame)
            return false;
        
        location = geometry.viewport.northeast;
        if([location.lat compare:@31.3238329802915] != NSOrderedSame || [location.lng compare:@120.7143639802915] != NSOrderedSame )
            return false;
        
        location = geometry.viewport.southwest;
        
        if([location.lat compare:@31.3211350197085] != NSOrderedSame || [location.lng compare:@120.7116660197085] != NSOrderedSame )
            return false;
        
        string = testResult.types[0];
        if([string compare:@"subway_station"] != NSOrderedSame)
            return false;
        string = testResult.types[1];
        if([string compare:@"transit_station"] != NSOrderedSame)
            return false;
        string = testResult.types[2];
        if([string compare:@"train_station"] != NSOrderedSame)
            return false;
        string = testResult.types[3];
        if([string compare:@"establishment"] != NSOrderedSame)
            return false;
        
        
        //
        // test third result
        //
        testResult = result[2];
        // test first address component
        addressComponent = testResult.addressComponents[0];
        if([addressComponent.longName compare:@"Theater District - Times Square"] != NSOrderedSame)
            return false;
        if([addressComponent.shortName compare:@"Theater District - Times Square"] != NSOrderedSame)
            return false;
        string = addressComponent.types[0];
        if([string compare:@"neighborhood"] != NSOrderedSame)
            return false;
        string = addressComponent.types[1];
        if([string compare:@"political"] != NSOrderedSame)
            return false;
        
        
        // test last address component
        addressComponent = testResult.addressComponents[5];
        if([addressComponent.longName compare:@"United States"] != NSOrderedSame)
            return false;
        if([addressComponent.shortName compare:@"US"] != NSOrderedSame)
            return false;
        string = addressComponent.types[0];
        if([string compare:@"country"] != NSOrderedSame)
            return false;
        string = addressComponent.types[1];
        if([string compare:@"political"] != NSOrderedSame)
            return false;
        
        if ([testResult.formattedAddress compare:@"Theater District - Times Square, New York, NY, USA"] != NSOrderedSame)
            return false;
        
        geometry = testResult.geometry;
//        location = geometry.bounds.northeast;
//        if([location.lat compare:@40.7641791] != NSOrderedSame || [location.lng compare:@-73.97907789999999] != NSOrderedSame )
//            return false;
//        location = geometry.bounds.southwest;
//        if([location.lat compare:@40.75373] != NSOrderedSame || [location.lng compare:@-73.9908822] != NSOrderedSame )
//            return false;
        
        location = geometry.location;
        if([location.lat compare:@40.759011] != NSOrderedSame || [location.lng compare:@-73.9844722] != NSOrderedSame )
            return false;
        if([geometry.locationType compare:@"APPROXIMATE"] != NSOrderedSame)
            return false;
        
        location = geometry.viewport.northeast;
        if([location.lat compare:@40.7641791] != NSOrderedSame || [location.lng compare:@-73.97907789999999] != NSOrderedSame )
            return false;
        
        location = geometry.viewport.southwest;
        
        if([location.lat compare:@40.75373] != NSOrderedSame || [location.lng compare:@-73.9908822] != NSOrderedSame )
            return false;
        
        string = testResult.types[0];
        if([string compare:@"neighborhood"] != NSOrderedSame)
            return false;
        string = testResult.types[1];
        if([string compare:@"political"] != NSOrderedSame)
            return false;
        
        
        
        return true;
    }]];
    
    XCTAssertTrue([mappingTest evaluate], @"The status has not been set up!");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"ggc_file1.json"];
        RKMappingTest *mappingTest = [RKMappingTest testForMapping:[RKLIBGGCMappingHelper responseMapping] sourceObject:json destinationObject:nil];
    
    }];
}

@end
