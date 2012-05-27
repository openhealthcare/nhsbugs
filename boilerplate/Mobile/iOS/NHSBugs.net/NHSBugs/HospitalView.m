//
//  HospitalView.m
//  NHSBugs
//
//  Created by Colin Wren on 27/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HospitalView.h"
#import "JSONKit.h"
#import "Annotation.h"
#import "BugDetail.h"
#import "UploadBug.h"

@implementation HospitalView
@synthesize title, longitude, latitude, map;

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
    self.navigationController.title = title;
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Add bug" style:UIBarButtonItemStylePlain target:self action:@selector(upload:)];          
    self.navigationItem.rightBarButtonItem = anotherButton;
    [anotherButton release];
    
    
    NSURLRequest *updateReq = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.nhsbugs.net/api/v1/bug/?format=json&q=%@", [NSString stringWithFormat:@"%@",[[title stringByReplacingOccurrencesOfString:@" " withString:@"-"] lowercaseString]]]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    bugslist = [[NSMutableArray alloc] init];
    bugdetaillist = [[NSMutableArray alloc] init];
    descriptlist = [[NSMutableArray alloc] init];
    piclist = [[NSMutableArray alloc] init]; 
    reportDatelist = [[NSMutableArray alloc] init];
    statuslist = [[NSMutableArray alloc] init];
    
    updates = [[NSURLConnection alloc] initWithRequest:updateReq delegate:self];
    if(updates){
        updateData = [[NSMutableData data] retain];
    }
    
    map.delegate = self;
    [self location];
    [self marker];
}

-(void)location{
    MKCoordinateRegion region;
    region.center.longitude =  [longitude doubleValue];
    region.center.latitude = [latitude doubleValue];
    region.span.longitudeDelta = 0.005555;
    region.span.latitudeDelta = 0.005555;
    [self.map setRegion:region];
}

-(void)marker{
    CLLocationCoordinate2D coord;
    
    coord.latitude = [latitude doubleValue];
    coord.longitude = [longitude doubleValue];
    Annotation *marker = [[Annotation alloc] initWithCoordinate:coord];
    marker.title = title;
    [self.map addAnnotation:marker];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //Need to reset the data
    [updateData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [updateData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
}

//If the connection has finished loading
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [connection release];
    NSString *server = [[NSString alloc] initWithData:updateData encoding:NSUTF8StringEncoding];
    updatesDict = [server objectFromJSONString];
    
    for (int i = 0; i < [[[updatesDict valueForKey:@"meta"] valueForKey:@"total_count"] intValue]; i++) {
        [bugslist addObject:[NSString stringWithFormat:[[[updatesDict valueForKey:@"objects"] valueForKey:@"title"]objectAtIndex:i]]];
        [descriptlist addObject:[NSString stringWithFormat:[[[updatesDict valueForKey:@"objects"] valueForKey:@"description"]objectAtIndex:i]]];
        if([[[updatesDict valueForKey:@"objects"] valueForKey:@"pic"]objectAtIndex:i] != [NSNull null]){
            [piclist addObject:[NSString stringWithFormat:[[[updatesDict valueForKey:@"objects"] valueForKey:@"pic"]objectAtIndex:i]]];
        }else{
            [piclist addObject:@"/media/img/logo.png"];
        }
        [reportDatelist addObject:[NSString stringWithFormat:[[[updatesDict valueForKey:@"objects"] valueForKey:@"report_date"]objectAtIndex:i]]];
        [statuslist addObject:[NSString stringWithFormat:[[[updatesDict valueForKey:@"objects"] valueForKey:@"status"]objectAtIndex:i]]];
    }
    [bugs reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return [bugslist count];
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
    
    cell.textLabel.text = [bugslist objectAtIndex:storyIndex];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    bug = [[BugDetail alloc] initWithNibName:@"BugDetail" bundle:nil];
    bug.title = [bugslist objectAtIndex:indexPath.row];
    bug.description = [descriptlist objectAtIndex:indexPath.row];
    bug.reportDate = [reportDatelist objectAtIndex:indexPath.row];
    bug.pic = [piclist objectAtIndex:indexPath.row];
    bug.status = [statuslist objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:bug animated:YES];
    [bug release];
    bug = nil;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:nil action:nil];
}

-(void)upload:(id)sender{
    uploadbug = [[[UploadBug alloc] init] autorelease];
    [self presentModalViewController:uploadbug animated:YES];
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
