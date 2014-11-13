//
//  RKLIBViewController.h
//  RestKITLibrary
//
//  Created by ronnymeissner on 08/14/2014.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKLIBTableViewController.h"

//
// Please build your personal RKLIBKeys.h  files
// static NSString * const kGPAPIKey = @"api key";
//
#if __has_include("RKLIBKeys.h")
#import "RKLIBKeys.h"
#define HAS_KEYFILE
#endif

@interface RKLIBViewController : UIViewController <UITableViewDataSource,  UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataStructure;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
