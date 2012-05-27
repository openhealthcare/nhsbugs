//
//  BugDetail.m
//  NHSBugs
//
//  Created by Colin Wren on 27/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BugDetail.h"

@implementation BugDetail
@synthesize title, description, pic, reportDate, status;

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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.nhsbugs.net%@",pic]];
    NSURLRequest *updateReq = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    picDownload = [[NSURLConnection alloc] initWithRequest:updateReq delegate:self];
    if(picDownload){
        picData = [[NSMutableData data] retain];
    }
    descriptiontext.text = description;
    datedisplay.text = [reportDate substringToIndex:10];
    
    
    
    
    statusdisplay.text = status;
    
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //Need to reset the data
    [picData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [picData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
}

//If the connection has finished loading
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [connection release];
    UIImage *myImage = [UIImage imageWithData:picData];
    bugPic.image = myImage;
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
