//
//  RKLIBGGCViewController.h
//  RestKITLibrary
//
//  Created by Ronny Meissner on 14/08/14.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RKLIBGGCResult;

@interface RKLIBGGCDetailViewController : UIViewController<UITableViewDataSource,  UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) RKLIBGGCResult *result;

@end
