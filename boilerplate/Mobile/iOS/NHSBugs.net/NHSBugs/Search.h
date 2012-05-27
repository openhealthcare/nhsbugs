//
//  Search.h
//  NHSBugs
//
//  Created by Colin Wren on 27/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Overlay;

@interface Search : UIViewController<UISearchBarDelegate>{
    IBOutlet UITableView *table;
    IBOutlet UINavigationBar *navbar;
    UISearchBar *search;
    Overlay *searchOverlay;
    BOOL searching;
    NSMutableArray *names, *searchStories;
    NSMutableDictionary *hospitalJSON;
}

-(IBAction)hide:(id)sender;

@end
