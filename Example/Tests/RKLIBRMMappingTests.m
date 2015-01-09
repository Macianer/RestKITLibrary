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

@interface RKLIBRMMappingTests : XCTestCase

@end

@implementation RKLIBRMMappingTests

- (void)setUp {
    
  [super setUp];
  // Put setup code here. This method is called before the invocation of each
  // test method in the class.
  NSBundle *testBundle = [NSBundle mainBundle];
  testBundle = [NSBundle bundleForClass:[self class]];


	[RKTestFixture setFixtureBundle:testBundle];
}

- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of exach
	// test method in the class.
	[super tearDown];
}

- (void)testMappingPathForProjectFile1 {
	id json =
	    [RKTestFixture parsedObjectWithContentsOfFixture:@"rm_projects1.json"];

	RKMappingTest *mappingTest =
	    [RKMappingTest testForMapping:[RKLIBRMMappingHelper projectsMapping]
	                     sourceObject:json
	                destinationObject:nil];

	[mappingTest addExpectation:[RKPropertyMappingTestExpectation
	                             expectationWithSourceKeyPath:@"projects"
	                                       destinationKeyPath:@"projects"]];

	XCTAssertTrue([mappingTest evaluate], @"The projects has not been set up!");

	[mappingTest addExpectation:[RKPropertyMappingTestExpectation
	                             expectationWithSourceKeyPath:@"limit"
	                                       destinationKeyPath:@"limit"]];

	XCTAssertTrue([mappingTest evaluate], @"The limit has not been set up!");
	[mappingTest addExpectation:[RKPropertyMappingTestExpectation
	                             expectationWithSourceKeyPath:@"offset"
	                                       destinationKeyPath:@"offset"]];

	XCTAssertTrue([mappingTest evaluate], @"The offset has not been set up!");

	[mappingTest addExpectation:[RKPropertyMappingTestExpectation
	                             expectationWithSourceKeyPath:@"total_count"
	                                       destinationKeyPath:@"totalCount"]];

	XCTAssertTrue([mappingTest evaluate], @"The totalCount has not been set up!");
}

- (void)testMappingValuesForProjectFile1 {
	id json =
	    [RKTestFixture parsedObjectWithContentsOfFixture:@"rm_projects1.json"];

	RKMappingTest *mappingTest =
	    [RKMappingTest testForMapping:[RKLIBRMMappingHelper projectsMapping]
	                     sourceObject:json
	                destinationObject:nil];

	[mappingTest
   addExpectation:
	 [RKPropertyMappingTestExpectation
	       expectationWithSourceKeyPath:@"projects"
	                 destinationKeyPath:@"projects"
	                    evaluationBlock:
	^BOOL (RKPropertyMappingTestExpectation *
	       expectation,
	       RKPropertyMapping *mapping, id mappedValue,
	       NSError *__autoreleasing *error) {
	        if (![mappedValue
	              isKindOfClass:[NSArray class]])
				return false;
	        NSArray * projects = mappedValue;
	        if (projects.count != 25)
				return false;
	        NSDateFormatter * dateFormat =
	            [[NSDateFormatter alloc] init];
	        [dateFormat setDateFormat:
	         @"yyyy-MM-dd'T'HH:mm:ss'Z'"];
	        [dateFormat
	                                setTimeZone:[NSTimeZone timeZoneWithName:
	                                             @"UTC"]];
	        RKLIBRMProject *project = projects[0];
	        if (!project)
				return false;
	        if ([project.projectId compare:@57538] !=
	            NSOrderedSame)
				return false;
	        if ([project.name compare:@"0000"] !=
	            NSOrderedSame)
				return false;
	        if ([project.identifier compare:@"hola"] !=
	            NSOrderedSame)
				return false;
	        if ([project.descriptionString
	             compare:@"00"] != NSOrderedSame)
				return false;
	        if ([project.status compare:@1] !=
	            NSOrderedSame)
				return false;
	        NSDate * date = [dateFormat
	                         dateFromString:@"2014-10-15T08:13:09Z"];
	        if ([project.createdOn compare:date] !=
	            NSOrderedSame)
				return false;
	        if ([project.updateOn compare:date] !=
	            NSOrderedSame)
				return false;

	        project = projects[1];
	        if (!project)
				return false;
	        if ([project.projectId compare:@57793] !=
	            NSOrderedSame)
				return false;
	        if ([project.name compare:@"0000000"] !=
	            NSOrderedSame)
				return false;
	        if ([project.identifier
	             compare:@"qwqwqwqqwqwqwqw"] !=
	            NSOrderedSame)
				return false;
	        if ([project.descriptionString
	             compare:@""] != NSOrderedSame)
				return false;
	        if ([project.status compare:@1] !=
	            NSOrderedSame)
				return false;
	        date = [dateFormat
	                dateFromString:@"2014-10-17T19:35:54Z"];
	        if ([project.createdOn compare:date] !=
	            NSOrderedSame)
				return false;
	        if ([project.updateOn compare:date] !=
	            NSOrderedSame)
				return false;
	        project = projects[24];
	        if (!project)
				return false;
	        if ([project.projectId compare:@57734] !=
	            NSOrderedSame)
				return false;
	        if ([project.name compare:@"AF2 Project"] !=
	            NSOrderedSame)
				return false;
	        if ([project.identifier
	             compare:@"af2-project"] !=
	            NSOrderedSame)
				return false;
	        if ([project.descriptionString
	             compare:@""] != NSOrderedSame)
				return false;
	        if ([project.status compare:@1] !=
	            NSOrderedSame)
				return false;
	        date = [dateFormat
	                dateFromString:@"2014-10-16T22:35:46Z"];
	        if ([project.createdOn compare:date] !=
	            NSOrderedSame)
				return false;
	        if ([project.updateOn compare:date] !=
	            NSOrderedSame)
				return false;

	        return true;
		}]];

	XCTAssertTrue([mappingTest evaluate], @"The projects has not been set up!");

	[mappingTest addExpectation:[RKPropertyMappingTestExpectation
	                             expectationWithSourceKeyPath:@"limit"
	                                       destinationKeyPath:@"limit"
	                                                    value:@25]];

	XCTAssertTrue([mappingTest evaluate], @"The limit has not been set up!");

	[mappingTest addExpectation:[RKPropertyMappingTestExpectation
	                             expectationWithSourceKeyPath:@"offset"
	                                       destinationKeyPath:@"offset"
	                                                    value:@0]];

	XCTAssertTrue([mappingTest evaluate], @"The offset has not been set up!");

	[mappingTest addExpectation:[RKPropertyMappingTestExpectation
	                             expectationWithSourceKeyPath:@"total_count"
	                                       destinationKeyPath:@"totalCount"
	                                                    value:@525]];

	XCTAssertTrue([mappingTest evaluate], @"The totalCount has not been set up!");
}

- (void)testMappingPathForIssuesFile1 {
	id json = [RKTestFixture
	           parsedObjectWithContentsOfFixture:@"rm_issues_file_1_20141007.json"];
	RKLIBRMIssues *issues = [RKLIBRMIssues new];

	RKMappingTest *mappingTest =
	    [RKMappingTest testForMapping:[RKLIBRMMappingHelper issuesMapping]
	                     sourceObject:json
	                destinationObject:issues];

	[mappingTest addExpectation:[RKPropertyMappingTestExpectation
	                             expectationWithSourceKeyPath:@"issues"
	                                       destinationKeyPath:@"issues"]];

	XCTAssertTrue([mappingTest evaluate], @"The issues has not been set up!");

	[mappingTest addExpectation:[RKPropertyMappingTestExpectation
	                             expectationWithSourceKeyPath:@"limit"
	                                       destinationKeyPath:@"limit"]];

	XCTAssertTrue([mappingTest evaluate], @"The limit has not been set up!");

	[mappingTest addExpectation:[RKPropertyMappingTestExpectation
	                             expectationWithSourceKeyPath:@"offset"
	                                       destinationKeyPath:@"offset"]];

	XCTAssertTrue([mappingTest evaluate], @"The offset has not been set up!");

	[mappingTest addExpectation:[RKPropertyMappingTestExpectation
	                             expectationWithSourceKeyPath:@"total_count"
	                                       destinationKeyPath:@"totalCount"]];

	XCTAssertTrue([mappingTest evaluate], @"The totalCount has not been set up!");
}

- (void)testMappingValuesForIssuesFile1 {

  id json = [RKTestFixture
      parsedObjectWithContentsOfFixture:@"rm_issues_file_1_20141007.json"];
  RKLIBRMIssues *issues = [RKLIBRMIssues new];

  RKMappingTest *mappingTest =
      [RKMappingTest testForMapping:[RKLIBRMMappingHelper issuesMapping]
                       sourceObject:json
                  destinationObject:issues];

  [mappingTest addExpectation:[RKPropertyMappingTestExpectation
                                  expectationWithSourceKeyPath:@"issues"
                                            destinationKeyPath:@"issues" evaluationBlock:^BOOL(RKPropertyMappingTestExpectation *expectation, RKPropertyMapping *mapping, id mappedValue, NSError *__autoreleasing *error) {
                                                if (![mappedValue
                                                      isKindOfClass:[NSArray class]])
                                                    return false;
                                                NSArray *issues = mappedValue;
                                                if (issues.count != 25)
                                                    return false;
                                                NSDateFormatter *dateFormat =
                                                [[NSDateFormatter alloc] init];
                                                [dateFormat setDateFormat:
                                                 @"yyyy-MM-dd'T'HH:mm:ss'Z'"];
                                                NSDateFormatter *dateFormat2 =
                                                [[NSDateFormatter alloc] init];
                                                [dateFormat setDateFormat:
                                                 @"yyyy-MM-dd"];
                                                [dateFormat
                                                 setTimeZone:[NSTimeZone timeZoneWithName:
                                                              @"UTC"]];
                                                
                                                /*!
                                                 *  test first issue
                                                 */
                                                RKLIBRMIssue *issue = issues[0];
                                                
                                                if (!issue)
                                                    return false;
                                                if ([issue.issueId compare:@65628] !=
                                                    NSOrderedSame)
                                                    return false;
                                                if ([issue.project.projectId compare:@56787] !=
                                                    NSOrderedSame)
                                                    return false;
                                                if ([issue.project.name compare:@"Hotel Neu"] !=
                                                    NSOrderedSame)
                                                    return false;
                                                if ([issue.tracker.trackerId compare:@1] != NSOrderedSame)
                                                    return false;
                                                if ([issue.tracker.name compare:@"Bug"] !=
                                                    NSOrderedSame)
                                                    return false;
                                                if ([issue.status.statusId compare:@1] != NSOrderedSame)
                                                    return false;
                                                if ([issue.status.name compare:@"New"] !=
                                                    NSOrderedSame)
                                                    return false;
                                                if ([issue.priority.priorityId compare:@4] != NSOrderedSame)
                                                    return false;
                                                if ([issue.priority.name compare:@"Normal"] !=
                                                    NSOrderedSame)
                                                    return false;
                                                
                                                if ([issue.author.authorId compare:@76718] != NSOrderedSame)
                                                    return false;
                                                if ([issue.author.name compare:@"Claudia Biederer"] !=
                                                    NSOrderedSame)
                                                    return false;
                                                NSDate *date = [dateFormat
                                                                dateFromString:@"2014-10-07T16:45:08Z"];
                                                if ([issue.subject compare:@"Probleme kein telefon"] != NSOrderedSame)
                                                    return false;
                                                if ([issue.descriptionString compare:@"Probleme kein telefon"] != NSOrderedSame)
                                                    return false;
                                                if ([issue.startDate compare:[dateFormat2 dateFromString:@"2014-10-07"]] != NSOrderedSame)
                                                    return false;
                                                if ([issue.doneRatio compare:@0] != NSOrderedSame)
                                                    return false;
                                                if ([issue.estimatedHours compare:@1.0] != NSOrderedSame)
                                                    return false;
                                                if ([issue.createdOn compare:date] !=
                                                    NSOrderedSame)
                                                    return false;
                                                if ([issue.updateOn compare:date] !=
                                                    NSOrderedSame)
                                                    return false;
                                                
                                                
                                                /*!
                                                 *  test last issue
                                                 */
                                               issue = issues[24];
                                                
                                                if (!issue)
                                                    return false;
                                                if ([issue.issueId compare:@65591] !=
                                                    NSOrderedSame)
                                                    return false;
                                                if ([issue.project.projectId compare:@56767] !=
                                                    NSOrderedSame)
                                                    return false;
                                                if ([issue.project.name compare:@"test fred task 1 sub 1"] !=
                                                    NSOrderedSame)
                                                    return false;
                                                if ([issue.tracker.trackerId compare:@1] != NSOrderedSame)
                                                    return false;
                                                if ([issue.tracker.name compare:@"Bug"] !=
                                                    NSOrderedSame)
                                                    return false;
                                                if ([issue.status.statusId compare:@1] != NSOrderedSame)
                                                    return false;
                                                if ([issue.status.name compare:@"New"] !=
                                                    NSOrderedSame)
                                                    return false;
                                                if ([issue.priority.priorityId compare:@4] != NSOrderedSame)
                                                    return false;
                                                if ([issue.priority.name compare:@"Normal"] !=
                                                    NSOrderedSame)
                                                    return false;
                                                
                                                if ([issue.author.authorId compare:@76687] != NSOrderedSame)
                                                    return false;
                                                if ([issue.author.name compare:@"Fred Stoopendaal"] !=
                                                    NSOrderedSame)
                                                    return false;
                                                
                                                if ([issue.assignedTo.authorId compare:@76687] != NSOrderedSame)
                                                    return false;
                                                if ([issue.assignedTo.name compare:@"Fred Stoopendaal"] !=
                                                    NSOrderedSame)
                                                    return false;
                                                date = [dateFormat
                                                                dateFromString:@"2014-10-07T13:45:07Z"];
                                                if ([issue.subject compare:@"issuetje"] != NSOrderedSame)
                                                    return false;
                                                if ([issue.descriptionString compare:@"een issue in sub 1"] != NSOrderedSame)
                                                    return false;
                                                if ([issue.startDate compare:[dateFormat2 dateFromString:@"2014-10-07"]] != NSOrderedSame)
                                                    return false;
                                                if ([issue.doneRatio compare:@0] != NSOrderedSame)
                                                    return false;
                                                if ([issue.estimatedHours compare:@1.0] != NSOrderedSame)
                                                    return false;
                                                if ([issue.createdOn compare:date] !=
                                                    NSOrderedSame)
                                                    return false;
                                                if ([issue.updateOn compare:date] !=
                                                    NSOrderedSame)
                                                    return false;

                                                
                                                return true;

                                            }]];

  XCTAssertTrue([mappingTest evaluate], @"The issues did not match!");

  [mappingTest addExpectation:[RKPropertyMappingTestExpectation
                                  expectationWithSourceKeyPath:@"limit"
                                            destinationKeyPath:@"limit"
                                                         value:@25]];

  XCTAssertTrue([mappingTest evaluate], @"The limit did not match!");

  [mappingTest addExpectation:[RKPropertyMappingTestExpectation
                                  expectationWithSourceKeyPath:@"offset"
                                            destinationKeyPath:@"offset"
                                                         value:@0]];

  XCTAssertTrue([mappingTest evaluate], @"The offset did not match!");

  [mappingTest addExpectation:[RKPropertyMappingTestExpectation
                                  expectationWithSourceKeyPath:@"total_count"
                                            destinationKeyPath:@"totalCount"
                                                         value:@519]];

  XCTAssertTrue([mappingTest evaluate], @"The totalCount did not match!");
    
}

- (void)testPerformanceExample {

	[self measureBlock: ^{
	    id json = [RKTestFixture
	               parsedObjectWithContentsOfFixture:@"rm_issues_file_1_20141007.json"];
	    RKLIBRMIssues *issues = [RKLIBRMIssues new];

	    RKMappingTest *mappingTest =
	        [RKMappingTest testForMapping:[RKLIBRMMappingHelper issuesMapping]
	                         sourceObject:json
	                    destinationObject:issues];
        [mappingTest addExpectation:[RKPropertyMappingTestExpectation expectationWithSourceKeyPath:@"issues" destinationKeyPath:@"issues" evaluationBlock:^BOOL(RKPropertyMappingTestExpectation *expectation, RKPropertyMapping *mapping, id mappedValue, NSError *__autoreleasing *error) {
            NSArray *predictions = mappedValue;
            if (predictions.count != 25) {
                return false;
            }
            return true;
        }]];
        XCTAssertTrue([mappingTest evaluate], @"The issues count is not correct!");
	}];
}

@end
