//
//  PlacePhotosTableViewController.m
//  TopPlaces
//
//  Created by Melkamu A on 9/7/14.
//  Copyright (c) 2014 melkam. All rights reserved.
//

#import "PlacePhotosTableViewController.h"
#import "FlickrFetcherHelper.h"

@interface PlacePhotosTableViewController ()

@end

@implementation PlacePhotosTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)fetchPhotos
{
    [self.refreshControl beginRefreshing];
    [FlickrFetcherHelper fetchPhotosForPlace:self.place onComplete:^(NSArray *photos, NSError *error) {
        if (!error) {
            [self.refreshControl endRefreshing];
            self.photos = photos;
        } else {
            NSLog(@"Error fetching Photos: %@", error);
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchPhotos];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
