//
//  ViewController.m
//  NHSBugs
//
//  Created by Colin Wren on 26/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "GetLocation.h"
#import "JSONKit.h"

@implementation ViewController
@synthesize nearbyLocations;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    searchtable.hidden = YES;
    searchtable.backgroundColor = [UIColor clearColor];
    searchtable.opaque = NO;
    searchtable.backgroundView = nil;
    nearby.hidden = YES;
    notwhatlooking.hidden = YES;
    manual.hidden = YES;
	// Do any additional setup after loading the view, typically from a nib.
    
    //Load the JSON file containing the hospitals and create array
    NSString *hospitallist = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hospitals" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    hospitalJSON = [hospitallist objectFromJSONString];
    
    namesArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [hospitalJSON count]; i++) {
        [namesArray addObject:[NSString stringWithFormat:[[hospitalJSON valueForKey:@"name"]objectAtIndex:i]]];
    }
    
    
    
    coordsArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [hospitalJSON count]; i++) {
        NSMutableDictionary *coordSet = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[[hospitalJSON valueForKey:@"lat"] objectAtIndex:i]], @"latitude", [NSString stringWithFormat:@"%@",[[hospitalJSON valueForKey:@"lng"] objectAtIndex:i]], @"longitude", [NSString stringWithFormat:@"%@",[[hospitalJSON valueForKey:@"name"] objectAtIndex:i]], @"name", nil];
        [coordsArray addObject:coordSet];
    }
    //Load the location getter
    if(grabLocation == nil){
    grabLocation = [[GetLocation alloc] initWithNibName:@"GetLocation" bundle:[NSBundle mainBundle]];
    }
    CGFloat width = 250.0f;
    CGFloat height = 204.0f;
    CGRect frame = CGRectMake(((self.view.frame.size.width - width) / 2), ((self.view.frame.size.height - height) /2), width, height);
    grabLocation.view.frame = frame;
    grabLocation.menu = self;
    grabLocation.locations = coordsArray;
    [self.view addSubview:grabLocation.view];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (located) {
        return [nearbyLocations count];    
    }else{
        return [namesArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Set up the cells one by one. If we're searching then use the returned results array to load into the table, if not use all stories
    int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
    
    if(located){
        cell.textLabel.text = [[nearbyLocations objectAtIndex:storyIndex] valueForKey:@"name"];
      //  cell.detailTextLabel = [[nearbyLocations objectAtIndex:storyIndex] valueForKey:@"distance"];
    }else{
    cell.textLabel.text = [namesArray objectAtIndex:storyIndex];
    }
    return cell;
}

-(void)autoLocated:(id)sender{
    [grabLocation.view removeFromSuperview];
    [grabLocation release];
    grabLocation = nil;
    located = TRUE;
    [searchtable reloadData];
    nearby.hidden = NO;
    searchtable.hidden = NO;
    notwhatlooking.hidden = NO;
    manual.hidden = NO;
}

-(void)manualEntry:(id)sender{
    [grabLocation.view removeFromSuperview];
    [grabLocation release];
    grabLocation = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
