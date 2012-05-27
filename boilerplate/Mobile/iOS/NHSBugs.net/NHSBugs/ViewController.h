//
//  ViewController.h
//  NHSBugs
//
//  Created by Colin Wren on 26/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GetLocation;

@interface ViewController : UIViewController<UISearchBarDelegate>{
    IBOutlet UITableView *searchtable;
    NSDictionary *hospitalJSON;
    NSMutableArray *namesArray, *coordsArray, *nearbyLocations;
    GetLocation *grabLocation;
    BOOL located;
    IBOutlet UILabel *nearby, *notwhatlooking;
    IBOutlet UIButton *manual;
}
@property(nonatomic, retain) NSMutableArray *nearbyLocations;
-(void)autoLocated:(id)sender;
-(void)manualEntry:(id)sender;
@end
