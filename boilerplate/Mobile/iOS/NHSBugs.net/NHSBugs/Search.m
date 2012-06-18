//
//  Search.m
//  NHSBugs
//
//  Created by Colin Wren on 27/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Search.h"
#import "Overlay.h"
#import "JSONKit.h"
@implementation Search

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
    search = [[UISearchBar alloc]initWithFrame:CGRectMake(0,0,320,40)];
    search.delegate = self;
    [table setTableHeaderView:search];
    searching = NO;
    
    //Load the JSON file containing the hospitals and create array
    NSString *hospitallist = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hospitals" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    hospitalJSON = [hospitallist objectFromJSONString];
    
    names = [[NSMutableArray alloc] init];
    searchStories = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [hospitalJSON count]; i++) {
        [names addObject:[NSString stringWithFormat:[[hospitalJSON valueForKey:@"name"]objectAtIndex:i]]];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (searching) {
        return [searchStories count];    
    }else{
        return [names count];
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
    
    if(searching){
        cell.textLabel.text = [
                               searchStories objectAtIndex:storyIndex];
    }else{
        cell.textLabel.text = [names objectAtIndex:storyIndex];
    }
    return cell;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBare{
    
    //If the user is already searching then we don't need to run the code
    if(searching)
        return;
    
    //If there's no search overlay then we need to create one
    if(searchOverlay == nil){
		searchOverlay = [[Overlay alloc] initWithNibName:@"Overlay" bundle:[NSBundle mainBundle]];
	}
	CGFloat yaxis = 0;
	CGFloat width = self.view.frame.size.width;
	CGFloat height = self.view.frame.size.height;
	CGRect frame = CGRectMake(0, yaxis, width, height);
	searchOverlay.view.frame = frame;	
	searchOverlay.view.backgroundColor = [UIColor grayColor];
	searchOverlay.view.alpha = 0.5;
	[self->table insertSubview:searchOverlay.view aboveSubview:self.parentViewController.view];
    
    //We then set the user's searching status to true and disable scrolling on the table
    searching = YES;
	table.scrollEnabled = NO;
    
    // Setup the cancel button for when the user is searching and wants to stop searching
    /*self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
											   initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
											   target:self action:@selector(doneSearching_Clicked:)] autorelease];*/
    search.autocorrectionType = UITextAutocorrectionTypeNo;
    // clear the previous search content so there's a fresh start
    [searchStories removeAllObjects];
}

//When the user starts entering text into the search bar
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    //Clear the return search stories array
    [searchStories removeAllObjects];
    
    //If there's nothing entered into the searchbar we aren't searching but we want to show the data greyed out
    if([searchText isEqualToString:@""]){
        searching = NO;
        [self->table reloadData];
        [self->table insertSubview:searchOverlay.view aboveSubview:self.parentViewController.view];
        table.scrollEnabled = YES;
        return;
        
        //If there something entered then we need to remove the overlay and run a search, saving all results to an array and reload the tables data
    }else{
        [searchOverlay.view removeFromSuperview];
        NSInteger counter = 0;
        for(NSString *name in names){
            NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
            NSString *stringatCounter = [NSString stringWithFormat:@"%@", [names  objectAtIndex:counter]];
            stringatCounter = [stringatCounter lowercaseString];
            NSString *lowerSearch = [searchText lowercaseString];
            NSRange r = [stringatCounter rangeOfString:lowerSearch];
            if(r.location != NSNotFound)
                [searchStories addObject:name];
            NSLog(@"%@", searchStories);
            counter++;
            [pool release];
        }
        searching = YES;
        table.scrollEnabled = YES;
        [table reloadData];
    }
}

//If the user presses the cancel button while searching
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBare{
    
    // if a valid search was entered but the user wanted to cancel, bring back the main list content
    [searchStories removeAllObjects];
    [searchStories addObjectsFromArray:names];
    
    //try and reload the data
    @try{
        [table reloadData];
    }
    @catch(NSException *e){}
    
    //go back the list, clear the search text and enabled scrolling
    [search resignFirstResponder];
    search.text = @"";
    table.scrollEnabled = YES;
}

// called when Search (in our case “Done”) button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBare{
    [search resignFirstResponder];
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

-(void)hide:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

@end
