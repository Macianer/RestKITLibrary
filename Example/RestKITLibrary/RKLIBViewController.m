//
//  RKLIBViewController.m
//  RestKITLibrary
//
//  Created by ronnymeissner on 08/14/2014.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import "RKLIBViewController.h"
#import "RKLIBGGCSelectionViewController.h"
#import "RKLIBViewDefs.h"

@interface RKLIBViewController ()
@property (nonatomic, strong) NSArray *dataSets;
@end

@implementation RKLIBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    NSDictionary *dateSet1 = @{ kTitleKey : @"GoogleGeocodingAPI", kLongTitleKey: @"GoogleGeocodingAPI" };
    
    _dataSets = @[dateSet1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSets.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    
    NSDictionary *dict = [_dataSets objectAtIndex:indexPath.row];
    if(dict){
        cell.textLabel.text = [dict objectForKey:kTitleKey];
        cell.detailTextLabel.text = [dict objectForKey:kLongTitleKey];
    }
    return cell;
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [_dataSets objectAtIndex:indexPath.row];
    NSString *kind = [dict objectForKey:kTitleKey];
    
    if([kind compare:@"GoogleGeocodingAPI"] == NSOrderedSame){
        UIStoryboard *s = [UIStoryboard storyboardWithName:@"RKLIBGGCViewController" bundle:[NSBundle mainBundle]];
        RKLIBGGCSelectionViewController *vc = [s instantiateViewControllerWithIdentifier:@"GGCSelectionViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
@end
