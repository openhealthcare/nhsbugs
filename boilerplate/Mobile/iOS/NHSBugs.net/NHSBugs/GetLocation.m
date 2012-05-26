//
//  GetLocation.m
//  NHSBugs
//
//  Created by Colin Wren on 26/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GetLocation.h"
#import "ViewController.h"

@implementation GetLocation
@synthesize menu;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    
    
    /*
     
     Need to handle error getting location, add code to change icon to a tick and more usable long and lat sending.
     
     - on pressing manual entry it should take user to search box and the search box uses various fields.
     
     
     */
    
    
    
    
    
    
}

-(IBAction)manual:(id)sender{
    [menu manualEntry:nil];
    
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    int degrees = newLocation.coordinate.latitude;
    double decimal = fabs(newLocation.coordinate.latitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal * 3600 - minutes * 60;
    NSString *lat = [NSString stringWithFormat:@"%d° %d' %1.4f\"", 
                     degrees, minutes, seconds];
    menu.autoLatitude = lat;
   // NSLog(@"Latitiude: %@",lat);
    degrees = newLocation.coordinate.longitude;
    decimal = fabs(newLocation.coordinate.longitude - degrees);
    minutes = decimal * 60;
    seconds = decimal * 3600 - minutes * 60;
    NSString *longt = [NSString stringWithFormat:@"%d° %d' %1.4f\"", 
                       degrees, minutes, seconds];
    menu.autoLongitude= longt;
    //NSLog(@"Longitude: %@",longt);
    [locationManager stopUpdatingLocation];
    UIImage *image = [UIImage imageNamed: @"location_found.png"];
    [logo setImage:image];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:menu
                                   selector:@selector(autoLocated:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [locationManager stopUpdatingLocation];
    UIImage *image = [UIImage imageNamed: @"location_notfound.png"];
    [logo setImage:image];
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:menu
                                   selector:@selector(manualEntry:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
