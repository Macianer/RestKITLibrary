//
//  RKLIBGGCViewController.m
//  RestKITLibrary
//
//  Created by Ronny Meissner on 14/08/14.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import "RKLIBTableViewController.h"
#import <RestKit/RestKit.h>
#import <RestKITLibrary/RKLIBGGC.h>
#import "RKLIBTableViewCellMain.h"

@implementation RKLIBTableViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
    self.failedMessageView.hidden = YES;
	self.dataStructure = [[NSMutableArray alloc] init];

    // register main table view
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([RKLIBTableViewCellMain class]) bundle:[NSBundle mainBundle]];
    // 
	[self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([RKLIBTableViewCellMain class])];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

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

    // get object
	NSArray *array = _dataStructure[indexPath.section];
    id object = array[indexPath.row];

    // handle NSString objects
	if ([object isKindOfClass:[NSString class]])
		cell.textLabel.text = object;
    
    // handle NSString objects
    if ([object isKindOfClass:[NSAttributedString class]])
        cell.textLabel.attributedText = object;
	
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
	NSArray *array = _dataStructure[section];
	id object = array[0];

	if ([object isKindOfClass:[NSString class]])
		return object;
    
	return @"";
}

-(void) setFailedMessageViewVisible:(BOOL)visible {
    [_failedMessageView setHidden:!visible];
}
@end
