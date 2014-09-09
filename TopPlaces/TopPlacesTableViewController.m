//
//  TopPlacesTableViewController.m
//  TopPlaces
//
//  Created by Melkamu A on 9/7/14.
//  Copyright (c) 2014 melkam. All rights reserved.
//

#import "TopPlacesTableViewController.h"
#import "FlickrFetcherHelper.h"

@interface TopPlacesTableViewController ()
@end

@implementation TopPlacesTableViewController


- (IBAction)fetchFlickrTopPlaces
{
    [FlickrFetcherHelper fetchTopPlaces:^(NSArray *places, NSError *error) {
        if (!error) {
            self.places = places;
        } else {
            NSLog(@"Error loading places: %@", error);
        }
    }];
}


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
    [self fetchFlickrTopPlaces];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
