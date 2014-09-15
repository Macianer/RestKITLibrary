//
//  RKLIBViewController.m
//  RestKITLibrary
//
//  Created by ronnymeissner on 08/14/2014.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import "RKLIBViewController.h"

#import <RestKITLibrary/RKLIBGGCMapper.h>
#import <RestKITLibrary/RKLIBGPMapper.h>

#import <RestKITLibrary/RKLIBDef.h>
#import <RestKITLibrary/RKLIBGGC.h>
#import <RestKITLibrary/RKLIBGP.h>
#import "RKLIBKeys.h"

// Create typedef for block
double (^multiplyTwoValues)(double, double);

@interface RKLIBViewController ()

@end

@implementation RKLIBViewController



- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	_dataStructure = [[NSMutableArray alloc] init];

	NSDictionary *dateSet1 = @{ kLongTitleKey : kGGCTitleKey, kURLKey: kGGCAPIUrl, kObjectManager: [self GGCObjectManager] };

	NSDictionary *dateSet2 = @{ kLongTitleKey : kGPTitleKey, kURLKey: kGPAPIUrl, kObjectManager: [self GPObjectManager] };

	NSMutableArray *googleArray = [[NSMutableArray alloc] init];

	[googleArray addObject:dateSet1];
	[googleArray addObject:dateSet2];

	[self.dataStructure addObject:googleArray];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (RKObjectManager *)GGCObjectManager {
	RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:[AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kGGCAPIUrl]]];

	[objectManager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];


	RKResponseDescriptor *res = [RKResponseDescriptor responseDescriptorWithMapping:[RKLIBGGCMappingHelper responseMapping] method:RKRequestMethodGET pathPattern:kJson keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:RKStatusCodeClassSuccessful]];
	[objectManager addResponseDescriptor:res];
	return objectManager;
}

- (RKObjectManager *)GPObjectManager {
	RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:[AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kGPAPIUrl]]];

	[objectManager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];


	RKResponseDescriptor *res = [RKResponseDescriptor responseDescriptorWithMapping:[RKLIBGPMappingHelper responseMapping] method:RKRequestMethodGET pathPattern:kJson keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:RKStatusCodeClassSuccessful]];
	[objectManager addResponseDescriptor:res];
	return objectManager;
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

	cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];

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
	NSArray *array = _dataStructure[indexPath.section];
	id object = array[indexPath.row];
	NSDictionary *dict = object;
	NSString *kind = [dict objectForKey:kLongTitleKey];
	RKObjectManager *objectManager = [dict objectForKey:kObjectManager];
	UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
	RKLIBTableViewController *tvc = [s instantiateViewControllerWithIdentifier:NSStringFromClass([RKLIBTableViewController class])];
	// cancel all pending requests
	[[RKObjectManager sharedManager] cancelAllObjectRequestOperationsWithMethod:RKRequestMethodGET matchingPathPattern:kJson];

	[tvc.activityIndicatorView startAnimating];

	if ([object isKindOfClass:[NSDictionary class]]) {
		if ([kind compare:kGGCTitleKey] == NSOrderedSame) {
			NSDictionary *dict = @{ kAddress : @"time square",
				                    kSensor : kTrue };




			[objectManager getObjectsAtPath:kJson
			                     parameters:dict success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
			    if ([mappingResult.firstObject isKindOfClass:[RKLIBGGCResponse class]]) {
			        RKLIBGGCResponse *response = mappingResult.firstObject;

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
				}

			    //
			} failure: ^(RKObjectRequestOperation *operation, NSError *error) {
			    [tvc.activityIndicatorView stopAnimating];
			}];

			[self.navigationController pushViewController:tvc animated:YES];
		}
		else if ([kind compare:kGPTitleKey] == NSOrderedSame) {
            
            // setup dictionary
            NSDictionary *dict = @{ kInput : @"time square",
                                    kLanguage: @"us",
                                    @"key": kGPAPIKey};

            // start request
            [objectManager getObjectsAtPath:kJson
                                 parameters:dict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                     if ([mappingResult.firstObject isKindOfClass:[RKLIBGPResponse class]])
                                     {
                                         RKLIBGPResponse *response = mappingResult.firstObject;
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
                                     }
                                     [tvc.activityIndicatorView stopAnimating];
                                     //
                                 } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                     [tvc.activityIndicatorView stopAnimating];
                                 }];
                                     [self.navigationController pushViewController:tvc animated:YES];


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
	return @"";
}



@end
