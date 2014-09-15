//
//  RKLIBGGCMappingTest.m
//  RestKITLibrary
//
//  Created by Ronny Meissner on 18/08/14.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RestKit/Testing.h>
#import <RestKITLibrary/RKLIBGGC.h>

@interface RKLIBGGCMappingTest : XCTestCase

@end

@implementation RKLIBGGCMappingTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    NSBundle *testBundle = [NSBundle mainBundle];
    testBundle = [NSBundle bundleForClass:[self class]];
  
   [RKTestFixture setFixtureBundle:testBundle];

}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(RKLIBGGCResult *) testObject1
{
    RKLIBGGCResult *object = [RKLIBGGCResult new];
    
    return object;
}

- (void)mappingTest1
{
    id json = [RKTestFixture parsedObjectWithContentsOfFixture:@"ggc_file1.json"];
    
    RKMappingTest *mappingTest = [RKMappingTest testForMapping:[RKLIBGGCMappingHelper resultMapping] sourceObject:json destinationObject:nil];
    
    [mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"status" destinationKeyPath:@"status"]];
    XCTAssertTrue([mappingTest evaluate], @"The status has not been set up!");
}

@end
