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
    if(_result.addressComponents)
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
            return _result.addressComponents.count;
    }
    else
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if(indexPath.section != _section_adressComponents)
   cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    
    if (indexPath.section  == _section_formattedAddress) {
        
        cell.textLabel.text = _result.formattedAddress;
    }
    else if(indexPath.section == _section_adressComponents)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ComponentsCell" forIndexPath:indexPath];
        RKLIBGGCAdressComponent *component = [_result.addressComponents objectAtIndex:indexPath.row];
        cell.textLabel.text = component.shortName;
        cell.detailTextLabel.text = component.longName;
        UILabel *l3 = (UILabel *)[cell.contentView viewWithTag:2001];
        l3.text = [self stringFromStringArray:component.types];
    }
    else if(indexPath.section == _section_types)
    {

        cell.textLabel.text =[self stringFromStringArray:_result.types];
    }
    else if (indexPath.section == _section_geometry)
    {
        cell.textLabel.text = _result.geometry.locationType;
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == _section_adressComponents)
    {
        return 80.0f;
    }
    return 45.0f;
}
-(NSString *) stringFromStringArray: (NSArray *) array
{
    NSMutableString *mString = [NSMutableString stringWithFormat:@""];
    for (NSString *type in _result.types) {
        
        [mString appendFormat:@"%@,",type];
    }
    return [mString substringWithRange:NSMakeRange(0, mString.length -1)];
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
