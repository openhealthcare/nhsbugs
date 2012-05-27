//
//  ViewController.h
//  NHSBugs
//
//  Created by Colin Wren on 26/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GetLocation;
@class HospitalView;

@interface ViewController : UIViewController<UISearchBarDelegate>{
    IBOutlet UITableView *searchtable;
    NSDictionary *hospitalJSON;
    NSMutableArray *namesArray, *coordsArray, *nearbyLocations;
    GetLocation *grabLocation;
    HospitalView *hospitalDetail;
    BOOL located;
    IBOutlet UILabel *nearby, *notwhatlooking;
    IBOutlet UIButton *manual;
}
@property(nonatomic, retain) NSMutableArray *nearbyLocations;
-(void)autoLocated:(id)sender;
-(void)manualEntry:(id)sender;
-(IBAction)manualSearch:(id)sender;
@end
