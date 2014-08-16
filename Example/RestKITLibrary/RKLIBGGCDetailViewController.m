//
//  RKLIBGGCViewController.m
//  RestKITLibrary
//
//  Created by Ronny Meissner on 14/08/14.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import "RKLIBGGCDetailViewController.h"
#import <RestKit/RestKit.h>
#import <RestKITLibrary/RKLIBGGC.h>

@interface RKLIBGGCDetailViewController ()
{
        NSUInteger _section_formattedAddress;
        NSUInteger _section_adressComponents;
        NSUInteger _section_types;
        NSUInteger _section_geometry;
        NSUInteger _section_count;
        
        UIImage *mapImage;
    
}
@end

@implementation RKLIBGGCDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateSections
{
    _section_formattedAddress = INT16_MAX;
    _section_adressComponents = INT16_MAX;
    _section_types = INT16_MAX;
    _section_geometry = INT16_MAX;
    
    _section_count = 0;
    
    if(_result.formattedAddress){
        _section_formattedAddress = _section_count;
        _section_count++;}
    if(_result.adressComponents)
    {
        _section_adressComponents = _section_count;
        _section_count++;
    }
    if(_result.types)
    {
        _section_types = _section_count;
        _section_count++;
    }
    if(_result.geometry)
    {
        _section_geometry = _section_count;
        _section_count++;
    }
}
-(void)setResult:(RKLIBGGCResult *)result
{
    _result = result;
    [self updateSections];
    [self.tableView reloadData];
    
}
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _section_count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if( section == _section_adressComponents)
    {
            return _result.adressComponents.count;
    }
    else
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    
    if (indexPath.section  == _section_formattedAddress) {
        cell.textLabel.text = _result.formattedAddress;
    }
    else if(indexPath.section == _section_adressComponents)
    {
        RKLIBGGCAdressComponent *component = [_result.adressComponents objectAtIndex:indexPath.row];
        cell.textLabel.text = component.shortName;
        cell.detailTextLabel.text = component.longName;
    }
    return cell;
}
#pragma mark UITableViewDelegate
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == _section_formattedAddress)
        return @"formattedAddress";
    else if (section == _section_adressComponents)
        return @"adressComponents";
    else if (section == _section_types)
        return @"types";
    else if (section == _section_geometry)
        return @"geometry";
    else
        return @"failure";
}
@end
