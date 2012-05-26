//
//  ViewController.m
//  NHSBugs
//
//  Created by Colin Wren on 26/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "GetLocation.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    dummyarray = [[NSMutableArray alloc] init];
    [dummyarray addObject:@"St George's Hospital"];
    [dummyarray addObject:@"Queen Mary's Hospital"];
    [dummyarray addObject:@"St Thomas' Hospital"];
    [dummyarray addObject:@"St Helier Hospital"];
    
    //Load the location getter
    if(grabLocation == nil){
    grabLocation = [[GetLocation alloc] initWithNibName:@"GetLocation" bundle:[NSBundle mainBundle]];
    }
    CGFloat yaxis = 0;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGRect frame = CGRectMake(0, yaxis, width, height);
    grabLocation.view.frame = frame;
    [self insertSubview:grabLocation.view aboveSubview:self.];
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
    return [dummyarray count];
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
   
    cell.textLabel.text = [dummyarray objectAtIndex:storyIndex];
    return cell;
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
