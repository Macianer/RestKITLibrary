//
//  RKLIBViewController.m
//  RestKITLibrary
//
//  Created by ronnymeissner on 08/14/2014.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import "RKLIBViewController.h"

#import <RestKITLibrary/RKLIBGGCAPIManager.h>
#import <RestKITLibrary/RKLIBGPAPIManager.h>

#import <RestKITLibrary/RKLIBDef.h>
#import <RestKITLibrary/RKLIBGGC.h>
#import <RestKITLibrary/RKLIBGP.h>
#import <RestKITLibrary/RKLIBRM.h>
#import <RestKITLibrary/RKLIBDeviceHelper.h>
#import <RestKITLibrary/RKLIBTableViewController.h>
#import <RestKITLibrary/RKLIBTableViewCellMain.h>

#import "RKLIBKeys.h"

@interface RKLIBViewController ()

@end

@implementation RKLIBViewController



- (void)viewDidLoad {
    
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	// init data structure
	_dataStructure = [[NSMutableArray alloc] init];

    // make a google group
    NSMutableArray *googleArray = [[NSMutableArray alloc] init];
    
	// setup data sets
	NSDictionary *dateSet1 = @{ kLongTitleKey : kGGCTitleKey, kURLKey: kGGCAPIUrl };
    [googleArray addObject:dateSet1];
    
    // add when keyfile is available
	NSDictionary *dateSet2 = @{ kLongTitleKey : kGPTitleKey, kURLKey: kGPAPIUrl };
    [googleArray addObject:dateSet2];
    
	NSDictionary *dateSet3 = @{ kLongTitleKey : kRMProjectsTitleKey, kURLKey: kRMDemoAPIUrl };
	NSDictionary *dateSet4 = @{ kLongTitleKey : kRMIssuesTitleKey, kURLKey: kRMDemoAPIUrl };
	

	

	// add to data structure
	[self.dataStructure addObject:googleArray];
	NSMutableArray *redmineArray = [[NSMutableArray alloc] init];
	[redmineArray addObject:dateSet3];
	[redmineArray addObject:dateSet4];
    
	// add to data structure
	[self.dataStructure addObject:redmineArray];

    // register main table view cell in tableviewcontroller
	UINib *nib = [UINib nibWithNibName:NSStringFromClass([RKLIBTableViewCellMain class]) bundle:[NSBundle mainBundle]];
	[self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([RKLIBTableViewCellMain class])];
    
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return _dataStructure.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSArray *array = [_dataStructure objectAtIndex:section];
	return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = nil;

	cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RKLIBTableViewCellMain class]) forIndexPath:indexPath];

	NSArray *array = _dataStructure[indexPath.section];
	id object = array[indexPath.row];

	if ([object isKindOfClass:[NSString class]])
		cell.textLabel.text = object;

	if ([object isKindOfClass:[NSDictionary class]]) {
		NSDictionary *dict = object;

		cell.textLabel.text = dict[kLongTitleKey];
		cell.detailTextLabel.text = dict[kURLKey];
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // get selected dictionary
	NSArray *array = _dataStructure[indexPath.section];
	id object = array[indexPath.row];
	NSDictionary *dict = object;
    
    // extract longTitle string
	NSString *kind = [dict objectForKey:kLongTitleKey];

    // load table view controller
	RKLIBTableViewController *tvc = [[RKLIBTableViewController alloc] initWithNibName:NSStringFromClass([RKLIBTableViewController class]) bundle:[NSBundle mainBundle]];
    
    // start activityIndicatorView
	[tvc.activityIndicatorView startAnimating];

    // differ action by long title string
 	if ([object isKindOfClass:[NSDictionary class]]) {
        
        
		if ([kind compare:kGGCTitleKey] == NSOrderedSame) {
			[[RKLIBGGCAPIManager sharedManager] getByStringAddress:@"time square" components:nil bounds:nil key:nil language:[RKLIBDeviceHelper currentlanguageCode] region:nil success: ^(RKObjectRequestOperation *operation, RKLIBGGCResponse *response) {
			    for (RKLIBGGCResult * result in response.results) {
			        NSMutableArray *array = [[NSMutableArray alloc] init];
			        [array addObject:result.formattedAddress];
			        NSMutableString *mString = [[NSMutableString alloc] init];
			        for (NSString * string in result.types) {
			            [mString appendString:string];
			            [mString appendString:@";"];
					}
			        [array addObject:mString];
			        [array addObject:[result.geometry description]];



			        [tvc.dataStructure addObject:array];
				}

			    [tvc.tableView insertSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tvc.dataStructure.count)] withRowAnimation:UITableViewRowAnimationTop];

			    [tvc.activityIndicatorView stopAnimating];
			} failure: ^(RKObjectRequestOperation *operation, NSError *error) {
			    [tvc.activityIndicatorView stopAnimating];
			}];


			[self.navigationController pushViewController:tvc animated:YES];
		}
		else if ([kind compare:kGPTitleKey] == NSOrderedSame ) {
			// setup dictionary

			[[RKLIBGPAPIManager sharedManager] getInput:@"time square" key:kGPAPIKey offset:0 location:CLLocationCoordinate2DMake(0, 0) radius:0 language:[RKLIBDeviceHelper currentlanguageCode] types:nil components:nil success: ^(RKObjectRequestOperation *operation, RKLIBGPResponse *response) {
			    for (RKLIBGPPrediction * predictions in response.predictions) {
			        NSMutableArray *array = [[NSMutableArray alloc] init];
			        [array addObject:predictions.predictionDescription];
			        NSMutableString *mString = [[NSMutableString alloc] init];
			        for (NSString * string in predictions.types) {
			            [mString appendString:string];
			            [mString appendString:@";"];
					}
			        [array addObject:mString];
			        [array addObject:predictions.predictionId];



			        [tvc.dataStructure addObject:array];
				}

			    [tvc.tableView insertSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tvc.dataStructure.count)] withRowAnimation:UITableViewRowAnimationTop];
			    [tvc.activityIndicatorView stopAnimating];
			} failure: ^(RKObjectRequestOperation *operation, NSError *error) {
			    [tvc.activityIndicatorView stopAnimating];
			}];

			[self.navigationController pushViewController:tvc animated:YES];
		}
		else if ([kind compare:kRMProjectsTitleKey] == NSOrderedSame) {
			[[RKLIBRMAPIManager sharedManager] configureWithUrl:kRMDemoAPIUrl withUser:@"foo" withPassword:@"bar"];
			[[RKLIBRMAPIManager sharedManager] getProjectsWithSuccess: ^(RKObjectRequestOperation *operation, RKLIBRMProjects *projects) {
			    for (RKLIBRMProject * project in projects.projects) {
			        NSMutableArray *array = [[NSMutableArray alloc] init];
			        [array addObject:project.identifier];

			        [array addObject:project.projectId];



			        [tvc.dataStructure addObject:array];
				}
			    [tvc.tableView insertSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tvc.dataStructure.count)] withRowAnimation:UITableViewRowAnimationTop];
			    [tvc.activityIndicatorView stopAnimating];
			} failure: ^(RKObjectRequestOperation *operation, NSError *error) {
			    [tvc.activityIndicatorView stopAnimating];
			}];
			UIBarButtonItem *createProject = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createProject)];



			[tvc setToolbarItems:@[createProject]];
			[self.navigationController pushViewController:tvc animated:YES];
			[self.navigationController setToolbarHidden:NO];
		}
		else if ([kind compare:kRMIssuesTitleKey] == NSOrderedSame) {
			[[RKLIBRMAPIManager sharedManager] configureWithUrl:kRMDemoAPIUrl withUser:kRMAPIUser withPassword:kRMAPIPassword];
			[[RKLIBRMAPIManager sharedManager] getIssuesWithSuccess: ^(RKObjectRequestOperation *operation, RKLIBRMIssues *issues) {
			    for (RKLIBRMIssue * issue in issues.issues) {
			        NSMutableArray *array = [[NSMutableArray alloc] init];
			        [array addObject:[NSString stringWithFormat:@"%@", issue.issueId]];
			        [array addObject:issue.descriptionString];
			        [array addObject:issue.subject];


			        [tvc.dataStructure addObject:array];
				}
			    [tvc.tableView insertSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tvc.dataStructure.count)] withRowAnimation:UITableViewRowAnimationTop];
			    [tvc.activityIndicatorView stopAnimating];
			} failure: ^(RKObjectRequestOperation *operation, NSError *error) {
			    [tvc.activityIndicatorView stopAnimating];
			}];
			UIBarButtonItem *createProject = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createProject)];



			[tvc setToolbarItems:@[createProject]];
			[self.navigationController pushViewController:tvc animated:YES];
			[self.navigationController setToolbarHidden:NO];
		}


		else {
			[tvc.activityIndicatorView stopAnimating];
		}
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return @"Google API";
	}
	else if (section == 1) {
		return @"Redmine API";
	}
	return @"";
}

#pragma mark action
- (void)createProject {
	[[RKLIBRMAPIManager sharedManager] postProjectWithName:@"test" withIdentifier:@"test" withDescription:@"test" success: ^(RKObjectRequestOperation *operation, RKLIBRMProject *project) {
	    //
	} failure: ^(RKObjectRequestOperation *operation, NSError *error) {
	    //
	}];
}

@end
