//
//  RKLIBGGCSelectionViewController.h
//  RestKITLibrary
//
//  Created by Ronny Meissner on 16/08/14.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKLIBGGCSelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *googlePlaces;
@end
