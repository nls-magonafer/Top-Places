//
//  PlacesTaableViewController.m
//  TopPlaces
//
//  Created by Melkamu A on 9/7/14.
//  Copyright (c) 2014 melkam. All rights reserved.
//

#import "PlacesTableViewController.h"
#import "FlickrFetcherHelper.h"
#import "PlacePhotosTableViewController.h"

@interface PlacesTableViewController ()
@property (nonatomic, strong) NSDictionary *placesByCountries;
@property (nonatomic, strong) NSArray *countries;
@end

@implementation PlacesTableViewController

- (void)setPlaces:(NSArray *)places
{
    _places = places;
    self.placesByCountries = [FlickrFetcherHelper placesByCountries:places];
    self.countries = [FlickrFetcherHelper countries:self.placesByCountries];
    [self.tableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.countries.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.placesByCountries[self.countries[section]] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.countries[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell of Place";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *place = self.placesByCountries[self.countries[indexPath.section]] [indexPath.row];
    cell.textLabel.text = [FlickrFetcherHelper cityOfPlace:place];
    cell.detailTextLabel.text = [FlickrFetcherHelper stateOfPlace:place];
    
    return cell;
}

- (void)preparePhotosTableViewController:(PlacePhotosTableViewController *)tvc forPlace:(NSDictionary *) place
{
    tvc.place = place;
    tvc.title = [FlickrFetcherHelper cityOfPlace:place];
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Photos"]) {
                if ([segue.destinationViewController isKindOfClass:[PlacePhotosTableViewController class]]) {
                    [self preparePhotosTableViewController:[segue destinationViewController] forPlace:self.placesByCountries[self.countries[indexPath.section]] [indexPath.row]];
                }
            }
        }
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
