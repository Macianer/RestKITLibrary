//
//  RKLIBRMAPIManagerTests.m
//  RestKITLibrary
//
//  Created by Ronny Meißner on 14/11/14.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <RestKITLibrary/RKLIBRMMappingHelper.h>

@interface RKLIBRMAPIManagerTests : XCTestCase

@end

@implementation RKLIBRMAPIManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testManagerConfigure
{
    RKLIBRMAPIManager * manager = [RKLIBRMAPIManager sharedManager];
    
    XCTAssertThrows([manager configureWithUrl:nil withUser:nil withPassword:nil]);
    
    XCTAssertNoThrow([manager configureWithUrl:@"http://foobar.de" withUser:@"foo" withPassword:@"bar"]);
    
    XCTAssertThrows([manager configureWithUrl:nil withUser:@"foo" withPassword:@"bar"]);
    
    XCTAssertThrows([manager configureWithUrl:@"http://foobar.de" withUser:nil withPassword:@"bar"]);
    
    XCTAssertThrows([manager configureWithUrl:@"http://foobar.de" withUser:@"foo" withPassword:nil]);
    
    XCTAssertThrows([manager configureWithUrl:@"" withUser:@"foo" withPassword:@"bar"]);
    
    XCTAssertThrows([manager configureWithUrl:@"http://foobar.de" withUser:@"" withPassword:@"bar"]);
    
    XCTAssertThrows([manager configureWithUrl:@"http://foobar.de" withUser:@"foo" withPassword:@""]);
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
