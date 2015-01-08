//
//  RKLIBGGCViewController.h
//  RestKITLibrary
//
//  Created by Ronny Meissner on 14/08/14.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RKLIBGGCResult;

@interface RKLIBTableViewController : UIViewController <UITableViewDataSource,  UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, strong) NSMutableArray *dataStructure;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *failedMessageView;

-(void) setFailedMessageViewVisible:(BOOL)visible;
@end
