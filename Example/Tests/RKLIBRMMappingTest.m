//
//  RKLIBRMMappingTest.m
//  RestKITLibrary
//
//  Created by Ronny Meissner on 18/10/14.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <RestKITLibrary/RKLIBRMMappingHelper.h>
#import <RestKit/Testing.h> 
@interface RKLIBRMMappingTest : XCTestCase

@end

@implementation RKLIBRMMappingTest

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

- (void)testMappingPathForProjectFile1 {
    
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"rm_projects1.json"];
    
    RKMappingTest *mappingTest = [RKMappingTest testForMapping:[RKLIBRMMappingHelper projectsMapping] sourceObject:json destinationObject:nil];
    
    [mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"projects" destinationKeyPath:@"projects"]];
    
    XCTAssertTrue([mappingTest evaluate], @"The projects has not been set up!");
    
    [mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"limit" destinationKeyPath:@"limit"]];
    
    XCTAssertTrue([mappingTest evaluate], @"The limit has not been set up!");
}

- (void)testMappingPathForIssuesFile1 {
    
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"rm_issues_file_1_20141007.json"];
    RKLIBRMIssues *issues = [RKLIBRMIssues new];
    
    RKMappingTest *mappingTest = [RKMappingTest testForMapping:[RKLIBRMMappingHelper issuesMapping] sourceObject:json destinationObject:issues];
    
        [mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"issues" destinationKeyPath:@"issues"]];
    
        XCTAssertTrue([mappingTest evaluate], @"The issues has not been set up!");
    
    [mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"limit" destinationKeyPath:@"limit"]];
    
    XCTAssertTrue([mappingTest evaluate], @"The limit has not been set up!");
    
    [mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"offset" destinationKeyPath:@"offset"]];
    
    XCTAssertTrue([mappingTest evaluate], @"The offset has not been set up!");
}


- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
