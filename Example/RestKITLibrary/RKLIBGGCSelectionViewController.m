//
//  RKLIBGGCSelectionViewController.m
//  RestKITLibrary
//
//  Created by Ronny Meissner on 16/08/14.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

#import "RKLIBGGCSelectionViewController.h"
#import "RKLIBGGCDetailViewController.h"
#import <RestKITLibrary/RKLIBGGC.h>
@interface RKLIBGGCSelectionViewController ()

@end

@implementation RKLIBGGCSelectionViewController

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
    [self setupRestApi];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupRestApi
{
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:[AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kAPI_URL] ]];
    
    [objectManager setAcceptHeaderWithMIMEType:RKMIMETypeJSON];
    
    
    RKResponseDescriptor *res = [RKResponseDescriptor responseDescriptorWithMapping:[RKLIBGGCMappingHelper responseMapping] method:RKRequestMethodGET pathPattern:kAPI_PATTERN_JSON keyPath:nil statusCodes: [NSIndexSet indexSetWithIndex:RKStatusCodeClassSuccessful ]];
    [objectManager addResponseDescriptor:res];
    [RKObjectManager  setSharedManager:objectManager];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self requestWithString:searchText];
}

-(void) requestWithString: (NSString *) requestString
{
    NSDictionary *dict = @{kAPI_ADRESS : requestString,
                           kAPI_SENSOR : kAPI_TRUE};
    
    __weak typeof(self) weakSelf = self;
    
    // cancel all pending requests
    [[RKObjectManager sharedManager] cancelAllObjectRequestOperationsWithMethod:RKRequestMethodGET matchingPathPattern:kAPI_PATTERN_JSON];
    NSLog(@"success");
    [[RKObjectManager sharedManager] getObjectsAtPath:kAPI_PATTERN_JSON parameters:dict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"success");
        RKLIBGGCResponse *response = mappingResult.firstObject;
        weakSelf.googlePlaces = response.result;
        [weakSelf.tableView reloadData];
        //
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        //
        NSLog(@"failed");
    }];
}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.googlePlaces.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"resultCells" forIndexPath:indexPath];
    
    
    RKLIBGGCResult *result = [self.googlePlaces objectAtIndex:indexPath.row];
    cell.textLabel.text = result.formattedAddress;
    
    for (RKLIBGGCAdressComponent *adressComponents in result.adressComponents)
    {
        NSLog(@"adressComponent %@", adressComponents.longName );
    }
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RKLIBGGCDetailViewController *viewController = [segue destinationViewController];
    RKLIBGGCResult *custObject = [_googlePlaces objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    viewController.result = custObject;
}

@end
