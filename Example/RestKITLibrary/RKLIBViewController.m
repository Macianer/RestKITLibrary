//
//  RKLIBViewController.m
//  RestKITLibrary
//
//  Created by ronnymeissner on 08/14/2014.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import "RKLIBViewController.h"

#import <RestKITLibrary/RKLIbGGCAPIManager.h>
#import <RestKITLibrary/RKLIBGPAPIManager.h>

#import <RestKITLibrary/RKLIBDef.h>
#import <RestKITLibrary/RKLIBGGC.h>
#import <RestKITLibrary/RKLIBGP.h>

#import "RKLIBTableViewCellMain.h"

//
// Please build your personal RKLIBKeys.h  files
// static NSString * const kGPAPIKey = @"api key";
//
#import "RKLIBKeys.h"

@interface RKLIBViewController ()

@end

@implementation RKLIBViewController



- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // init data structure
	_dataStructure = [[NSMutableArray alloc] init];

    // setup data sets
	NSDictionary *dateSet1 = @{ kLongTitleKey : kGGCTitleKey, kURLKey: kGGCAPIUrl};

	NSDictionary *dateSet2 = @{ kLongTitleKey : kGPTitleKey, kURLKey: kGPAPIUrl };

    // make a google group
	NSMutableArray *googleArray = [[NSMutableArray alloc] init];
	[googleArray addObject:dateSet1];
	[googleArray addObject:dateSet2];

    // add to data structure
	[self.dataStructure addObject:googleArray];
    
    
    UINib *nib = [ UINib nibWithNibName:NSStringFromClass([RKLIBTableViewCellMain class]) bundle:[NSBundle mainBundle] ];
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
	NSArray *array = _dataStructure[indexPath.section];
	id object = array[indexPath.row];
	NSDictionary *dict = object;
	NSString *kind = [dict objectForKey:kLongTitleKey];
	

	RKLIBTableViewController *tvc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([RKLIBTableViewController class])];
    


	[tvc.activityIndicatorView startAnimating];

	if ([object isKindOfClass:[NSDictionary class]]) {
		if ([kind compare:kGGCTitleKey] == NSOrderedSame) {
            
            [[RKLIBGGCAPIManager sharedManager] getByStringAddress:@"time square" components:nil bounds:nil key:nil language:nil region:nil success:^(RKObjectRequestOperation *operation, RKLIBGGCResponse *response) {
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

            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                 [tvc.activityIndicatorView stopAnimating];
            }];
          

			[self.navigationController pushViewController:tvc animated:YES];
		}
		else if ([kind compare:kGPTitleKey] == NSOrderedSame) {
            
            // setup dictionary
          
            [[RKLIBGPAPIManager sharedMapper] getInput:@"time square" key:kGPAPIKey offset:0 location:nil radius:0 language:@"us" types:nil components:nil success:^(RKObjectRequestOperation *operation, RKLIBGPResponse *response) {
        
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
